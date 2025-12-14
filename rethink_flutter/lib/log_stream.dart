import 'package:flutter/services.dart';

class LogStream {
  static const EventChannel _channel = EventChannel('com.celzero.bravedns/logs');

  static Stream<dynamic> get logs {
    return _channel.receiveBroadcastStream();
  }
}
