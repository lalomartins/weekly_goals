import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db.dart';
import 'section_title.dart';

class MiniWeekReport extends StatelessWidget {
  final DateTime start;
  final int weeksAgo;
  const MiniWeekReport({
    Key key,
    this.start,
    this.weeksAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);

    return StreamBuilder<List<Goal>>(
      // TODO calculate the goals for past weeks properly
      stream: _dbProvider.watchCurrentGoals(),
      builder: (context, goalsSnapshot) {
        final currentGoals = goalsSnapshot.data ?? [];
        final sortedGoals = Goal.sortByCategory(currentGoals);
        final categories = sortedGoals.keys.toList();

        return StreamBuilder<List<Event>>(
          stream: _dbProvider.watchWeekEvents(type: 'weekly goals', weeksAgo: weeksAgo),
          builder: (context, eventsSnapshot) {
            if (eventsSnapshot.hasData && currentGoals.length != 0)
              Goal.computeProgress(currentGoals, eventsSnapshot.data);

            return Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('TODO: current goals are displayed, actual week goals might have been different',
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
                          if (goal.currentProgress >= goal.perWeek)
                            color = Colors.green;
                          else
                            color = Colors.red;
                        }
                        final style = TextStyle(color: color);
                        return Padding(
                          padding: ListTileTheme.of(context).contentPadding ??
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
                                                            FontWeight.bold)),
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
          },
        );
      },
    );
  }
}
