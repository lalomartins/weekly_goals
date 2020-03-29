import '../db.dart';

class Goal extends CachedGoal {
  int currentProgress;

  Goal.copy(CachedGoal other, {bool resetProgress}) :
    currentProgress = (other is Goal && !resetProgress) ? other.currentProgress : 0,
    super(id: other.id, name: other.name, category: other.category, perWeek: other.perWeek, dailyAmountMatters: other.dailyAmountMatters);

  static void computeProgress(List<Goal> goals, List<Event> events) {
    Map<String, Goal> map = Map();
    Map<String, Set<int>> weekdayChecks = Map();
    goals.forEach((goal) {
      goal.currentProgress = 0;
      map[goal.name] = goal;
    });
    events.forEach((event) {
      final goal = map[event.name];
      if (goal.dailyAmountMatters)
        goal.currentProgress++;
      else {
        weekdayChecks.putIfAbsent(goal.name, () => Set());
        if (!weekdayChecks[goal.name].contains(event.timestamp.weekday)) {
          weekdayChecks[goal.name].add(event.timestamp.weekday);
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
}
