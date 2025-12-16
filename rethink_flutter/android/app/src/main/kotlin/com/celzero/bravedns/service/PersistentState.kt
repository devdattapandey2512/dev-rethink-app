package com.celzero.bravedns.service

import android.content.Context

class PersistentState(context: Context) {
    var vpnEnabled = false
    var panicRandom = false
    var blocklistEnabled = false
    var remoteBlocklistTimestamp = 0L
    var localBlocklistTimestamp = 0L
    var localBlocklistStamp = ""
    var internetProtocolType = 0
    var enableDnsAlg = false
    var dialStrategy = 0
    var retryStrategy = 0
    var tcpKeepAlive = false
    var dialTimeoutSec = 0
    var endpointIndependence = false
    var useSystemDnsForUndelegatedDomains = false
    var nwEngExperimentalFeatures = false
    var autoDialsParallel = false
    var randomizeListenPort = false
    var defaultDnsUrl = ""
    var theme = 0


}
