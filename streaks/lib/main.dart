import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streaks/firebase_messaging.dart';
import 'package:streaks/locator.dart';
import 'package:streaks/router.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/views/start_up_view/start_up_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'managers/dialog_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streaks',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
