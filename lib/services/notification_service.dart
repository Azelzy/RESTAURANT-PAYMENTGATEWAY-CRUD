import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final RxString fcmToken = ''.obs;

  Future<void> initialize() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      
      // Get FCM token
      String? token = await _firebaseMessaging.getToken();
      fcmToken.value = token ?? '';
      
      print('\n=================================================');
      print('FCM TOKEN: ${fcmToken.value}');
      print('=================================================\n');

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        fcmToken.value = newToken;
        print('\n=================================================');
        print('NEW FCM TOKEN: $newToken');
        print('=================================================\n');
      });
    }

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Handle when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message);
    });
  }

  // Get current token
  String getCurrentToken() {
    return fcmToken.value;
  }

  void _showNotification(RemoteMessage message) {
    print('Received foreground message:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    // Add your notification display logic here
  }

  void _handleNotificationTap(RemoteMessage message) {
    print('Notification tapped:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    // Add your notification tap handling logic here
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}