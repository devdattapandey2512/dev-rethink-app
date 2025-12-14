package com.celzero.bravedns.util

import android.content.Context

object Utilities {
    fun isAtleastO() = android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O
    fun isAtleastS() = android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S
    fun isPlayStoreFlavour() = false
    fun showToastUiCentered(context: Context, message: String, duration: Int) {}
}

fun String?.togs(): String = this ?: ""
fun String?.tos(): String? = this
fun ByteArray?.togb(): ByteArray = this ?: ByteArray(0)
fun ByteArray?.tob(): ByteArray? = this
