import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Create Notification
Future<void> _showNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_ID',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    'Test Title',
    'Test Body',
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();