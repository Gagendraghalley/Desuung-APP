import 'package:flutter/material.dart';
import '../screens/change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => const Center(child: Text('Settings Screen'),);
  

  Widget _buildSettingsSection(BuildContext context) {
    return Card(
      color: const Color.fromARGB(0, 255, 255, 255),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.black),
            title: const Text('Change Password',
                style: TextStyle(fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()),
              );
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.black),
            title: const Text('Language',
                style: TextStyle(fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Handle language setting
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Card(
      color: Colors.transparent,
      child: ListTile(
        leading: const Icon(Icons.info_outline, color: Colors.black),
        title: const Text('About', style: TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Handle about section
        },
      ),
    );
  }
}