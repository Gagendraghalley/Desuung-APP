import 'package:desuungapp/screens/attendance/attendance_index.dart';
import 'package:desuungapp/screens/events/events_index.dart';
import 'package:flutter/material.dart';
import 'package:desuungapp/widgets/custom_app_bar.dart';
import '../../config/theme.dart';
import '../announcement/announcement_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';
import '../settings_screen.dart';
import '../login/login_screen.dart';
import '../attendance/attendance_screen.dart';
import '../../config/app_constants.dart';

enum ActiveMenu {
  home,
  attendance,
  events,
  skillingProgram,
  announcements,
  profile,
  settings,
  logout
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentPageIndex = 0;
  ActiveMenu _activeMenu = ActiveMenu.home;
  final Color _accentColor = const Color.fromARGB(255, 230, 134, 44);
  final Color _backgroundColor = const Color.fromARGB(255, 248, 248, 248);

  final Map<int, String> _pageTitles = {
    0: 'Dashboard',
    1: 'Announcements',
    2: 'Profile',
    3: 'Settings',
  };

  final Map<ActiveMenu, String> _menuTitles = {
    ActiveMenu.home: MenuName.home.value,
    ActiveMenu.attendance: "Attendance",
    ActiveMenu.events: "Events",
    ActiveMenu.skillingProgram: "Skilling Program",
    ActiveMenu.announcements: "Announcements",
    ActiveMenu.profile: "Profile",
    ActiveMenu.settings: "Settings",
    ActiveMenu.logout: MenuName.logout.value,
  };

  final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Home Screen Content')),
    const AnnouncementScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: _buildAppBar(),
      drawer: _buildMaterialDrawer(),
      body: _buildContent(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    String title;
    if (_activeMenu == ActiveMenu.attendance) {
      title = _menuTitles[ActiveMenu.attendance]!;
    } else if (_activeMenu == ActiveMenu.events) {
      title = _menuTitles[ActiveMenu.events]!;
    } else if (_activeMenu == ActiveMenu.skillingProgram) {
      title = _menuTitles[ActiveMenu.skillingProgram]!;
    } else {
      title = _pageTitles[_currentPageIndex] ?? 'Dashboard';
    }

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      elevation: 2,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: _accentColor),
      actions: [_buildNotificationButton()],
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationScreen()),
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '10',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }

Widget _buildMaterialDrawer() {
  return Drawer(
    elevation: 16,
    width: MediaQuery.of(context).size.width * 0.75,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
    ),
    child: Column(
      children: [
        _buildDrawerHeader(),
        Expanded(child: _buildDrawerMenu()),
        _buildDrawerFooter(),
      ],
    ),
  );
}

  Widget _buildDrawerHeader() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.only(
          top: 28,
          bottom: 24,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _accentColor.withOpacity(0.12),
              _accentColor.withOpacity(0.08),
            ],
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.15),
              width: 1.2,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _accentColor.withOpacity(0.15),
                    _accentColor.withOpacity(0.25),
                  ],
                ),
                border: Border.all(
                  color: _accentColor.withOpacity(0.4),
                  width: 1.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    spreadRadius: 1.5,
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                'De-suung',
                style: const TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: Text(
                'desuung@gmail.com',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14.5,
                  letterSpacing: 0.1,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerMenu() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildDrawerItem(
          icon: Icons.dashboard_outlined,
          activeIcon: Icons.dashboard_rounded,
          text: _menuTitles[ActiveMenu.home]!,
          isActive: _activeMenu == ActiveMenu.home,
          onTap: () => _navigateToPage(0),
        ),
        _buildDrawerItem(
          icon: Icons.calendar_today_outlined,
          activeIcon: Icons.calendar_today_rounded,
          text: _menuTitles[ActiveMenu.attendance]!,
          isActive: _activeMenu == ActiveMenu.attendance,
          onTap: () => _navigateToScreen(
            const AttendanceIndexScreen(), 
            _menuTitles[ActiveMenu.attendance]!, 
            ActiveMenu.attendance
          ),
        ),
        _buildDrawerItem(
          icon: Icons.event_outlined,
          activeIcon: Icons.event_available_rounded,
          text: _menuTitles[ActiveMenu.events]!,
          isActive: _activeMenu == ActiveMenu.events,
          onTap: () => _navigateToScreen(
            const EventsIndex(), 
            _menuTitles[ActiveMenu.events]!, 
            ActiveMenu.events
          ),
        ),
        _buildDrawerItem(
          icon: Icons.model_training_outlined,
          activeIcon: Icons.model_training_rounded,
          text: _menuTitles[ActiveMenu.skillingProgram]!,
          isActive: _activeMenu == ActiveMenu.skillingProgram,
          onTap: () => _navigateToScreen(
            const AttendanceScreen(), 
            _menuTitles[ActiveMenu.skillingProgram]!, 
            ActiveMenu.skillingProgram
          ),
        ),
        const Divider(height: 1, indent: 20, endIndent: 20),
        _buildDrawerItem(
          icon: Icons.logout_outlined,
          activeIcon: Icons.logout_rounded,
          text: _menuTitles[ActiveMenu.logout]!,
          isLogout: true,
          isActive: _activeMenu == ActiveMenu.logout,
          onTap: _logOut,
        ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required IconData activeIcon,
    required String text,
    bool isActive = false,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        isActive ? activeIcon : icon,
        color: isLogout
            ? Colors.red[400]
            : isActive
                ? _accentColor
                : Colors.grey[700],
        size: 24,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: isLogout
              ? Colors.red[400]
              : isActive
                  ? Colors.black
                  : Colors.grey[700],
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isActive
          ? Icon(Icons.chevron_right, color: _accentColor, size: 18)
          : null,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: isActive ? _accentColor.withOpacity(0.05) : null,
    );
  }

  Widget _buildDrawerFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'v1.0.0',
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _widgetOptions[_currentPageIndex],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: _accentColor,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      currentIndex: _currentPageIndex,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      items: _buildNavItems(),
      onTap: (index) {
        setState(() {
          _currentPageIndex = index;
          _activeMenu = [
            ActiveMenu.home,
            ActiveMenu.announcements,
            ActiveMenu.profile,
            ActiveMenu.settings
          ][index];
        });
      },
    );
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.announcement_outlined),
        activeIcon: Icon(Icons.announcement_rounded),
        label: 'Announcement',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outlined),
        activeIcon: Icon(Icons.person_rounded),
        label: 'Profile',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined),
        activeIcon: Icon(Icons.settings_rounded),
        label: 'Settings',
      ),
    ];
  }

  void _navigateToPage(int index) {
    Navigator.pop(context);
    setState(() {
      _currentPageIndex = index;
      _activeMenu = [
        ActiveMenu.home,
        ActiveMenu.announcements,
        ActiveMenu.profile,
        ActiveMenu.settings
      ][index];
    });
  }

  void _navigateToScreen(Widget screen, String title, ActiveMenu menu) {
    Navigator.pop(context);
    setState(() => _activeMenu = menu);
    
    final index = _widgetOptions.indexWhere((w) => w.runtimeType == screen.runtimeType);
    if (index >= 0) {
      setState(() {
        _currentPageIndex = index;
        _activeMenu = menu;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    }
  }

  void _logOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}