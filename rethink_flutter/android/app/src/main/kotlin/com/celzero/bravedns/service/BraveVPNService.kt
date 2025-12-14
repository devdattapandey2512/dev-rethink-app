package com.celzero.bravedns.service

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.VpnService
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationCompat
import com.celzero.bravedns.R
import com.celzero.bravedns.data.AppConfig
import com.celzero.bravedns.net.go.GoVpnAdapter
import com.celzero.bravedns.util.Constants
import kotlinx.coroutines.*
import org.koin.android.ext.android.inject

class BraveVPNService : VpnService() {

    private val vpnScope = MainScope()
    private val appConfig by inject<AppConfig>()

    @Volatile
    private var vpnAdapter: GoVpnAdapter? = null

    companion object {
        private const val TAG = "BraveVPNService"
        const val SERVICE_ID = 1
        const val VPN_INTERFACE_MTU = 1500
        const val FIRESTACK_MUST_DUP_TUNFD = true
        const val NW_ENGINE_NOTIFICATION_ID = 29002
        private const val MAIN_CHANNEL_ID = "vpn_channel"
    }

    override fun onCreate() {
        super.onCreate()
        Log.i(TAG, "VPN Service Created")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.i(TAG, "VPN Service Started")

        // Fix: Call startForeground to prevent crash/ANR
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                MAIN_CHANNEL_ID,
                "VPN Status",
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }

        val notification: Notification = NotificationCompat.Builder(this, MAIN_CHANNEL_ID)
            .setContentTitle("Rethink DNS")
            .setContentText("VPN is active")
            .setSmallIcon(R.drawable.ic_notification_icon) // Ensure this resource exists or use system
            .build()

        startForeground(SERVICE_ID, notification)

        vpnScope.launch(Dispatchers.IO) {
            startVpn()
        }

        return START_STICKY
    }

    private suspend fun startVpn() {
        val builder = Builder()
        builder.setMtu(VPN_INTERFACE_MTU)
        builder.addAddress("10.111.222.1", 24)
        builder.addRoute("0.0.0.0", 0)
        builder.setSession("RethinkDNS")

        // Notify Flutter bridge
        VpnFlutterBridge.sendLog(mapOf("status" to "starting"))

        try {
            val tunFd = builder.establish()
            if (tunFd == null) {
                Log.e(TAG, "Failed to establish VPN")
                return
            }

            // makeOrUpdateVpnAdapter(tunFd)
            Log.i(TAG, "VPN Established")
            val fakeDns = "10.111.222.1,fd66:f83a:c650::1"
            val opts = appConfig.newTunnelOptions(this, fakeDns, AppConfig.PtMode.OFF)
            // Use dummy addresses for now since we don't have the full net helper utils
            val ifaceAddresses = "10.111.222.1,fd66:f83a:c650::1"

            vpnAdapter = GoVpnAdapter(this, vpnScope, tunFd.fd.toLong(), ifaceAddresses, VPN_INTERFACE_MTU, opts)

            VpnFlutterBridge.sendLog(mapOf("status" to "connected"))

        } catch (e: Exception) {
            Log.e(TAG, "Error starting VPN", e)
             VpnFlutterBridge.sendLog(mapOf("status" to "error", "message" to e.message))
        }
    }

    data class OverlayNetworks(
        val has4: Boolean = false,
        val has6: Boolean = false,
        val failOpen: Boolean = true,
        val mtu: Int = Int.MAX_VALUE
    )

    override fun onDestroy() {
        super.onDestroy()
        vpnScope.cancel()
        Log.i(TAG, "VPN Service Destroyed")
    }
}
