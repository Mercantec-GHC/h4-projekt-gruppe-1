import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationButton extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationButton(this.flutterLocalNotificationsPlugin);

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  bool _notificationsEnabled = true;

  Future<void> _showNotification() async {
    if (!_notificationsEnabled) return;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await widget.flutterLocalNotificationsPlugin.show(
      0,
      'Test Title',
      'Test Body',
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  void _toggleNotifications() {
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: [
        ElevatedButton(
          onPressed: _showNotification,
          child: Text('Send Notification'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enable Notifications'),
            Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                _toggleNotifications();
              },
            ),
          ],
        ),
      ],
    );
  }
}