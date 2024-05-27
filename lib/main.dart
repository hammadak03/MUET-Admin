import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muet_app_admin/screens/home_screen.dart';
import 'package:muet_app_admin/screens/update_events_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MUET App Admin',
      debugShowCheckedModeBanner: false,
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
