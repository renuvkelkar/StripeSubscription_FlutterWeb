import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_web_payment/loginPage.dart';
import 'package:flutter_stripe_web_payment/success.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'cancel.dart';
import 'constant.dart';
import 'dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: Constants.apiKey,
          authDomain: Constants.authDomain,
          projectId: Constants.projectId,
          storageBucket: Constants.storageBucket,
          messagingSenderId: Constants.messagingSenderId,
          appId: Constants.appId,
          measurementId: Constants.measurementId));
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: '/dashboard',
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardPage();
        },
      ),
      GoRoute(
        path: '/success',
        builder: (BuildContext context, GoRouterState state) {
          return const SuccessPage();
        },
      ),
      GoRoute(
        path: '/cancel',
        builder: (BuildContext context, GoRouterState state) {
          return CancelPage();
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
