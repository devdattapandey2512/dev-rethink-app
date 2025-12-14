package com.celzero.bravedns.util

object Logger {
    const val LOG_TAG_VPN = "VPN"
    const val LOG_TAG_PROXY = "PROXY"
    const val LOG_TAG_CONNECTION = "CONNECTION"
    const val LOG_BATCH_LOGGER = "BATCH"
    const val LOG_GO_LOGGER = "GO"
    const val uiLogLevel = 7L

    enum class LoggerLevel(val id: Int) {
        VERBOSE(0), DEBUG(1), INFO(2), WARN(3), ERROR(4), ASSERT(5);
        companion object { fun fromId(id: Int) = values().firstOrNull { it.id == id } ?: INFO }
        fun stacktrace() = this == ERROR
        fun user() = this == ASSERT
    }

    fun i(tag: String, msg: String) { android.util.Log.i(tag, msg) }
    fun e(tag: String, msg: String, t: Throwable? = null) { android.util.Log.e(tag, msg, t) }
    fun w(tag: String, msg: String, t: Throwable? = null) { android.util.Log.w(tag, msg, t) }
    fun d(tag: String, msg: String) { android.util.Log.d(tag, msg) }
    fun v(tag: String, msg: String) { android.util.Log.v(tag, msg) }
    fun vv(tag: String, msg: String) { android.util.Log.v(tag, msg) }
    fun crash(tag: String, msg: String, t: Throwable? = null) { android.util.Log.e(tag, "CRASH: $msg", t) }
    fun goLog(msg: String, level: LoggerLevel) { android.util.Log.i("GO", msg) }
}
