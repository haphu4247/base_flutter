import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:base_flutter/shared/utils/my_log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_model.dart';

abstract class IFcmProvider {
  factory IFcmProvider() {
    return _instance;
  }
  IFcmProvider._internal();

  Future<FirebaseApp> initFcm();

  Future<String?> getFcmToken(
      {required void Function(String fcmToken) onGetToken});

  //put in the place you want to handle action select on notification
  static void Function(NotificationModel notiModel)? onNotiSelect;
}

final _FcmProviderImpl _instance = _FcmProviderImpl();

class _FcmProviderImpl extends IFcmProvider {
  _FcmProviderImpl() : super._internal();

  static const String _notificationChannel = 'my_high_importance_channel';
  static const String _notificationChannelName =
      'High Importance Notifications';

  //add icon to Android folder: android/app/main/res/drawable
  static const String _androidIcon = 'logo';

  static final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  @override
  Future<FirebaseApp> initFcm() async {
    await _initializeFlutterNotification();
    return Firebase.initializeApp()
        .whenComplete(_listenFirebaseMessagingForeground);
  }

  @override
  Future<String?> getFcmToken(
      {required void Function(String fcmToken) onGetToken}) {
    return FirebaseMessaging.instance.getToken().then((fcmToken) {
      if (fcmToken != null && fcmToken.isNotEmpty) {
        MyLogger.d(this, 'fcmToken: $fcmToken');
        onGetToken(fcmToken);
      }
      return null;
    });
  }

  //This function receive data from Push Notification when app is in Forceground or Background
  StreamSubscription<RemoteMessage> _listenFirebaseMessagingForeground() {
    return FirebaseMessaging.onMessage.listen(_handleNotificationData);
  }

  Future<dynamic> _initializeFlutterNotification() async {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        final notificationPlugin =
            localNotifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        await notificationPlugin?.createNotificationChannel(
            const AndroidNotificationChannel(
                _notificationChannel, _notificationChannelName,
                importance: Importance.max));
      }

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings(_androidIcon);

      const initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );

      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      return localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _handleNotificationSelect,
        onDidReceiveBackgroundNotificationResponse: _handleNotificationSelect,
      );
    }
  }

  void launchAppFromNotification() {
    //check notification when app is opened by Notification.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        final notiResponse = message.data;
        _handleNotification(notiResponse);
      }
    });
  }

  static Future<void> _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    final RemoteNotification notification = RemoteNotification(
      title: title,
      body: body,
    );

    MyLogger.consoleToast(
        _FcmProviderImpl, 'onDidReceiveLocalNotification=>payload: $payload');
    return _showIosNotification(notification, id: id, data: payload);
  }

  static void _handleNotificationSelect(NotificationResponse notiResponse) {
    _handleNotification(notiResponse.payload);
  }

  static void _handleNotification(dynamic payload) {
    if (payload == null) {
      return;
    }
    final notification = NotificationModel.fromJson(payload);
    MyLogger.consoleToast(_FcmProviderImpl,
        'notification:=>${payload.toString()} \nnotification:${notification.toString()}');

    //handle event when user click on Notification
    IFcmProvider.onNotiSelect?.call(notification);
  }

  Future<void> _handleNotificationData(
    RemoteMessage remoteMessage,
  ) async {
    final Map<String, dynamic> data = remoteMessage.data;
    MyLogger.consoleToast(
        this, 'handleNotificationData=>remoteMessage: ${remoteMessage.data}');

    final notification = remoteMessage.notification;
    if (notification == null) {
      return;
    }

    if (Platform.isAndroid) {
      /// flutter android notification does not work
      /// show in the foreground message in some case
      await _showAndroidNotification(notification, data);
    } else if (Platform.isIOS) {
      await _showIosNotification(notification, data: data);
    } else {}
  }

  Future<void> _showAndroidNotification(
      RemoteNotification notification, Map<String, dynamic> data) async {
    final notificationPlugin =
        localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    final permission = await notificationPlugin?.areNotificationsEnabled();
    if (permission != true) {
      await notificationPlugin?.requestPermission();
    }
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _notificationChannel,
      _notificationChannelName,
      importance: Importance.max,
      priority: Priority.high,
      icon: _androidIcon,
    );
    localNotifications.show(
      hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(android: androidPlatformChannelSpecifics),
      payload: json.encode(data),
    );
  }

  static Future<void> _showIosNotification(
    RemoteNotification notification, {
    int id = 0,
    required dynamic data,
  }) async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
            presentBadge: true, threadIdentifier: 'lotte_cinema_noti');

    /// on ios it will not handle foreground need to handle
    final bool? result = await localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    if (result == true) {
      localNotifications.show(
        id,
        notification.title,
        notification.body,
        const NotificationDetails(
          iOS: iOSPlatformChannelSpecifics,
        ),
        payload: jsonEncode(data),
      );
    }
  }
}
