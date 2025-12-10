import 'package:flutter/material.dart';

class FirewallScreen extends StatefulWidget {
  const FirewallScreen({super.key});

  @override
  State<FirewallScreen> createState() => _FirewallScreenState();
}

class _FirewallScreenState extends State<FirewallScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firewall'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Apps'),
              Tab(text: 'All'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Apps content')),
            Center(child: Text('All content')),
          ],
        ),
      ),
    );
  }
}
