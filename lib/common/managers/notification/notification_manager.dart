import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/modal_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/inapp_debug_console_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/inapp_debug_console_model.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/logger_interceptor.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

part 'notification_manager_handler.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  NotificationManager.shared.readNoti(message);
}

class NotificationManager {
  static String tag = "[NotificationManager] ";

  static String notificationChannel = (NotificationManager).toString();

  NotificationManager._internal();

  NotificationManager() {
    configFCM();
    configLocalNotifications();
  }

  static NotificationManager? _instance;

  final StreamController<String> _appNavigatorEventsStream =
      StreamController<String>.broadcast();

  Stream<String> get appNavigatorEventsStream =>
      _appNavigatorEventsStream.stream;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static bool isFlutterLocalNotificationsInitialized = false;

  static NotificationManager get shared {
    _instance ??= NotificationManager._internal();

    return _instance!;
  }

  bool openNotiHandleNotOpenedApp = false;

  String tokenFirebase = "";

  void addListenEvent(String type) {
    _appNavigatorEventsStream.sink.add(type);
  }

  Future<void> configLocalNotifications() async {
    logDebug("$tag setupLocalNotifications");
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = IOSInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: (payload) {
        if (payload == null) return;

        try {
          _NotificationManagerHandler.instance.handleOnTapNotification(
            RemoteMessage.fromMap(jsonDecode(payload)),
          );
        } catch (e) {
          ///
        }
      },
    ).then((_) {
      logDebug('$tag setupLocalNotifications init success');
    }).catchError((Object error) {
      logDebug('$tag setupLocalNotifications init failed: $error');
    });
    // Clean Notification
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void configFCM() async {
    bool hasPermission = false;
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      isFlutterLocalNotificationsInitialized = true;

      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        logDebug("$tag User granted permission");
        hasPermission = true;
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        logDebug("$tag User granted provisional permission");
        hasPermission = true;
      } else {
        logDebug('$tag User declined or has not accepted permission');
        await Permission.notification.request();
      }
    } on Exception catch (_) {
      ///
    } catch (err) {
      ///
    }

    if (!hasPermission) return;

    _NotificationManagerHandler.instance.handleOpenedApp();
    _NotificationManagerHandler.instance.handleNotOpenedApp();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleNotification(message);
      if (message.notification != null) {}
    });
  }

  static void handleNotification(RemoteMessage message) {
    // Handle Local
    String title = message.notification?.title ?? "untitle";
    String body = message.notification?.body ?? "";
    final idNotification = DateTime.now().microsecond;

    String type = "";

    String? payload;
    try {
      payload = jsonEncode(message.toMap());
      type = jsonEncode(message.data["type"]);
    } catch (e) {
      ///
    }

    logDebug("$tag $type");

    if (!Platform.isIOS) {
      _showNotification(
        title: title,
        body: body,
        id: idNotification,
        androidImportance: Importance.high,
        androidPriority: Priority.high,
        payload: payload,
      );
    }
  }

  static void _showNotification({
    String? title,
    String? body,
    Importance androidImportance = Importance.defaultImportance,
    Priority androidPriority = Priority.defaultPriority,
    int? id,
    String? iconUri,
    String? payload,
  }) async {
    var bigTextStyleInformation = BigTextStyleInformation(body ?? '');

    AndroidNotificationDetails androidDetail = AndroidNotificationDetails(
      notificationChannel,
      notificationChannel,
      importance: androidImportance,
      priority: androidPriority,
      styleInformation: bigTextStyleInformation,
      largeIcon: DrawableResourceAndroidBitmap(iconUri ?? ""),
    );

    IOSNotificationDetails iosDetail =
        IOSNotificationDetails(threadIdentifier: notificationChannel);

    NotificationDetails notificationDetails = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    await flutterLocalNotificationsPlugin.show(
      id ?? DateTime.now().microsecond,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> getToken() async {
    tokenFirebase = await FirebaseMessaging.instance.getToken() ?? "";
    logDebug("tokenFirebase: $tokenFirebase", level: Level.info);
  }

  void readNoti(RemoteMessage message) async {}
}
