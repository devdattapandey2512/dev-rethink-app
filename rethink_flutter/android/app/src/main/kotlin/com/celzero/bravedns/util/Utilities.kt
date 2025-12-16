package com.celzero.bravedns.util

import android.content.Context

object Utilities {
    fun isAtleastO() = android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O
    fun isAtleastS() = android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S
    fun isPlayStoreFlavour() = false
    fun blocklistDownloadBasePath(context: Context, folderName: String, timestamp: Long): String {
        return context.filesDir.canonicalPath + "/" + folderName + "/" + timestamp
    }

    fun writeToFile(file: java.io.File, data: ByteArray) {
        try {
            file.writeBytes(data)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun showToastUiCentered(context: Context, message: String, duration: Int) {
        try {
            val toast = android.widget.Toast.makeText(context, message, duration)
            toast.setGravity(android.view.Gravity.CENTER, 0, 0)
            toast.show()
        } catch (e: Exception) {
            // ignore
        }
    }
}

fun String?.togs(): String = this ?: ""
fun String?.tos(): String? = this
fun ByteArray?.togb(): ByteArray = this ?: ByteArray(0)
fun ByteArray?.tob(): ByteArray? = this
