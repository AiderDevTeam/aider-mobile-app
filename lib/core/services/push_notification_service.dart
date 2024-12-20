import 'dart:convert';

import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/src/features/inbox/domain/models/chat/chat_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../routing/app_navigator.dart';
import '../routing/app_route.dart';
import 'local_notification_service.dart';

class PushNotificationService {
  static Future<void> configureForeground() =>
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  Future<String?> getFcmToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken;
    } catch (e) {
      return null;
    }
  }

  Future<void> setupInteractedMessage() async {
    await PushNotificationService.configureForeground();

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      final android = message.notification?.android;
      // final apple = message.notification?.apple;

      ZLoggerService.logOnInfo('push data -----  ${message.data}');

      if (notification != null) {
        if (android != null) {
          await LocalNotificationService()
              .showNotification(notification.hashCode, notification.title ?? '', notification.body ?? '', android.imageUrl, jsonEncode(message.data));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    ZLoggerService.logOnInfo('on message opened app');

    if (notification != null) {
      navigateToPage(AppNavigator.navigatorKey.currentContext!, data: message.data);
    }
  }

  void navigateToPage(BuildContext context, {var data}) {
    if (data['action'] != null && data['action'] == 'chat') {
      var jsonData = jsonDecode(data['resource']);
      AppNavigator.pushNamed(context, AppRoute.chatScreen, arguments: {
        'sent': false,
        'chat': ChatModel.fromJson(jsonData),
      });
      return;
    }
  }
}
