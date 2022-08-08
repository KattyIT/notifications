import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'notification_scheduled.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotificationsPage(),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  //объект уведомления
  late FlutterLocalNotificationsPlugin localNotifications;

  //static final _notifications = FlutterLocalNotificationsPlugin();

  //инициализация
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    //объект для Android настроек
    const androidInitialize = AndroidInitializationSettings('ic_launcher');
    //объект для IOS настроек
    const iOSInitialize = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    // общая инициализация
    const initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    //мы создаем локальное уведомление
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Нажми на кнопку, чтобы получить уведомление'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            NotificationScheduled.showScheduledNotification(
              title: "Reminder",
              body: "Programming for 30 min",
              scheduledDate: DateTime.now().add(const Duration(seconds: 7)),
              //_showNotificationPeriodically,
              child: const Icon(Icons.notifications),
            ),
      ),
    );
  }
}


  // Future _showNotificationPeriodically() async {
  //   const androidDetails = AndroidNotificationDetails(
  //     "ID",
  //     "Название уведомления",
  //     importance: Importance.high,
  //     channelDescription: "Контент уведомления",
  //   );
  //
  //   const iosDetails = IOSNotificationDetails();
  //   const generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   await localNotifications.periodicallyShow(
  //     0,
  //     "Reminder",
  //     "Programming for 30 min",
  //     TZDateTime.now(local).add(const Duration(seconds: 7)),
  //     generalNotificationDetails,
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //   );
  // }