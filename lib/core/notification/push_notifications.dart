import 'dart:convert';
import 'package:Yes_Loyalty/core/notification/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationsService {
  // Create an instance of the Firebase Messaging plugin
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize Firebase Messaging and request permission for notifications
  static Future<void> init() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    // Check if the permission is granted
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User  granted permission');
    } else {
      print('User  declined or has not accepted permission');
    }

    // Get the FCM (Firebase Cloud Messaging) token from the device
    try {
        String? token = await _firebaseMessaging.getToken();
        print('FCM Token: $token');
    } catch (e) {
        print('Error getting FCM token: $e');
    }
  }

  // Function that listens for incoming messages in the background
  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print('Background message: ${message.notification!.title}');
    }
  }

  // Handle background notification tapped (pass the payload data to the message opener screen)
  static Future<void> onBackgroundNotificationTapped(
      RemoteMessage message, GlobalKey<NavigatorState> navigatorKey) async {
    navigatorKey.currentState?.pushNamed('/message', arguments: message);
  }

  // Handle foreground notifications
  static Future<void> onForegroundNotificationTapped(
    RemoteMessage message,
    GlobalKey<NavigatorState> navigatorKey,
  ) async {
    String payloadData = jsonEncode(message.data);

    print("Got the message in foreground");

    if (message.notification != null) {
      // Show a local notification with the payload
      await LocalNotificationService.showInstantNotificationWithPayload(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );

      // Navigate to the message page when the notification is tapped
      await navigatorKey.currentState?.pushNamed('/message', arguments: message);
    }
  }
}