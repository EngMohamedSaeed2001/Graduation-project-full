


import 'package:flutter/material.dart';
import 'package:semsark/utils/helper.dart';

import '../../components/notification_item.dart';
import '../../models/response/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: 'Notification 1',
      subtitle: 'This is the first notification',
      date: DateTime.parse('2023-04-30'),
    ),
    NotificationModel(
      title: 'Notification 2',
      subtitle: 'This is the second notification',
      date: DateTime.parse('2023-04-22'),
    ),
    NotificationModel(
      title: 'Notification 3',
      subtitle: 'This is the third notification',
      date: DateTime.parse('2023-04-29'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Helper.blue,
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return NotificationItem(
            notificationModel: notification,
          );
        },
      ),
    );
  }
}



