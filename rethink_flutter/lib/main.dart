import 'package:flutter/material.dart';
import 'package:rethink_flutter/firewall_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rethink Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirewallScreen(),
    );
  }
}
