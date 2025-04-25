import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Message',
      'description': 'You have a new message from John Doe.',
    },
    {
      'title': 'Event Reminder',
      'description': 'Reminder: Meeting with the team at 2:00 PM.',
    },
    {
      'title': 'System Update',
      'description': 'A new system update is available. Please update soon.',
    },
        {
      'title': 'New Message',
      'description': 'You have a new message from John Doe.',
    },
    {
      'title': 'Event Reminder',
      'description': 'Reminder: Meeting with the team at 2:00 PM.',
    },
    {
      'title': 'System Update',
      'description': 'A new system update is available. Please update soon.',
    },
        {
      'title': 'New Message',
      'description': 'You have a new message from John Doe.',
    },
    {
      'title': 'Event Reminder',
      'description': 'Reminder: Meeting with the team at 2:00 PM.',
    },
    {
      'title': 'System Update',
      'description': 'A new system update is available. Please update soon.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                notifications[index]['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notifications[index]['description']!),
            ),
          );
        },
      ),
    );
  }
}