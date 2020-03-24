import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Goals',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('This week'),
                    ),
                    body: Center(
                      child: Container(),
                    ),
                  ),
            });
  }
}
