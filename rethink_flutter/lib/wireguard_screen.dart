import 'package:flutter/material.dart';

class WireguardScreen extends StatefulWidget {
  const WireguardScreen({super.key});

  @override
  State<WireguardScreen> createState() => _WireguardScreenState();
}

class _WireguardScreenState extends State<WireguardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WireGuard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: const [true, false],
              onPressed: (index) {},
              children: const [
                Text('Simple'),
                Text('Advanced'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Disclaimer: WireGuard is a registered trademark of Jason A. Donenfeld.'),
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(title: Text('Placeholder Interface 1')),
                ListTile(title: Text('Placeholder Interface 2')),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
