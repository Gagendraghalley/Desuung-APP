import 'package:desuungapp/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../config/theme.dart';
import 'announcement_screen.dart'; // Keep AnnouncementScreen import if still used in drawer or elsewhere
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';
import 'attendance_screen.dart';

import '../config/app_constants.dart';

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
    const Center(child: Text('Home Screen Content')), // Placeholder for Home screen content
    AnnouncementScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  
   void _logOut() {
    print("logging out");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    print("Logout");
  }

  List<Widget> _buildWidgetOptions() {
    return _widgetOptions;
  }
  
   Widget _buildActivityGrid(List<Map<String, dynamic>> activities) {
    return const Center(child: Text('Empty screen'),);
    // return Container(
    //   padding: const EdgeInsets.all(16.0),
    //   child: GridView.builder(
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       crossAxisSpacing: 16,
    //       mainAxisSpacing: 16,
    //       childAspectRatio: 1.5,
    //     ),
    //     itemCount: activities.length,
    //     itemBuilder: (context, index) => _buildCard(activities[index]),
    //   ),
    // );
  }

  void _onItemTapped(int index) {
    setState(() => _currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    int _notificationCount = 5; // Example notification count

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Dashboard', // You can change this title as needed
          actions: [
            Stack( // Use Stack to position the badge over the icon
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                  },
                ),
                if (_notificationCount > 0) // Only show badge if count > 0
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text(
                        '$_notificationCount',
                        style: const TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ]),
        drawer: Drawer(
          backgroundColor: AppTheme.lightTheme.canvasColor.withOpacity(0.8),
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.primaryColor,
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: AppTheme.lightTheme.primaryColor),
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
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnnouncementScreen()),
                  );
                },
              ),

                _createDrawerItem(
                icon: Icons.calendar_today,
                text: "Attendance",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AttendanceScreen()),
                  );
                },),
              const Divider(),
              _createDrawerItem(
                icon: Icons.logout,
                text: MenuName.logout.value,
                onTap: () {
                  _logOut();
                },
              ),
            ],
          ),
        ),
        body: _buildWidgetOptions().elementAt(_currentPageIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.lightTheme.primaryColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.announcement), label: 'Announcement'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: _currentPageIndex,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          onTap: _onItemTapped,
        ));
    
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
        color: isSelected ? AppTheme.lightTheme.primaryColor : AppTheme.inactiveIconColor,
      ),
      title: Text(text),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    selectedColor: AppTheme.lightTheme.primaryColor,
    selected: isSelected,
    );
  }

  Widget _buildCard(Map<String, dynamic> activity) {
    
    return Card(
      child: ListTile(
        leading: Icon(activity['icon'], size: 32, color: activity['color']),
        title: Text(activity['title'],
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(activity['time'],
            style: TextStyle(color: Colors.grey[600])),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}