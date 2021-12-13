import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init() async {
    var androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var settings = InitializationSettings(android: androidSettings);
    await _notification.initialize(
      settings,
      onSelectNotification: (payload) {},
    );
  }

  static void showNotification(
      int id, String title, String body, String payload) async {
    _notification.show(id, title, body, await _getNotificationDetails());
  }

  static Future _getNotificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'channel_name',
            priority: Priority.high));
  }
}
