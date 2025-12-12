import 'package:flutter/material.dart';
import 'package:rider_adda/utils/constants.dart';
import 'package:rider_adda/screens/splash_screen.dart';
import 'package:rider_adda/screens/auth_screen.dart';
import 'package:rider_adda/screens/home_screen.dart';

void main() {
  runApp(const RiderAddaApp());
}

class RiderAddaApp extends StatelessWidget {
  const RiderAddaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RiderAdda',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
