import 'package:flutter/material.dart';
import 'package:flutter_exercises/shared_prefs_screen.dart';
import 'async_screen.dart';
import 'factorial_isolate_screen.dart';
import 'grid_view_screen.dart';
import 'list_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FactorialIsolateScreen(),



    );
  }
}
