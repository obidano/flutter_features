package com.example.odc_flutter_features

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.provider.Settings
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


open class MainActivity : FlutterActivity() {
    val CHANNEL_NAME = "odc.channel"
    var methodChannel: MethodChannel? = null

    private val broadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val msg: String = intent.getStringExtra("msg") as String
            println("Activity onReceive: ${msg}")
            methodChannel?.invokeMethod("chat_response", msg)

        }
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        Log.i("ON CREATE", "ACTIONS")
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)



        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME
        )

        methodChannel!!.setMethodCallHandler { call, result ->
            Log.i("Method Channel", "Methode received ${call.method}");
            if (call.method.equals("fermer_gps")) {
                fermer_gps()
                result.success(true)
                return@setMethodCallHandler
            }

            if (call.method.equals("init")) {
                initChatService();
                registerReceiver(broadcastReceiver, IntentFilter("service.response"))
                result.success(true)
                return@setMethodCallHandler
            }

            if (call.method.equals("envoyer_chat")) {
                val data: String = call.arguments as String
                sendBroadcast(Intent("send_chat_message").putExtra("msg", data))
                result.success(true);
                return@setMethodCallHandler
            }

            result.success(null);
        }
    }

    fun fermer_gps() {
        Log.i("GPS FEATURE", "Ouvrir parametre GPS");
        startActivityForResult(Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS), 100)
    }

    fun initChatService() {
        arreterServiceBackground()
        demarrerServiceBackground()
    }

    fun arreterServiceBackground() {
        Log.i("SERVICE", "arreterServiceBackground")
        val intent = Intent(this, ChatService::class.java)
        stopService(intent)
    }

    fun demarrerServiceBackground() {
        Log.i("SERVICE", "demarrerServiceBackground")
        val intent = Intent(this, ChatService::class.java)
        intent.putExtra("IS_FOREGROUND", false)
        startService(intent)
    }

    fun demarrerServiceForeground() {
        Log.i("SERVICE", "demarrerServiceForeground")
        // Ce service sera utilisable quand le main Thread
        // sera detruit
        val intent = Intent(this, ChatService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent)
        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
//        Log.i("RESULT", data?.data.toString());
//        Log.i("RESULT Activity ", Activity.RESULT_OK.toString());
//        Log.i("RESULT requestCode ", requestCode.toString());
        when (requestCode) {
            100 -> {
                Toast.makeText(applicationContext, "Fin processus GPS", Toast.LENGTH_LONG)
                    .show();
                // renvoie d'une reponse à Flutter
                methodChannel?.invokeMethod("fin_gps_fermeture", "")
            }
        }


    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(broadcastReceiver)
        Log.i("ON DESTROY", "MOn activité est detruite")
        arreterServiceBackground()
        // mon application peut continuer à tourner en arrière plan
        demarrerServiceForeground()
    }
}