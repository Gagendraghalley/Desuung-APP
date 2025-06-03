import 'package:desuungapp/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'config/theme.dart';
import '../screens/login/login_screen.dart';
import 'screens/attendance/attendance_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';


void main() {
  runApp(const DeSuung());
}

class DeSuung extends StatelessWidget {
  const DeSuung({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desuung App',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      home: LoginScreen(),
      routes: {
        '/attendance': (context) => AttendanceScreen(),
      },
    );
  }
} 


