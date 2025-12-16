package com.celzero.bravedns.service

import android.content.Context
import android.util.Log
import java.io.File

object DomainRulesManager {
    private val blockedDomains = mutableSetOf<String>()
    private const val DOMAIN_BLOCKLIST_FILE = "custom_domain_blocklist.txt"

    fun blockDomain(context: Context, domain: String, blocked: Boolean) {
        if (blocked) {
            blockedDomains.add(domain)
        } else {
            blockedDomains.remove(domain)
        }
        Log.i("DomainRulesManager", "Domain $domain blocked status: $blocked")
        persistState(context)
    }

    fun isDomainBlocked(domain: String): Boolean {
        return blockedDomains.contains(domain)
    }

    private fun persistState(context: Context) {
        try {
            val file = File(context.filesDir, DOMAIN_BLOCKLIST_FILE)
            file.writeText(blockedDomains.joinToString("\n"))
        } catch (e: Exception) {
            Log.e("DomainRulesManager", "Error saving domain blocklist", e)
        }
    }

    fun loadState(context: Context) {
        try {
            val file = File(context.filesDir, DOMAIN_BLOCKLIST_FILE)
            if (file.exists()) {
                blockedDomains.clear()
                file.readLines().forEach {
                    if (it.isNotBlank()) blockedDomains.add(it.trim())
                }
            }
        } catch (e: Exception) {
             Log.e("DomainRulesManager", "Error loading domain blocklist", e)
        }
    }

    fun getBlockedDomains(): Set<String> = blockedDomains
}
