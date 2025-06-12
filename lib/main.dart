import 'package:desuungapp/screens/attendance/attendance_index.dart';
import 'package:desuungapp/screens/login/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:desuungapp/config/theme.dart';
import 'package:desuungapp/screens/login/login_screen.dart';
import 'package:desuungapp/screens/attendance/attendance_screen.dart';
import 'package:desuungapp/screens/dashboard/dashboard_screen.dart';

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
      home: const BackgroundWrapper(child: SplashScreen()),
      routes: {
        '/attendance': (context) => const BackgroundWrapper(child: AttendanceIndexScreen()),
        '/dashboard': (context) => const BackgroundWrapper(child: DashboardScreen()),
      },
    );
  }
}

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  
  const BackgroundWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}