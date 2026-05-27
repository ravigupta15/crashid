import 'dart:async';
import 'dart:io';

import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");
}

class AppNotificationService {
  AppNotificationService._internal();
  static final AppNotificationService instance =
      AppNotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel? _channel;
  bool _initialized = false;

  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;

  final StreamController<Map<String, dynamic>> _notificationDataController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get notificationStream =>
      _notificationDataController.stream;

  Future<void> initialize() async {
    if (_initialized) return;

    await requestPermission();

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    _channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel!);

    // Init local notifications
    await _initializeLocalNotifications();

    // Foreground listener
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Tap when app in background
    _onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp
        .listen(_handleNotificationTap);

    // Tap when app terminated
    await _handleInitialMessage();

    await _setupTokenHandling();

    _initialized = true;
    print("NotificationService initialized");
  }

  Future<void> _setupTokenHandling() async {
    if (Platform.isIOS) {
      String? apnsToken = await _fcm.getAPNSToken();

      if (apnsToken == null) {
        for (int i = 0; i < 5; i++) {
          await Future.delayed(const Duration(seconds: 2));
          apnsToken = await _fcm.getAPNSToken();
          print("APNS retry $i: $apnsToken");
          if (apnsToken != null) break;
        }
      }

      if (apnsToken == null) {
        print(" APNS token unavailable — FCM token will not be fetched");
        _fcm.onTokenRefresh.listen(_onTokenReceived);
        return;
      }

      print(" APNS Token: $apnsToken");
    }

    await _fetchAndStoreFcmToken();

    _fcm.onTokenRefresh.listen(_onTokenReceived);
  }

  Future<void> _fetchAndStoreFcmToken() async {
    try {
      final fcmToken = await _fcm.getToken();
      if (fcmToken != null) {
        _onTokenReceived(fcmToken);
      } else {
        print("FCM token is null");
      }
    } catch (e) {
      print("FCM getToken error: $e");
    }
  }

  void _onTokenReceived(String token) {
    print("FCM Token: $token");
    GetIt.I<UserManager>().setFcmToken = token;
  }

  // 🔐 Permission
  Future<AuthorizationStatus> requestPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permission status: ${settings.authorizationStatus}');
    return settings.authorizationStatus;
  }

  Future<AuthorizationStatus> openAppSetting() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // if (settings.authorizationStatus == AuthorizationStatus.denied) {
    AppDialogBox().openBox(
      title: "Enable Permission",
      subTitle: "Please enable alerts in Settings to receive your messages.",
      yesTap: () async => await openAppSettings(),
    );
    return settings.authorizationStatus;
  }

  // 🔔 Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          print("rese....${response.payload}");
          final parts = response.payload!.split(',');
          _handleNotificationTap(
            RemoteMessage(
              data: {
                'action': parts.isNotEmpty ? parts[0] : '',
                'screen': parts.length > 1 ? parts[1] : '',
              },
            ),
          );
        }
      },
    );
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (message.notification == null) return;
    print('data...${message.data}');

    if (!_notificationDataController.isClosed) {
      _notificationDataController.add(message.data);
      // stream the notification data
    }
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channel!.id,
        _channel!.name,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await _localNotifications.show(
      id: message.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: notificationDetails,
      payload:
          '${message.data['action'] ?? ''},${message.data['screen'] ?? ''}',
    );
  }

  // 📲 Handle cold start
  Future<void> _handleInitialMessage() async {
    final message = await _fcm.getInitialMessage();
    if (message != null) {
      _handleNotificationTap(message);
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    final action = message.data['action'] ?? '';

    if (!_notificationDataController.isClosed) {
      _notificationDataController.add(message.data);
    }

    // if (SessionManager.token.isEmpty) return;

    switch (action) {
      case 'open_app':
        // LoginScreen.open(AppRouters.mainNavigatorKey.currentContext!);
        break;
    }
  }

  // 🔑 Get Token
  Future<String?> getToken() async {
    final token = await _fcm.getToken();
    if (token != null) {
      GetIt.I<UserManager>().setFcmToken = token;
      print("FCM Token: $token");
    }
    return token;
  }

  void dispose() {
    _onMessageOpenedAppSubscription?.cancel();
    _onMessageOpenedAppSubscription?.cancel();
    _notificationDataController.close(); // 4. Clean up
  }
}
