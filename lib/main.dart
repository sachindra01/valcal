import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/services/analytic_services.dart';
import 'package:landconverter/services/notification_services.dart';
import 'package:landconverter/view/splash_screen.dart';

//get data to app when on background
Future<void> backgroundHandler(RemoteMessage message)async{
  debugPrint(message.data.toString());
  debugPrint(message.notification!.title.toString());
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
//Object
LocalNotificationService localNotification = LocalNotificationService();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  void initState() {
    getFcmToken();
    onNotificationRecieved();
    super.initState();
  }

  //On Notification Revieved
  onNotificationRecieved(){
    FirebaseMessaging.instance.getInitialMessage().then((message){
      if(message != null){
      // final routeFromNotification = message.data["route"];
      // // navigatorKey.currentState!.pushNamed(routeFromNotification);
      // Navigator.pushNamed(context, routeFromNotification);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification!.title);
      debugPrint(message.notification!.body);
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final routeFromNotification = message.data["route"];
      // navigatorKey.currentState!.pushNamed(routeFromNotification);
    });

    localNotification.notificationInitialization();
  }
  //Get Fcm
  getFcmToken() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcm = await messaging.getToken();
    return fcm;
  }


  @override
  Widget build(BuildContext context) {
    //initialize local notification
    LocalNotificationService.initialize(context);

    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child) {
        return MaterialApp(
          navigatorObservers: <NavigatorObserver>[AnalyticsService.observer],
          title: 'Mulyankan',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        );
      }
    );
  }
}