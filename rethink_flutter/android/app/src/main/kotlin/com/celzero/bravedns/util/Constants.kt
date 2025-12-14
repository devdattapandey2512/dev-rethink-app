package com.celzero.bravedns.util

object Constants {
    const val BLOCK_FREE_DNS_MAX = ""
    const val BLOCK_FREE_DNS_SKY = ""
    const val ONDEVICE_BLOCKLIST_FILE_TAG = "tag.json"
    const val REMOTE_BLOCKLIST_DOWNLOAD_FOLDER_NAME = "remote"
    const val LOCAL_BLOCKLIST_DOWNLOAD_FOLDER_NAME = "local"
    const val RETHINKDNS_DOMAIN = "rethinkdns.com"
    const val MAX_ENDPOINT = "max"
    const val RETHINK_BASE_URL_MAX = ""
    const val RETHINK_BASE_URL_SKY = ""
    const val UNSPECIFIED_IP_IPV4 = "0.0.0.0"
    const val UNSPECIFIED_IP_IPV6 = "::"
    const val INIT_TIME_MS = 0L
    const val ONDEVICE_BLOCKLIST_FILE_TD = "td"
    const val ONDEVICE_BLOCKLIST_FILE_RD = "rd"
    const val ONDEVICE_BLOCKLIST_FILE_BASIC_CONFIG = "config"
    val DEFAULT_DNS_LIST = emptyList<Any>()
}

object InternetProtocol {
    fun isAlwaysV46(type: Int): Boolean = false
}
