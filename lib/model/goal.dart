import 'package:expire_cache/expire_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:yaml/yaml.dart';

import '../config.dart';
import '../date_util.dart';
import '../db.dart';

final _memCache = ExpireCache<DateTime, List<Goal>>(expireDuration: Duration(minutes: 15), sizeLimit: 52);

class Goal extends CachedGoal {
  String name;
  String category;
  int perWeek;
  bool dailyAmountMatters;
  int currentProgress;
  Event created, updated, removed;

  Goal({
    this.category,
    this.name,
    this.perWeek,
    this.dailyAmountMatters,
    this.created,
    this.updated,
  });

  Goal.copy(CachedGoal other, {bool resetProgress})
      : currentProgress = (other is Goal && !resetProgress) ? other.currentProgress : 0,
        name = other.name,
        category = other.category,
        perWeek = other.perWeek,
        dailyAmountMatters = other.dailyAmountMatters;

  static void computeProgress(List<Goal> goals, List<Event> events) {
    final Map<String, Goal> map = Map();
    final Map<String, Set<int>> weekdayChecks = Map();
    final dayOffset = config.dayOffset;
    goals.forEach((goal) {
      goal.currentProgress = 0;
      map[goal.name] = goal;
    });
    events.forEach((event) {
      final goal = map[event.name];
      if (goal == null) return;
      if (goal.dailyAmountMatters)
        goal.currentProgress++;
      else {
        weekdayChecks.putIfAbsent(goal.name, () => Set());
        final timestamp = event.timestamp.subtract(dayOffset);
        if (!weekdayChecks[goal.name].contains(timestamp.weekday)) {
          weekdayChecks[goal.name].add(timestamp.weekday);
          goal.currentProgress++;
        }
      }
    });
  }

  static Map<String, List<Goal>> sortByCategory(List<Goal> goals) {
    Map<String, List<Goal>> map = Map();
    goals.forEach((goal) {
      map.putIfAbsent(goal.category, () => <Goal>[]);
      map[goal.category].add(goal);
    });
    return map;
  }

  static Future<List<Goal>> goalsAsOf({DateTime when, @required WeeklyGoalsDatabase db, clearCache: false}) async {
    if (clearCache) _memCache.clear();
    else if (_memCache.containsKey(when)) return _memCache.get(when);

    final events = await db.getEvents(type: 'set goal', until: when);
    final map = Map<String, Map<String, Goal>>();
    final goals = List<Goal>();
    final effectDate = when ?? startOfWeek(weeksAgo: -1, midnight: true);
    for (final event in events) {
      final YamlMap data = loadYaml(event.additional);
      if (data['immediate'] == false && event.timestamp.add(Duration(days: 7)).isAfter(effectDate)) continue;
      final goal = map.putIfAbsent(data['category'], () => Map()).putIfAbsent(data['name'], () {
        final goal = Goal(
          category: data['category'],
          name: data['name'],
          perWeek: data['perWeek'],
          dailyAmountMatters: data['dailyAmountMatters'] ?? true,
          created: event,
        );
        goals.add(goal);
        return goal;
      });
      if (data['remove'] == true) {
        goal.removed = event;
      } else {
        goal.removed = null;
        goal.updated = event;
        if (data.containsKey('perWeek')) goal.perWeek = data['perWeek'];
        if (data.containsKey('dailyAmountMatters')) goal.dailyAmountMatters = data['dailyAmountMatters'] ?? false;
      }
    }

    goals.removeWhere((goal) => goal.removed != null);

    if (when != null) _memCache.set(when, goals);

    return goals;
  }
}
