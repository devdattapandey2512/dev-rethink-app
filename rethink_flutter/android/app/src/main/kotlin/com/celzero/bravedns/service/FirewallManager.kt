package com.celzero.bravedns.service

import androidx.lifecycle.MutableLiveData
import android.util.Log

object FirewallManager {
    private val blockedApps = mutableSetOf<Int>()

    fun updateAppStatus(uid: Int, blocked: Boolean) {
        if (blocked) {
            blockedApps.add(uid)
        } else {
            blockedApps.remove(uid)
        }
        Log.i("FirewallManager", "App $uid blocked status: $blocked")
    }

    // Stub methods used by BraveVPNService
    fun appStatus(uid: Int): AppStatus = AppStatus(uid)
    fun connectionStatus(uid: Int): ConnectionStatus = ConnectionStatus(uid)
    fun getPackageNameByUid(uid: Int): String? = ""
    fun hasUid(uid: Int): Boolean = true
    fun isUidFirewalled(uid: Int): Boolean = blockedApps.contains(uid)
    fun isUidSystemApp(uid: Int): Boolean = false
    fun isAppForeground(uid: Int, km: android.app.KeyguardManager?): Boolean = false
    fun getNonFirewalledAppsPackageNames(): List<String> = emptyList()
    fun getExcludedApps(): MutableSet<String> = mutableSetOf()
    fun getApplistObserver(): androidx.lifecycle.MutableLiveData<Collection<com.celzero.bravedns.database.AppInfo>> = androidx.lifecycle.MutableLiveData()
    fun userId(uid: Int): Int = 0
    fun appId(uid: Int, primary: Boolean): Int = uid
    fun isAnyAppBypassesDns(): Boolean = false
    fun isAppExcludedFromProxy(uid: Int): Boolean = false
    fun stats(): String = ""

    class AppStatus(val uid: Int) {
        fun isUntracked() = false
        fun bypassDnsFirewall() = false
        fun isolate() = false
        fun bypassUniversal() = false
    }

    class ConnectionStatus(val uid: Int) {
        fun blocked(): Boolean = blockedApps.contains(uid)
        fun mobileData(): Boolean = false
        fun wifi(): Boolean = false
    }

    enum class FirewallStatus(val id: Int) { EXCLUDE(0), NONE(1), BLOCK(2), BYPASS_UNIVERSAL(3), ISOLATE(4), BYPASS_DNS_FIREWALL(5) }
}
