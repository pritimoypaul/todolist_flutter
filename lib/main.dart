import 'package:flutter/material.dart';
import 'package:todolist/todos.dart';
import 'package:todolist/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/todos': (context) => Todos(),
        '/auth': (context) => AuthUser(),
      },
      home: AuthUser(),
    );
  }
}
