import 'package:flutter/material.dart';
import 'package:myapp/config/app_constants.dart';

import '../config/theme.dart';
import '../widgets/custom_app_bar.dart';
import 'announcement_screen.dart';
import 'settings_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentPageIndex = 0;

  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'Activity 1',
      'time': '10:00 AM',
      'icon': Icons.check_circle_outline,
      'color': Colors.green
    },
    {
      'title': 'Activity 2',
      'time': '11:30 AM',
      'icon': Icons.warning,
      'color': Colors.orange
    },
    {
      'title': 'Activity 3',
      'time': '02:00 PM',
      'icon': Icons.error_outline,
      'color': Colors.red
    },
    {
      'title': 'Activity 4',
      'time': '04:45 PM',
      'icon': Icons.check_circle_outline,
      'color': Colors.green
    },
  ];

  final List<Widget> _widgetOptions = <Widget>[
    Container(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: 4,
          itemBuilder: (context, index) => _buildCard(index),
        )),
    ProfileScreen(),
    const Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() => _currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(title: 'Dashboard'),
       drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1)),
            child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
            _createDrawerItem(
              icon: Icons.dashboard,
              text: MenuName.home.value,
              onTap: () {               
                _onItemTapped(0);
                Navigator.pop(context);
              },
              isSelected: _currentPageIndex == 0,
            ),
            _createDrawerItem(
              icon: Icons.announcement, 
              text: MenuName.announcement.value,
              onTap: () {
                setState(() {
                  _currentPageIndex = -1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnnouncementScreen()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.notifications, 
              text: MenuName.notification.value,
              onTap: () {
                 setState(() {
                  _currentPageIndex = -1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.settings, 
              text: MenuName.settings.value,
              onTap: () {
                setState(() {
                  _currentPageIndex = -1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.help,
              text: "Help", 
              onTap: () {
                // Handle help
              },
            ),
           const Divider(),
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: "Logout", 
              onTap: () {
                 setState(() {
                  _currentPageIndex = -1;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
             ),
          ],
        ),
      ),
        body: _widgetOptions.elementAt(_currentPageIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.primaryColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: MenuName.home.value),
          BottomNavigationBarItem(icon: const Icon(Icons.announcement), label: MenuName.announcement.value),
           BottomNavigationBarItem(icon: const Icon(Icons.notifications), label: MenuName.notification.value),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.primaryColor : AppTheme.inactiveColor,
      ),
      title: Text(text),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      selectedColor: AppTheme.primaryColor,
      selected: isSelected,
    );
  }

  Widget _buildCard(int index) {
      final activity = _activities[index];
    return Card(
      child: ListTile(
        leading: Icon(activity['icon'], size: 32, color: activity['color']),
        title: Text(activity['title'],
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle:
            Text(activity['time'], style: TextStyle(color: Colors.grey[600])),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}