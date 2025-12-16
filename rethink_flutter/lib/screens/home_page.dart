import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import '../vpn_controller.dart';
import '../log_stream.dart';

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
  Set<String> _blockedIps = {};
  // For domains, we don't have a list from backend, so we maintain local state and "add" feature
  Set<String> _blockedDomains = {};

  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadApps();
    _loadLogs();
    LogStream.logs.listen((event) {
      if (mounted) {
        setState(() {
          _logs.insert(0, Map<String, dynamic>.from(event));
          if (_logs.length > 200) _logs.removeLast();
        });
      }
    });
  }

  void _loadLogs() async {
      try {
          final logs = await VpnController.getRecentLogs();
          if (mounted) {
            setState(() {
                // Prepend recent logs
                for (var log in logs) {
                   // Avoid duplicates if possible? Simple impl for now
                   _logs.add(log);
                }
            });
          }
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
    if (mounted) {
      setState(() {
        _apps = apps;
      });
    }
  }

  void _toggleVpn(bool value) async {
    bool success = false;
    if (value) {
      success = await VpnController.startVpn();
    } else {
      success = await VpnController.stopVpn();
    }
    if (success && mounted) {
      setState(() {
        _vpnEnabled = value;
      });
    }
  }

  void _toggleAppBlock(Application app, bool blocked) async {
      // Pass packageName to Native to resolve UID
      await VpnController.blockApp(0, app.packageName, blocked);
      if (mounted) {
        setState(() {
            if (blocked) {
                _blockedPackages.add(app.packageName);
            } else {
                _blockedPackages.remove(app.packageName);
            }
        });
      }
  }

  void _toggleIpBlock(String ip, bool blocked) async {
    await VpnController.blockIp(ip, blocked);
    if (mounted) {
      setState(() {
        if (blocked) {
          _blockedIps.add(ip);
        } else {
          _blockedIps.remove(ip);
        }
      });
    }
  }

    void _toggleDomainBlock(String domain, bool blocked) async {
    await VpnController.blockDomain(domain, blocked);
    if (mounted) {
      setState(() {
        if (blocked) {
          _blockedDomains.add(domain);
        } else {
          _blockedDomains.remove(domain);
        }
      });
    }
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
            Tab(text: 'IPs'),
            Tab(text: 'Domains'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
            // Home / Logs Tab
            Column(
                children: [
                  SwitchListTile(
                    title: Text('VPN Status'),
                    subtitle: Text(_vpnEnabled ? 'Connected' : 'Disconnected'),
                    value: _vpnEnabled,
                    onChanged: _toggleVpn,
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Network Logs", style: Theme.of(context).textTheme.titleMedium)),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _logs.length,
                      separatorBuilder: (c, i) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final log = _logs[index];
                        final isBlocked = log['isBlocked'] == true;
                        return ListTile(
                          leading: Icon(
                            isBlocked ? Icons.block : Icons.check_circle,
                            color: isBlocked ? Colors.red : Colors.green
                          ),
                          title: Text(log['ipAddress'] ?? log['message'] ?? 'Unknown'),
                          subtitle: Text(
                             DateTime.fromMillisecondsSinceEpoch(log['timestamp'] ?? 0).toString()
                          ),
                          onTap: () {
                              // Maybe show dialog to block this IP?
                              _showBlockDialog(log['ipAddress']);
                          },
                        );
                      },
                    ),
                  ),
                ],
            ),
            // Apps Tab
            Column(
              children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Whitelist/Blacklist Apps (Toggle to Block)"),
                 ),
                 Expanded(
                   child: ListView.builder(
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
                  ),
                 ),
              ],
            ),
            // IPs Tab
            Column(
                children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: [
                                Expanded(child: TextField(
                                    controller: _ipController,
                                    decoration: InputDecoration(hintText: 'Enter IP address'),
                                )),
                                IconButton(icon: Icon(Icons.add), onPressed: () {
                                    if (_ipController.text.isNotEmpty) {
                                        _toggleIpBlock(_ipController.text, true);
                                        _ipController.clear();
                                    }
                                })
                            ],
                        ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: _blockedIps.length,
                            itemBuilder: (context, index) {
                                String ip = _blockedIps.elementAt(index);
                                return ListTile(
                                    title: Text(ip),
                                    trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => _toggleIpBlock(ip, false),
                                    ),
                                );
                            },
                        )
                    )
                ],
            ),
             // Domains Tab
            Column(
                children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: [
                                Expanded(child: TextField(
                                    controller: _domainController,
                                    decoration: InputDecoration(hintText: 'Enter Domain name'),
                                )),
                                IconButton(icon: Icon(Icons.add), onPressed: () {
                                    if (_domainController.text.isNotEmpty) {
                                        _toggleDomainBlock(_domainController.text, true);
                                        _domainController.clear();
                                    }
                                })
                            ],
                        ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: _blockedDomains.length,
                            itemBuilder: (context, index) {
                                String domain = _blockedDomains.elementAt(index);
                                return ListTile(
                                    title: Text(domain),
                                    trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => _toggleDomainBlock(domain, false),
                                    ),
                                );
                            },
                        )
                    )
                ],
            ),
        ],
      ),
    );
  }

  void _showBlockDialog(String? ip) {
      if (ip == null) return;
      showDialog(context: context, builder: (context) {
          return AlertDialog(
              title: Text("Block IP?"),
              content: Text("Do you want to block $ip?"),
              actions: [
                  TextButton(child: Text("Cancel"), onPressed: () => Navigator.pop(context)),
                  TextButton(child: Text("Block"), onPressed: () {
                      _toggleIpBlock(ip, true);
                      Navigator.pop(context);
                  }),
              ],
          );
      });
  }
}
