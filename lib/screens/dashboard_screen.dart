import 'package:flutter/material.dart';
import 'announcement_screen.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[
        const Center(
          child: Text(
            'Home Screen',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
         ProfileScreen(),
    const Center(
          child: Text(
            'Settings Screen',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }







  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("John Doe", style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text("john.doe@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue[800]),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[800],
              ),
            ),
            _createDrawerItem(
                icon: Icons.dashboard,
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Navigator.pop(context);
                },
              isSelected: true,
            ),
            _createDrawerItem(
              icon: Icons.announcement,

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnnouncementScreen()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.notifications,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotificationScreen()));
              },
            ),
            _createDrawerItem(
                icon: Icons.settings,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()));
                }),
            _createDrawerItem(
                icon: Icons.help,
                onTap: () {
                  // Handle help
                }),
            Divider(),
            _createDrawerItem(
                icon: Icons.exit_to_app,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required GestureTapCallback onTap, bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue[800] : Colors.grey[700]),

      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),

      selectedColor: Colors.blue[800],
      selected: isSelected,
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue[800]),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(time, style: TextStyle(color: Colors.grey[600])),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }

}