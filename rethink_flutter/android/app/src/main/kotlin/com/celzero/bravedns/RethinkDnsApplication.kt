package com.celzero.bravedns

import android.app.Application
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin
import org.koin.dsl.module
import com.celzero.bravedns.data.AppConfig
import com.celzero.bravedns.service.PersistentState
import com.celzero.bravedns.database.ConnectionTrackerRepository

class RethinkDnsApplication : Application() {
    companion object {
        var DEBUG = false
    }

    override fun onCreate() {
        super.onCreate()

        val appModule = module {
            single { AppConfig(androidContext()) }
            single { PersistentState(androidContext()) }
            single { ConnectionTrackerRepository(androidContext()) }
        }

        startKoin {
            androidLogger()
            androidContext(this@RethinkDnsApplication)
            modules(appModule)
        }
    }
}
