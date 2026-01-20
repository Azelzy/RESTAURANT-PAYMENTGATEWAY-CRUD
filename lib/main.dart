import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:laihan01/routes/pages.dart';
import 'package:laihan01/routes/routes.dart';
import 'package:laihan01/services/notification_service.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// FIREBASE ANALTICYS
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

//FCM
  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(MyApp(analytics: analytics));
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics? analytics;
  const MyApp({super.key, this.analytics});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      // initialRoute: AppRoutes.splashscreen,
      initialRoute: AppRoutes.mangaTable,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        if (analytics != null)
          FirebaseAnalyticsObserver(analytics: analytics!),
      ],
    );
  }
}
