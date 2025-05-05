import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          colorScheme: ColorScheme.light(
            primary: Colors.orange,
            background: Colors.orange.shade100,
            onPrimary: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.orange.shade800,
            foregroundColor: Colors.white,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.orange.shade800,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
          useMaterial3: true,
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
  static final List<Widget> _widgetOptions = <Widget>[DashboardScreen(),];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.first,
    );
  }
}
