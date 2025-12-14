package com.celzero.bravedns.data

import android.content.Context
import com.celzero.bravedns.database.ProxyEndpoint
import com.celzero.bravedns.database.DnsCryptRelayEndpoint

class AppConfig(context: Context) {
    fun getBraveMode(): BraveMode = BraveMode.DNS_FIREWALL

    enum class BraveMode {
        DNS, FIREWALL, DNS_FIREWALL;
        fun isDnsFirewallMode() = this == DNS_FIREWALL
        fun isFirewallMode() = this == FIREWALL || this == DNS_FIREWALL
        fun isDnsMode() = this == DNS
    }

    data class TunnelOptions(
        val tunDnsMode: TunDnsMode,
        val tunFirewallMode: TunFirewallMode,
        val tunProxyMode: TunProxyMode,
        val ptMode: PtMode,
        val fakeDns: String,
        val bridge: Boolean
    )

    enum class TunDnsMode(val mode: Int) {
        DNS_IP(0), DNS_PORT(1);
    }

    enum class TunFirewallMode(val mode: Int) {
        FILTER(0), BYPASS(1);
    }

    enum class TunProxyMode(val mode: Int) {
        NONE(0), SOCKS5(1), HTTP(2);
        fun isTunProxyOrbot() = false
        fun isTunProxyWireguard() = false
    }

    enum class PtMode(val id: Int) {
        OFF(0), ON(1);
    }

    fun newTunnelOptions(context: Context, fakeDns: String, ptMode: PtMode): TunnelOptions {
        return TunnelOptions(TunDnsMode.DNS_IP, TunFirewallMode.FILTER, TunProxyMode.NONE, ptMode, fakeDns, false)
    }

    fun getProtocolTranslationMode(): PtMode = PtMode.OFF
    fun getDefaultDns(): String = "8.8.8.8"
    fun getPcapFilePath(): String = ""
    fun getDnsType(): DnsType = DnsType.DOH

    enum class DnsType { DOH, DOT, ODOH, DNSCRYPT, DNS_PROXY, SYSTEM_DNS, SMART_DNS, RETHINK_REMOTE }

    fun getDOHDetails(): DOHDetails? = null
    data class DOHDetails(val dohURL: String, val dohName: String, val isSecure: Boolean) { val id = 0 }

    fun getDOTDetails(): DOTDetails? = null
    data class DOTDetails(val url: String, val name: String, val isSecure: Boolean) { val id = 0 }

    fun getODoHDetails(): ODoHDetails? = null
    data class ODoHDetails(val name: String, val resolver: String, val proxy: String)

    fun getConnectedDnscryptServer(): DnscryptServer? = null
    data class DnscryptServer(val dnsCryptURL: String, val dnsCryptName: String)

    fun getSelectedDnsProxyDetails(): DnsProxyDetails? = null
    data class DnsProxyDetails(val proxyIP: String?, val proxyPort: Int, val proxyName: String, val proxyAppName: String?)

    fun getRemoteRethinkEndpoint(): RethinkEndpoint? = null
    fun getBlockFreeRethinkEndpoint(): String = ""
    fun getRethinkDefaultEndpoint(): RethinkEndpoint? = null
    data class RethinkEndpoint(val url: String)
    fun handleRethinkChanges(endpoint: RethinkEndpoint) {}

    fun getOrbotHttpEndpoint(): ProxyEndpoint? = null
    fun getSocks5ProxyDetails(): ProxyEndpoint? = null
    fun getHttpProxyDetails(): ProxyEndpoint? = null
    fun getConnectedOrbotProxy(): ProxyEndpoint? = null
    fun removeProxy(type: ProxyType, provider: ProxyProvider) {}

    enum class ProxyType { HTTP; fun isSocks5Enabled() = false; fun isProxyTypeHasHttp() = true; companion object { fun of(i: Int) = HTTP } }
    enum class ProxyProvider { CUSTOM, ORBOT, NONE }
    fun getProxyType(): Int = 0
    fun getProxyProvider(): Int = 0

    fun getAllDefaultDoHEndpoints(): List<DOHDetails> = emptyList()
    fun getAllDefaultDoTEndpoints(): List<DOTDetails> = emptyList()

    fun isSmartDnsEnabled(): Boolean = false

    fun stats(): String = ""

    fun getDnscryptRelayServers(): String = ""
    fun removeDnscryptRelay(url: String) {}
    fun isTcpProxyEnabled(): Boolean = false

    companion object {
        const val DOH_INDEX = "DOH"
        const val DOT_INDEX = "DOT"
        const val FALLBACK_DNS_IF_NET_DNS_EMPTY = "8.8.8.8"
    }
}
