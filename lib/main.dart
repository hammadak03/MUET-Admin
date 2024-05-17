import 'package:flutter/material.dart';
import 'package:muet_app_admin/screens/home_screen.dart';
import 'package:muet_app_admin/screens/update_events_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: UpdateEventsScreen(),
    );
  }
}