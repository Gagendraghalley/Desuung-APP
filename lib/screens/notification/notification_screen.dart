import 'package:flutter/material.dart';
import 'package:desuungapp/config/theme.dart';

class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe about the upcoming project deadline.',
      time: '10:30 AM',
      isRead: false,
      icon: Icons.message,
    ),
    NotificationItem(
      title: 'Event Reminder',
      description: 'Team meeting scheduled for today at 2:00 PM in Conference Room B',
      time: 'Yesterday',
      isRead: true,
      icon: Icons.calendar_today,
    ),
    NotificationItem(
      title: 'System Update',
      description: 'New app version 2.3.0 is available with performance improvements',
      time: 'Mar 15',
      isRead: true,
      icon: Icons.system_update,
    ),
    NotificationItem(
      title: 'Payment Received',
      description: 'Your invoice #12345 has been paid successfully',
      time: 'Mar 14',
      isRead: false,
      icon: Icons.payment,
    ),
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle settings/mark all as read
            },
          ),
        ],
      ),
      body: NotificationListView(notifications: notifications),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    required this.icon,
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const Divider(height: 1, indent: 72),
      itemBuilder: (context, index) {
        return NotificationTile(
          notification: notifications[index],
          onTap: () {
            // Handle notification tap
          },
        );
      },
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: notification.isRead ? Colors.transparent : Theme.of(context).colorScheme.primary.withOpacity(0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead 
                    ? Colors.grey.withOpacity(0.2)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
              child: Icon(
                notification.icon,
                size: 20,
                color: notification.isRead 
                    ? Colors.grey[600]
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            // Notification Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        notification.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Unread indicator
            if (!notification.isRead) ...[
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}