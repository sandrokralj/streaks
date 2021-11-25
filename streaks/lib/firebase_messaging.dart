import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireBase_Messaging extends StatefulWidget {
  @override
  _FireBase_MessagingState createState() => _FireBase_MessagingState();
}

class _FireBase_MessagingState extends State<FireBase_Messaging> {
  final FirebaseMessaging _fc = FirebaseMessaging.instance;

  void initState() {
    super.initState();
    subscribeToEvent();
    configureCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void configureCallbacks() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            subtitle: Text('On Resume'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    });
  }

  void subscribeToEvent() {
    FirebaseMessaging.instance.subscribeToTopic('Events');
  }
}
