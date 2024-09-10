import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:guess_that_beatboxer/models/user.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

  Future<void> sendNotification(String title, String body,) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> showNotification(bool notificationsEnabled) async {
    if (!notificationsEnabled) return;
    await sendNotification('Test Title', 'Test Body');
  }

  void onUserLogin(bool notificationsEnabled, User user) {
    if (notificationsEnabled) {
      sendNotification('Welcome ${user.name} back', 'You have successfully logged in');
    }
  }
  void onUserRegister(bool notificationsEnabled, User user) {
    if (notificationsEnabled) {
      sendNotification('Welcome ${user.name} to Swishbeater boxer', 'You have successfully registered');
    }
  }
}