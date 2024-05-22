import 'package:flutter/material.dart';
import 'package:muet_app_admin/screens/home_screen.dart';
import 'package:muet_app_admin/screens/update_events_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MUET App Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/update-events': (context) => const UpdateEventsScreen(),
        // Add more routes here if needed
      },
    );
  }
}
