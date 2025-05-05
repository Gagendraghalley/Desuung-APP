import 'package:flutter/material.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
          // Optional: Customize specific colors
          primary: Colors.orange.shade800,
          secondary: Colors.orange.shade600,
        ),
        useMaterial3: true,
        // Additional orange-themed customizations
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange.shade800,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange.shade600,
        ),
      ),
      home: DashboardScreen(),
    );
  }
} 


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) { return Scaffold(body: _widgetOptions.first,); }
}
