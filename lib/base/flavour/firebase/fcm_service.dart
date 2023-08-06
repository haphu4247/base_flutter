// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// /// Create a [AndroidNotificationChannel] for heads up notifications
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   // 'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

// /// selection notification on foreground
// Future<dynamic> onSelectNotification(String? payload) async {}

// /// selection notification on foreground on ios for older ios version
// Future<void> onDidReceiveLocalNotification(
//     int id, String? title, String? body, String? payload) async {
//   onSelectNotification(payload);
// }

// Future<void> initialFirebaseBackgroundMessage() async {
//   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// }

// /// ================ END CONFIG FLUTTER LOCAL NOTIFICATION =================
// /// Singleton viewmodel use handle notification
// class FCMService {
//   static FCMService? _instance;

//   static FCMService getInstance() {
//     _instance ??= FCMService();
//     return _instance!;
//   }

//   FCMService();

//   StreamSubscription? foregroundMessageFcm;
//   StreamSubscription? messageOpenAppFcm;

//   initialFcm({required VoidCallback onReceiveFCMMessageCb}) async {
//     await _initializeFlutterNotification();
//     _firebaseMessagingForegroundHandler(onReceiveFCMMessageCb);
//     _onMessageOpenedApp();
//     _getInitialMessage();
//     getToken();
//   }

//   _initializeFlutterNotification() async {
//     if (!kIsWeb) {
//       if (Platform.isAndroid) {
//         /// We use this channel in the `AndroidManifest.xml` file to override the
//         /// default FCM channel to enable heads up notifications.
//         /// This is need for display notification
//         await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.createNotificationChannel(channel);
//       }

//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');

//       const DarwinInitializationSettings initializationSettingsIOS =
//           DarwinInitializationSettings(
//               onDidReceiveLocalNotification: onDidReceiveLocalNotification);

//       const InitializationSettings initializationSettings =
//           InitializationSettings(
//               android: initializationSettingsAndroid,
//               iOS: initializationSettingsIOS);

//       flutterLocalNotificationsPlugin.initialize(initializationSettings,
//           onDidReceiveNotificationResponse: onSelectNotification);

//       final notificationDetail = await flutterLocalNotificationsPlugin
//           .getNotificationAppLaunchDetails();
//       if (notificationDetail != null &&
//           notificationDetail.didNotificationLaunchApp &&
//           notificationDetail.payload != null) {
//         /// in case of user in foreground mode => swipe to close the app =>
//         /// then tap to notification that was created by LocalNotification
//         /// call message open app by LocalNotification

//         RemoteMessage remoteMessage = RemoteMessage(
//             data: jsonDecode(notificationDetail.payload ?? '')
//                 as Map<String, dynamic>);
//         _handleNotificationData(remoteMessage,
//             handleNotificationType: HandleNotificationType.MESSAGE_OPEN_APP);
//       }
//     }
//   }

//   /// test function
//   getToken() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     final fcmToken = await messaging.getToken();

//     // var authenticationDao = serviceLocator<AuthenticationDao>();
//     // var user = await authenticationDao.getUser();
//     print('-----------get token');
//     // print(user!.toJson());
//     print(fcmToken);
//   }

//   void _getInitialMessage() {
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         _handleNotificationData(message,
//             handleNotificationType: HandleNotificationType.MESSAGE_OPEN_APP);
//       }
//     });
//   }

//   void _onMessageOpenedApp() {
//     messageOpenAppFcm =
//         FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _handleNotificationData(message,
//           handleNotificationType: HandleNotificationType.MESSAGE_OPEN_APP);
//     });
//   }

//   Future<void> _firebaseMessagingForegroundHandler(
//       VoidCallback onReceiveFCMMessageCb) async {
//     foregroundMessageFcm =
//         FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       onReceiveFCMMessageCb();
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? androidNotification = message.notification?.android;
//       AppleNotification? appleNotification = message.notification?.apple;

//       if (notification != null &&
//           ((androidNotification != null && Platform.isAndroid) ||
//               appleNotification != null && Platform.isIOS)) {
//         showNotification(notification, message.data);
//       }
//       _handleNotificationData(message,
//           handleNotificationType: HandleNotificationType.FOREGROUND);
//     });
//   }

//   ///
//   static void _handleNotificationData(RemoteMessage remoteMessage,
//       {required HandleNotificationType handleNotificationType}) {
//     AndroidNotification? androidNotification =
//         remoteMessage.notification?.android;
//     AppleNotification? appleNotification = remoteMessage.notification?.apple;
//     Map<String, dynamic> data = remoteMessage.data;

//     /// In case of in background mode.
//     /// The app receive notification =>swipe the screen to close the app in background mode
//     /// Click to the notification to open app
//     /// => Android notification null in this case => don't check android notification or apple notification field
//     /// https://stackoverflow.com/a/40083727/16066921
//     if (Platform.isAndroid && (data.isEmpty)) {
//       return;
//     }

//     if (Platform.isIOS && data.isEmpty) {
//       return;
//     }

//     ///navigate
//   }

//   void showNotification(
//       RemoteNotification? notification, Map<String, dynamic> data) async {
//     if (notification == null) {
//       return;
//     }

//     if (Platform.isAndroid) {
//       /// flutter android notification does not work
//       /// show in the foreground message in some case
//       flutterLocalNotificationsPlugin.show(
//           hashCode,
//           notification.title,
//           notification.body.toString(),
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               icon: '@mipmap/ic_launcher',
//               subText: notification.body.toString(),
//             ),
//           ),
//           payload: json.encode({}));
//     } else if (Platform.isIOS) {
//       /// on ios it will not handle foreground need to handle
//       final bool? result = await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//       flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           const NotificationDetails(
//               iOS: IOSNotificationDetails(
//             subtitle: '',
//           )),
//           payload: json.encode(data));
//     }
//   }

//   void dispose() {
//     if (foregroundMessageFcm != null) {
//       foregroundMessageFcm!.cancel();
//     }
//     if (messageOpenAppFcm != null) {
//       messageOpenAppFcm!.cancel();
//     }
//   }
// }

// enum HandleNotificationType { FOREGROUND, BACKGROUND, MESSAGE_OPEN_APP }
