import 'package:desuungapp/screens/footer.dart';
import 'package:flutter/material.dart';
import './login_form.dart';
import './forgot_password_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../announcement/announcement_before_login_screen.dart';
import '../notification/news_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40), // Reduced vertical padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: const LoginForm(),
                  ),
                  const SizedBox(height: 24), // Reduced this space
                  const CopyrightText(),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(243, 239, 239, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Text('Menu', style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
            ),
            ListTile(
              leading: const Icon(Icons.article, color: Colors.black),
              title: const Text('News', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement, color: Colors.black),
              title: const Text('Announcements', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnouncementBeforeLoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}