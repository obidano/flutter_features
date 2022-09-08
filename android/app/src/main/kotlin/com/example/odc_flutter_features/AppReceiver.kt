package com.example.odc_flutter_features

import android.app.ActivityManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class AppReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        // This method is called when the BroadcastReceiver is receiving an Intent broadcast.
        if (Intent.ACTION_BOOT_COMPLETED == intent?.action) {
            Log.i("RESTART PHONE", "RECEIVER")
            demarrerService(context)
        }
    }

    fun isServiceDejaEnCours(context: Context, serviceClass: Class<*>): Boolean {
        // cette fonction verifie si le service a deja demarré ou non
        val manager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        return manager.getRunningServices(Integer.MAX_VALUE)
            .any { it.service.className == serviceClass.name }
    }

    fun demarrerService(context: Context, foreGround: Boolean = true) {
        if (!isServiceDejaEnCours(context, ChatService::class.java)) {
            Log.i("START SERVICE", "RECEIVER")
            val intent = Intent(context, ChatService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                intent.putExtra("IS_FOREGROUND", foreGround)
                context.startService(intent)
            }
        }
    }
}