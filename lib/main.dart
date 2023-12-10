import 'package:books/screens/home_screen.dart';
import 'package:books/screens/home_user.dart';
import 'package:books/screens/login.dart';
import 'package:books/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA_MZtk1RecW7U4fJWKO01se2XITTACiNY",
      // authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "projekbooks",
      storageBucket: "projekbooks.appspot.com",
      messagingSenderId: "610691945662",
      appId: "1:610691945662:android:40b375c9774c648003faef",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   scaffoldBackgroundColor: Color(0xFFEDF2F6),
        //   // Add your custom theme here.
        // ),
        home: SplashScreen() // Change to your initial screen.
        );
  }
}
