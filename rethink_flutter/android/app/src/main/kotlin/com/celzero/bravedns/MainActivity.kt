package com.celzero.bravedns

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import com.celzero.bravedns.service.VpnFlutterBridge

class MainActivity: FlutterActivity() {
    private val VPN_CHANNEL = "com.celzero.bravedns/vpn"
    private val LOG_CHANNEL = "com.celzero.bravedns/logs"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val bridge = VpnFlutterBridge(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VPN_CHANNEL)
            .setMethodCallHandler(bridge)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, LOG_CHANNEL)
            .setStreamHandler(bridge)
    }
}
