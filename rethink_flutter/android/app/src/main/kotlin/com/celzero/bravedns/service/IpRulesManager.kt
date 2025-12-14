package com.celzero.bravedns.service

import android.util.Log

object IpRulesManager {
    private val blockedIps = mutableSetOf<String>()

    fun blockIp(ip: String, blocked: Boolean) {
        if (blocked) {
            blockedIps.add(ip)
        } else {
            blockedIps.remove(ip)
        }
        Log.i("IpRulesManager", "IP $ip blocked status: $blocked")
    }

    fun isIpBlocked(ip: String): Boolean {
        return blockedIps.contains(ip)
    }
}
