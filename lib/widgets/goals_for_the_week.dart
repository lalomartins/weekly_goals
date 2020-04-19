import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../date_util.dart';
import '../db.dart';
import 'section_title.dart';


class GoalsForTheWeek extends StatelessWidget {
  const GoalsForTheWeek({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);
    final _weekDone = weekOffset() / 7;

    return StreamBuilder<List<Goal>>(
        stream: _dbProvider.watchCurrentGoals(),
        builder: (context, goalsSnapshot) {
          final currentGoals = goalsSnapshot.data ?? [];
          final sortedGoals = Goal.sortByCategory(currentGoals);
          final categories = sortedGoals.keys.toList();

          return StreamBuilder<List<Event>>(
              stream: _dbProvider.watchWeekEvents(type: 'weekly goals'),
              builder: (context, eventsSnapshot) {
                if (eventsSnapshot.hasData && currentGoals.length != 0)
                  Goal.computeProgress(currentGoals, eventsSnapshot.data);

                return Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Goals',
                            style: Theme.of(context).textTheme.caption),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentGoals.length + categories.length,
                        itemBuilder: (context, index) {
                          int i = -1;
                          int category = 0;
                          int categoryStart = 0;
                          while (i++ < index) {
                            if (i - categoryStart >
                                sortedGoals[categories[category]].length) {
                              categoryStart = i;
                              category++;
                            }
                          }
                          if (index == categoryStart) {
                            return SectionTitle(categories[category]);
                          }
                          Goal goal = sortedGoals[categories[category]]
                              [index - categoryStart - 1];
                          if (goal != null) {
                            Color color = Colors.black;
                            if (goal.perWeek == null) {
                              if (goal.currentProgress == 0)
                                color = Colors.grey;
                              else
                                color = Colors.blue;
                            } else {
                              final progressRatio =
                                  goal.currentProgress / goal.perWeek;
                              final progressLevel = progressRatio - _weekDone;
                              print(
                                  'Progress for ${goal.name} is ${goal.currentProgress}/${goal.perWeek}; ratio is ${progressRatio}, level is ${progressLevel}');
                              if (goal.currentProgress >= goal.perWeek)
                                color = Colors.green;
                              else if (progressLevel > 0)
                                color = Colors.black;
                              else if (progressLevel >= -(1 / 7))
                                color = Colors.yellow.shade700;
                              else if (progressLevel > -0.5)
                                color = Colors.orange.shade700;
                              else
                                color = Colors.red;
                            }
                            final style = TextStyle(color: color);
                            return Padding(
                              padding:
                                  ListTileTheme.of(context).contentPadding ??
                                      EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: <Widget>[
                                  Text(goal.name, style: style),
                                  Spacer(),
                                  RichText(
                                      textAlign: TextAlign.right,
                                      text: TextSpan(
                                        children: [
                                              TextSpan(
                                                  text: (goal.currentProgress)
                                                      .toString()),
                                            ] +
                                            (goal.perWeek == null
                                                ? []
                                                : [
                                                    TextSpan(
                                                        text: ('/'),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: (goal.perWeek)
                                                            .toString()),
                                                  ]),
                                        style: style,
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
        });
  }
}
