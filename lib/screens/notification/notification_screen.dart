import 'package:desuungapp/config/theme.dart';
import 'package:flutter/material.dart';

import '../../config/app_constants.dart';

class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      time: '10:30 AM',
      isRead: false,
    ),
    NotificationItem(
      title: 'Event Reminder',
      description: 'Reminder: Meeting with the team at 2:00 PM.',
      time: 'Yesterday',
      isRead: true,
    ),
    NotificationItem(
      title: 'System Update',
      description: 'A new system update is available. Please update soon.',
      time: 'Mar 15',
      isRead: true,
    ),
  ];

   NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Center(
        child: Text('Notification Screen'),
      );
    
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final bool isRead;

   NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
  });
}

class NotificationListView extends StatelessWidget {
  final List<NotificationItem> notifications;

  const NotificationListView({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: NotificationTile(
            notification: notification,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: ${notification.title}')),
              );
            },
          ),
        );
      },
    );
  }
}

class NotificationTile extends StatefulWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      leading: CircleAvatar(
        backgroundColor: widget.notification.isRead ? AppTheme.inactiveIconColor : Theme.of(context).colorScheme.primary,
        child: Icon(
          _getNotificationIcon(widget.notification.title),
          color: widget.notification.isRead ? AppTheme.lightTheme.appBarTheme.foregroundColor : Colors.white,
          size: 20,  
        ),
       ),
     title: Text(
        widget.notification.title,
        style: TextStyle(
          fontWeight: widget.notification.isRead ? FontWeight.normal : FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.notification.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            widget.notification.time,
            style: TextStyle(color: AppTheme.lightTheme.appBarTheme.foregroundColor),
          ),
        ],
      ),
      trailing: !widget.notification.isRead
          ? Icon(
              Icons.circle,
              size: 12,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: widget.onTap,
    );
  }

  IconData _getNotificationIcon(String title) {
    switch (title) {
      case 'New Message':
        return Icons.message;
      case 'Event Reminder':
        return Icons.event;
      case 'System Update':
        return Icons.system_update;
      case 'Payment Received':
        return Icons.payment;
      case 'Account Security':
        return Icons.security;
      default:
        return Icons.notifications;
    }
  }
}
