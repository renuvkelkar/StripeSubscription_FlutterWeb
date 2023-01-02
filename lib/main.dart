import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_web_payment/loginPage.dart';
import 'package:flutter_stripe_web_payment/test.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCvqF6OkACnz2cHyRKxl2mCwjCbgJy4rU4",
          authDomain: "flutterstripeweb.firebaseapp.com",
          projectId: "flutterstripeweb",
          storageBucket: "flutterstripeweb.appspot.com",
          messagingSenderId: "1038918353624",
          appId: "1:1038918353624:web:7d16be2720370cabd28dad",
          measurementId: "G-TN74PDHH08"));
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Success',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
