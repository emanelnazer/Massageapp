import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:massage_app/screens/Sign_in_Screen.dart';
import 'package:massage_app/screens/chat_screen.dart';
import 'package:massage_app/screens/register_screen.dart';
import 'package:massage_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAOX1WXVQctBaeJSdijE37oAS62Xsfr6oQ",
        appId: "1:865677582005:android:42d93047763c29502528fc",
        messagingSenderId: "865677582005",
        projectId: "massageme-d6a92",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final _auth=FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:WelcomeScreen(),
      initialRoute: _auth.currentUser != null ?
      ChatScreen.screenroot:
          WelcomeScreen.screenroot
     /* initialRoute: WelcomeScreen.screenroot,
      routes: {
        WelcomeScreen.screenroot:(context)=>WelcomeScreen(),
        SignInScreen.screenroot:(context)=>SignInScreen(),
        RegisterScreen.screenroot:(context)=>RegisterScreen(),
        ChatScreen.screenroot:(context)=>ChatScreen(),*/

    );
  }
}
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'xxxxxxxxxxxxxxxxxxx',
    appId: 'xxxxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxx',
    projectId: 'xxxxxxxxxxxxxxxxxxx',
    authDomain: 'xxxxxxxxxxxxxxxxxxx',
    databaseURL: 'xxxxxxxxxxxxxxxxxxx',
    storageBucket: 'xxxxxxxxxxxxxxxxxxx',
    measurementId: 'xxxxxxxxxxxxxxxxxxx',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'xxxxxxxxxxxxxxxxxxx',
    appId: 'xxxxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxx',
    projectId: 'xxxxxxxxxxxxxxxxxxx',
    databaseURL: 'xxxxxxxxxxxxxxxxxxx',
    storageBucket: 'xxxxxxxxxxxxxxxxxxx',
  );

}