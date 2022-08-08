import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationScheduled {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "ID",
        "Название уведомления",
        importance: Importance.high,
        channelDescription: "Контент уведомления",
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String?body,
    required Icon child,
    required DateTime scheduledDate,
  }) async =>
      _notification.zonedSchedule(
        id,
        title,
        body,
        _scheduleDaily(Time(8)),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  static TZDateTime _scheduleDaily(Time time) {
    final now = TZDateTime.now(local);
     final scheduledDate = TZDateTime(local, now.year, now.month, now.day,
       time.hour, time.minute, time.second);

      return scheduledDate.isBefore(now)
          ? scheduledDate.add(const Duration(days: 1))
          : scheduledDate;
  }
}