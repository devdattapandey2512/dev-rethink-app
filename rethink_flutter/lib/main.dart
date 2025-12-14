import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'vpn_controller.dart';
import 'log_stream.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rethink DNS Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _vpnEnabled = false;
  List<Map<String, dynamic>> _logs = [];
  List<Application> _apps = [];
  Set<String> _blockedPackages = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadApps();
    _loadLogs();
    LogStream.logs.listen((event) {
      setState(() {
        _logs.insert(0, Map<String, dynamic>.from(event));
        if (_logs.length > 100) _logs.removeLast();
      });
    });
  }

  void _loadLogs() async {
      try {
          final logs = await VpnController.getRecentLogs();
          setState(() {
              // Convert logs to match stream format or display directly
              // For demo, we just add them
              for (var log in logs) {
                  _logs.add(log);
              }
          });
      } catch (e) {
          print("Error loading logs: $e");
      }
  }

  void _loadApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true
    );
    setState(() {
      _apps = apps;
    });
  }

  void _toggleVpn(bool value) async {
    if (value) {
      await VpnController.startVpn();
    } else {
      await VpnController.stopVpn();
    }
    setState(() {
      _vpnEnabled = value;
    });
  }

  void _toggleAppBlock(Application app, bool blocked) async {
      // Pass packageName to Native to resolve UID
      await VpnController.blockApp(0, app.packageName, blocked);
      setState(() {
          if (blocked) {
              _blockedPackages.add(app.packageName);
          } else {
              _blockedPackages.remove(app.packageName);
          }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rethink DNS'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Apps'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
            // Home Tab
            Column(
                children: [
                  SwitchListTile(
                    title: Text('VPN Status'),
                    subtitle: Text(_vpnEnabled ? 'Connected' : 'Disconnected'),
                    value: _vpnEnabled,
                    onChanged: _toggleVpn,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _logs.length,
                      itemBuilder: (context, index) {
                        final log = _logs[index];
                        return ListTile(
                          title: Text(log['message'] ?? 'Log Event ${log['id']}'),
                          subtitle: Text(log.toString()),
                        );
                      },
                    ),
                  ),
                ],
            ),
            // Apps Tab
            ListView.builder(
                itemCount: _apps.length,
                itemBuilder: (context, index) {
                    Application app = _apps[index];
                    bool isBlocked = _blockedPackages.contains(app.packageName);
                    return ListTile(
                        leading: app is ApplicationWithIcon ? Image.memory(app.icon) : null,
                        title: Text(app.appName),
                        subtitle: Text(app.packageName),
                        trailing: Switch(
                            value: isBlocked,
                            onChanged: (val) => _toggleAppBlock(app, val),
                        ),
                    );
                },
            )
        ],
      ),
    );
  }
}
