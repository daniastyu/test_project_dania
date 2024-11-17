import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moufadala/routes.dart';
import 'package:moufadala/ui/loading.dart';
import 'package:moufadala/ui/netork-error-indicator.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rxdart/rxdart.dart';

import 'api/data_connectiviy_service.dart';
import 'global/userGlobal.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}
final onNotification= BehaviorSubject<String>();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const String ROUTE_ID = 'app';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;

  /* void onClickNotification(String payload)=>Navigator.of(context).push(
    MaterialPageRoute(builder: (context)=>MyOrderPage())
  );*/

  @override
  void initState() {
   /* OverlaySupportEntry entry;

    DataConnectivityService()
        .connectivityStreamController
        .stream
        .listen((event) {
      print(event);
      if (event == DataConnectionStatus.disconnected) {
        entry = showOverlayNotification((context) {
          return NetworkErrorAnimation();
        }, duration: Duration(hours: 1));
      } else {
        if (entry != null) {
          entry.dismiss();
        }
      }
    });*/
    super.initState();

    getToken();

  }
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    UserGlobal.fbToken=token;
    setState(() {
      token = token;
    });

    print('token');
    print(token);
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'المفاضلة',
        theme: ThemeData(
          // backgroundColor: Colors.red[600],
          //#0b2c2b
          primarySwatch: Colors.indigo,
          //  brightness: Brightness.dark,
        ),
        builder: (BuildContext context, Widget child) {
          return new Directionality(
            textDirection: TextDirection.rtl,
            child: new Builder(
              builder: (BuildContext context) {
                return new MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child,
                );
              },
            ),
          );
        },
        home: Loading(),
        routes:Routes.routes(),
        initialRoute: Routes.initScreen(),
      ),
    );

  }
}
