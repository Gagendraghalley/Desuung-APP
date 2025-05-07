import 'package:flutter/material.dart';

class AnnouncementBeforeLoginScreen extends StatelessWidget {
  const AnnouncementBeforeLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Before Login'),
      ),
      body: const Center(
        child: Text('Announcement Before Login Screen'),
      ),
    );
  }
}