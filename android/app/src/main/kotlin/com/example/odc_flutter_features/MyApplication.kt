package com.example.odc_flutter_features

import android.app.Application
import android.content.IntentFilter
import android.net.ConnectivityManager
import com.example.odc_flutter_features.database.MyDataBase

class MyApplication:Application() {
    val db by lazy {
        MyDataBase.getInstance(this)
    }

    override fun onCreate() {
        super.onCreate()
        // permet d'ecouter les evenements du telephone entre autre, le redemarrage
        registerReceiver(
            AppReceiver(),
            IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION)
        )
    }
}