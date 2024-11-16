import 'package:flutter/material.dart'; // Ensure you import Material package for runApp
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class UtilFunctions {
  /// Schedules the next instance of the specified time on a given day.
  /// 
  /// [scheduledTime] is the time of day to schedule the notification.
  /// [day] is the day of the week to schedule the notification.
  tz.TZDateTime nextInstanceOfTime(TimeOfDay scheduledTime, DateTime day) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    
    // Create a scheduled date with the current year, month, and the specified day
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      day.day, // Use the day parameter to set the day of the month
      scheduledTime.hour,
      scheduledTime.minute,
    );

    // If the scheduled date is in the past, add one day to it
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeTimeZones(); // Initialize timezone data
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scheduled Notifications',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scheduled Notifications'),
        ),
        body: Center(
          child: Text('Welcome to Scheduled Notifications App'),
        ),
      ),
    );
  }
}