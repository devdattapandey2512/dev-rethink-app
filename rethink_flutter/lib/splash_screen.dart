import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // Artificial delay for splash effect
    await Future.delayed(Duration(seconds: 2));

    // Request permissions
    await _requestPermissions();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  Future<void> _requestPermissions() async {
    // Request Notification permission (Android 13+)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // Request Ignore Battery Optimizations (Optional, good for VPN)
    // await Permission.ignoreBatteryOptimizations.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shield_moon, // Placeholder icon
              size: 100,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 20),
            Text(
              "RethinkDNS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            SpinKitFadingCircle(
              color: Colors.blueAccent,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
