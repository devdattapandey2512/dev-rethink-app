package com.celzero.bravedns.service

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.content.ContextCompat
import com.celzero.bravedns.database.ConnectionTrackerRepository
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import com.celzero.bravedns.data.AppConfig
import com.celzero.bravedns.service.FirewallManager
import com.celzero.bravedns.service.IpRulesManager

class VpnFlutterBridge(private val context: Context) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler, KoinComponent {

    private val appConfig by inject<AppConfig>()
    private val connTrackRepository by inject<ConnectionTrackerRepository>()
    private val serviceScope = CoroutineScope(Dispatchers.IO)
    private var eventSink: EventChannel.EventSink? = null

    companion object {
        var instance: VpnFlutterBridge? = null

        fun sendLog(log: Map<String, Any?>) {
            instance?.eventSink?.success(log)
        }
    }

    init {
        instance = this
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startVpn" -> {
                val startIntent = Intent(context, BraveVPNService::class.java)
                ContextCompat.startForegroundService(context, startIntent)
                result.success(true)
            }
            "stopVpn" -> {
                val stopIntent = Intent(context, BraveVPNService::class.java)
                // Assuming BraveVPNService handles stop logic on destroy or separate intent action
                context.stopService(stopIntent)
                result.success(true)
            }
            "blockApp" -> {
                val uid = call.argument<Int>("uid")
                val packageName = call.argument<String>("packageName")
                val blocked = call.argument<Boolean>("blocked") ?: false

                serviceScope.launch {
                   var targetUid = uid ?: 0
                   if (targetUid == 0 && packageName != null) {
                       try {
                           targetUid = context.packageManager.getPackageInfo(packageName, 0).applicationInfo.uid
                       } catch (e: Exception) {
                           targetUid = 0
                       }
                   }

                   if (targetUid != 0) {
                       FirewallManager.updateAppStatus(targetUid, blocked)
                       result.success(true)
                   } else {
                       result.error("INVALID_UID", "Could not resolve UID", null)
                   }
                }
            }
            "blockIp" -> {
                 val ip = call.argument<String>("ip")
                 val blocked = call.argument<Boolean>("blocked") ?: false
                 serviceScope.launch {
                     IpRulesManager.blockIp(ip ?: "", blocked)
                     result.success(true)
                 }
            }
            "getRecentLogs" -> {
                val limit = call.argument<Int>("limit") ?: 100
                serviceScope.launch {
                    val logs = connTrackRepository.getRecentLogs(limit)
                    val jsonLogs = logs.map {
                        mapOf(
                            "id" to it.id,
                            "ipAddress" to it.ipAddress,
                            "isBlocked" to it.isBlocked,
                            "timestamp" to it.timeStamp
                        )
                    }
                    result.success(jsonLogs)
                }
            }
            else -> result.notImplemented()
        }
    }
}
