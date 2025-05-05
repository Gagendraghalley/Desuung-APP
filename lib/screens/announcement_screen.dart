import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/app_constants.dart';
import '../config/theme.dart';
import '../widgets/custom_app_bar.dart';
class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

// Sample data for announcements
class Announcement {
  final String title;
  final String description;
  final DateTime date;

  Announcement({required this.title, required this.description, required this.date});
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  // Sample announcement data
  final List<Announcement> announcements = [
    Announcement(
      title: 'Important Update',
      description: 'We have an important update regarding our services. Please read more to find out.',
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Announcement(
      title: 'New Feature Release',
      description: 'Exciting news! We have released a new feature that will help you manage your tasks more efficiently.',
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Announcement(
      title: 'System Maintenance',
      description: 'Our system will undergo maintenance on the coming Sunday. Access might be limited during this period.',
      date: DateTime.now().subtract(Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightTheme.scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight), child: CustomAppBar(title: MenuName.announcement.name)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return _buildAnnouncementCard(announcement);
            },),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(Announcement announcement) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
      ),
      elevation: 4.0, // Shadow effect
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              announcement.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(announcement.description),
            const SizedBox(height: 16),
            Text(
              DateFormat('dd MMMM yyyy').format(announcement.date), // Formatted date
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }}