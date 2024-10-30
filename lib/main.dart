import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:socialfeed/new%20feed/NewFeed.dart';
import 'feedpage.dart'; // Import your FeedPage if you need it
import 'login page.dart'; // Import your LoginPage
import 'controller/newdemo.dart';
import 'new feed/image and video.dart'; // Import AuthProvider or any other controllers you have

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD5WXGXD5x1fNs6mfohEbdgtGorfiBtR8g",
          authDomain: "socialfeed-b4c67.firebaseapp.com",
          projectId: "socialfeed-b4c67",
          storageBucket: "socialfeed-b4c67.appspot.com",
          messagingSenderId: "49178523453",
          appId: "1:49178523453:web:56d2cbad4144bfd4577754",
          measurementId: "G-KGJCRCPGYD"
      )
  );

  // Set up Firebase messaging background handler
 // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // Handle your background message logic
//   print("Handling a background message: ${message.messageId}");
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Feed App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginPage(),
    );
  }
}
