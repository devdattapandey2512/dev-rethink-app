package com.celzero.bravedns.service

import com.celzero.bravedns.database.DnsCryptRelayEndpoint

object WireguardManager {
    fun getActiveConfigs(): List<Config> = emptyList()
    fun getConfigById(id: Int): Config? = null
    fun getConfigFilesById(id: Int): ConfigFiles? = null
    fun getOneWireGuardProxyId(): Int? = null
    data class Config(val id: Int) { fun getId() = id; fun toWgUserspaceString(skip: Boolean) = "" }
    data class ConfigFiles(val useOnlyOnMetered: Boolean, val oneWireGuard: Boolean, val ssidEnabled: Boolean, val ssids: String)
    fun matchesSsidList(configured: String, current: String): Boolean = false
    fun enableConfig(config: ConfigFiles) {}

    data class WgStats(val stat: Any?, val mtu: Any?, val status: Any?, val ip4: Any?, val ip6: Any?)
    fun stats(): String = ""
}

object ProxyManager {
    const val ID_WG_BASE = "WG"
    const val ID_ORBOT_BASE = "ORBOT"
    const val ID_S5_BASE = "S5"
    const val ID_HTTP_BASE = "HTTP"
}

object RethinkBlocklistManager {
    enum class RethinkBlocklistType { LOCAL, REMOTE; fun isLocal() = this == LOCAL }
}

object WgHopManager {
    fun getAllHop(): List<String> = emptyList()
    fun getHop(id: String): String = ""
}

class DnsCryptRelayEndpoint(val dnsCryptRelayURL: String)
