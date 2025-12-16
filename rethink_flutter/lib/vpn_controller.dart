import 'package:flutter/services.dart';

class VpnController {
  static const MethodChannel _channel = MethodChannel('com.celzero.bravedns/vpn');

  static Future<bool> startVpn() async {
    final bool? result = await _channel.invokeMethod('startVpn');
    return result ?? false;
  }

  static Future<bool> stopVpn() async {
    final bool? result = await _channel.invokeMethod('stopVpn');
    return result ?? false;
  }

  static Future<bool> blockApp(int uid, String? packageName, bool blocked) async {
    final bool? result = await _channel.invokeMethod('blockApp', {
        'uid': uid,
        'packageName': packageName,
        'blocked': blocked
    });
    return result ?? false;
  }

  static Future<bool> blockIp(String ip, bool blocked) async {
    final bool? result = await _channel.invokeMethod('blockIp', {'ip': ip, 'blocked': blocked});
    return result ?? false;
  }

  static Future<bool> blockDomain(String domain, bool blocked) async {
    final bool? result = await _channel.invokeMethod('blockDomain', {'domain': domain, 'blocked': blocked});
    return result ?? false;
  }

  static Future<List<Map<String, dynamic>>> getRecentLogs({int limit = 100}) async {
    final List<dynamic>? logs = await _channel.invokeMethod('getRecentLogs', {'limit': limit});
    return logs?.cast<Map<String, dynamic>>() ?? [];
  }
}
