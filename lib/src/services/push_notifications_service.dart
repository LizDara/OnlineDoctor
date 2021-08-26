import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:traveling/src/providers/TravelProvider.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String, dynamic>> _messageStream =
      new StreamController.broadcast();
  static Stream<Map<String, dynamic>> get messageStream =>
      _messageStream.stream;

  static Future<dynamic> _backgroundHandler(RemoteMessage message) async {
    _messageStream.add(message.data);
  }

  static Future<dynamic> _onMessageHandler(RemoteMessage message) async {
    _messageStream.add(message.data);
  }

  static Future<dynamic> _onMessageOpenApp(RemoteMessage message) async {
    _messageStream.add(message.data);
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await messaging.getToken();
    //final TravelProvider travelProvider = new TravelProvider();
    //await travelProvider.sendPhoneToken(token ?? '');

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
