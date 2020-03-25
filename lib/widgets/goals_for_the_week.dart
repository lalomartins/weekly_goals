import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db.dart';
import 'section_title.dart';

// hardcoded for now
class Goal {
  final String name;
  final String category;
  final int perWeek; // use null for a soft goal
  final bool dailyAmountMatters; // false if you want to do it N *days* per week rather than N times
  int currentProgress;

  Goal({this.name, this.category, this.perWeek, this.dailyAmountMatters = true}) : currentProgress = 0 {
    if (!dailyAmountMatters && perWeek > 7) {
      throw ArgumentError.value(perWeek, 'perWeek', "If the daily amount doesn't matter, a goal can't possibly be met more than 7 times in a week.");
    }
  }

  Goal.copy(Goal other, {bool resetProgress}) :
    name = other.name,
    category = other.category,
    perWeek = other.perWeek,
    dailyAmountMatters = other.dailyAmountMatters,
    currentProgress = resetProgress ? 0 : other.currentProgress;

  static void computeProgress(List<Goal> goals, List<Event> events) {}

  static Map<String, List<Goal>> sortByCategory(List<Goal> goals) {
    Map<String, List<Goal>> map = Map();
    goals.forEach((goal) {
      map.putIfAbsent(goal.category, () => <Goal>[]);
      map[goal.category].add(goal);
    });
    return map;
  }
}

final List<Goal> currentGoals = [
  Goal(name: 'strength training', category: 'Work out', perWeek: 10),
  Goal(name: 'resistance training', category: 'Work out', perWeek: null),
  // Goal(name: 'cardio', category: 'Work out', perWeek: null),
  Goal(name: '漢字勉強', category: '日本語', perWeek: 7, dailyAmountMatters: false),
  Goal(name: '読書', category: '日本語', perWeek: 2),
  Goal(name: '音楽で勉強', category: '日本語', perWeek: null),
  Goal(name: '語彙勉強', category: '日本語', perWeek: 7, dailyAmountMatters: false),
  Goal(name: 'fast', category: 'healthcare', perWeek: 3),
  Goal(name: 'game dev', category: 'life goals', perWeek: 2),
];
final sortedGoals = Goal.sortByCategory(currentGoals);
final categories = sortedGoals.keys.toList()..sort();

class GoalsForTheWeek extends StatelessWidget {
  const GoalsForTheWeek({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<EventDatabase>(context);

    return StreamBuilder<List<Event>>(
    stream: _dbProvider.watchRecentEvents(days: 7),
    builder: (context, snapshot) {
      if (snapshot.hasData)
        Goal.computeProgress(currentGoals, snapshot.data);

      return Column(
        children: <Widget>[
          Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
            ),
            child: Text('Goals for the week', style: Theme.of(context).primaryTextTheme.title),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentGoals.length + categories.length,
              itemBuilder: (context, index) {
                int i = -1;
                int category = 0;
                int categoryStart = 0;
                while (i++ < index) {
                  if (i - categoryStart > sortedGoals[categories[category]].length) {
                    categoryStart = i;
                    category++;
                  }
                }
                if (index == categoryStart) {
                  return SectionTitle(categories[category]);
                }
                Goal goal = sortedGoals[categories[category]][index - categoryStart - 1];
                if (goal != null) {
                  return Padding(
                    padding: ListTileTheme.of(context).contentPadding ?? EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(goal.name),
                        Spacer(),
                        RichText(textAlign: TextAlign.right, text: TextSpan(
                          children: [
                            TextSpan(text: (goal.currentProgress).toString()),
                          ] + (goal.perWeek == null ? [] : [
                            TextSpan(text: ('/'), style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: (goal.perWeek).toString()),
                          ]),
                          style: Theme.of(context).textTheme.body1,
                        )),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          )
        ],
      );
    });
  }
}
