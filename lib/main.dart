import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'screens/dashboard_screen.dart';


void main() {
  runApp(const DeSuung());
}

class DeSuung extends StatelessWidget {
  const DeSuung({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      home: DashboardScreen(),
    );
  }
} 


