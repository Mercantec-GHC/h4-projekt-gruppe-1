import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:guess_that_beatboxer/models/user.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal() {
    final initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> sendNotification(String title, String body) async {
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
      sendNotification('Welcome back ${user.name}', 'Ready to guess a beatboxer?');
    }
  }

  void onUserRegister(bool notificationsEnabled) {
    if (notificationsEnabled) {
      sendNotification('User registered', 'You have successfully registered');
    }
  }
}