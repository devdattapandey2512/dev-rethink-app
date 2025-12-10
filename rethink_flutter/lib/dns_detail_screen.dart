import 'package:flutter/material.dart';

class DnsDetailScreen extends StatefulWidget {
  const DnsDetailScreen({super.key});

  @override
  State<DnsDetailScreen> createState() => _DnsDetailScreenState();
}

class _DnsDetailScreenState extends State<DnsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DNS'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Logs'),
              Tab(text: 'Configure'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Logs content')),
            Center(child: Text('Configure content')),
          ],
        ),
      ),
    );
  }
}
