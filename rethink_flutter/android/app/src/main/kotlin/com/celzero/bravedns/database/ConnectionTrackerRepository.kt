package com.celzero.bravedns.database

import android.content.Context
import androidx.room.*

@Dao
interface ConnectionTrackerDAO {
    @Insert
    fun insert(connectionTracker: ConnectionTracker)

    @Query("SELECT * FROM ConnectionTracker ORDER BY timeStamp DESC LIMIT :limit")
    fun getRecentConnections(limit: Int): List<ConnectionTracker>
}

@Database(entities = [ConnectionTracker::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun connectionTrackerDAO(): ConnectionTrackerDAO
}

class ConnectionTrackerRepository(context: Context) {
    // In a real app, use Room.databaseBuilder
    // private val db = Room.databaseBuilder(context, AppDatabase::class.java, "rethink_db").build()

    fun closeConnectionForUids(uids: List<Int>, reason: String) {
        // db.connectionTrackerDAO().updateStatus(...)
    }

    fun closeConnections(connIds: List<String>, reason: String) {

    }

    fun getRecentLogs(limit: Int): List<ConnectionTracker> {
        // Return dummy data for MVP demo as DB connection is not fully simulated
        return listOf(
            ConnectionTracker().apply {
                id = 1
                ipAddress = "1.1.1.1"
                isBlocked = false
                timeStamp = System.currentTimeMillis()
            },
            ConnectionTracker().apply {
                id = 2
                ipAddress = "8.8.8.8"
                isBlocked = true
                timeStamp = System.currentTimeMillis() - 1000
            }
        )
    }

    fun getConnIdByUidIpAddress(uid: Int, ipAddress: String, to: Long): List<String> = emptyList()
}
