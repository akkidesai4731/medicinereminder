import 'package:flutter/material.dart';
import 'medicinereminderhomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Reminder',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Customize font family
      ),
      home: WeeklyReminderScreen(),
    );
  }
}