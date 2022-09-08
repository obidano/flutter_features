package com.example.odc_flutter_features

import android.app.*
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.example.odc_flutter_features.database.MessagesDao
import com.example.odc_flutter_features.database.MessagesTable
import io.socket.client.IO
import io.socket.client.Socket
import kotlinx.coroutines.*

class ChatService : Service() {
    var isForeGround = false
    val NoTIFICATION_CHANNEL_ID = "my_channel_01"
    lateinit var mSocket: Socket
    lateinit var msgDao: MessagesDao


    private val job = SupervisorJob()
    private val scope = CoroutineScope(Dispatchers.IO + job)


    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    private val broadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val msg: String = intent.getStringExtra("msg") as String
            println("onReceive: ${msg}")
        }
    }

    override fun onCreate() {
        super.onCreate()
        registerReceiver(broadcastReceiver, IntentFilter("send_chat_message"))
    }


    fun startForeGroundService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NoTIFICATION_CHANNEL_ID,
                "Channel human readable title",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            (getSystemService(NOTIFICATION_SERVICE) as NotificationManager).createNotificationChannel(
                channel
            )
            val intent = Intent(this, MainActivity::class.java)
            //intent.putExtra("","")
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK

            val pendingIntent =
                PendingIntent.getActivity(this, 1, intent, PendingIntent.FLAG_IMMUTABLE)

            val notification: Notification =
                NotificationCompat.Builder(this, NoTIFICATION_CHANNEL_ID)
                    .setSmallIcon(android.R.drawable.ic_media_play)
                    .setContentTitle("ODC Flutter")
                    .setContentText("Recherche des nouvelles informations...")
                    .setContentIntent(pendingIntent)
                    .build()
            startForeground(1001, notification)
        }
    }

    fun createNotificationChannel() {
        Log.i("TIME SERVICE", "CREATE CHANNEL")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Notification App"
            val description = "CHANNEL POUR FAIRE CA"

            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val notificationChannel = NotificationChannel("CHANNEL_1", name, importance)
            notificationChannel.description = description
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(notificationChannel)
        }
    }

    private fun addNotification(title: String, message: String) {
        Log.i("NOTIFS", "SHOW")
        val intent = Intent(this, MainActivity::class.java)
        //intent.putExtra("","")
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK

        val pendingIntent = PendingIntent.getActivity(this, 1, intent, PendingIntent.FLAG_IMMUTABLE)

        // construire la notification
        val builder = NotificationCompat.Builder(this, "CHANNEL_1")
        builder.setSmallIcon(android.R.drawable.ic_media_next)
        builder.setContentTitle(title)
        builder.setContentText(message)
        builder.setSilent(true)
        builder.setAutoCancel(true) // annuler la notification une fois cliqué
        builder.setContentIntent(pendingIntent)
        builder.priority = NotificationCompat.PRIORITY_DEFAULT

        val notificalManager = NotificationManagerCompat.from(this)
        notificalManager.notify(100, builder.build())
    }


    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // init database
        msgDao = (application as MyApplication).db.messagesDao()

        isForeGround = intent?.getBooleanExtra("IS_FOREGROUND", true) ?: true
        if (isForeGround) {
            Log.i("SERVICE", "DEMARRAGE FOREGROUND")
            startForeGroundService()
        } else {
            Log.i("SERVICE", "DEMARRAGE BACKGROUND")
        }

        // init socket
        socketHandler()

        // creation notification channel
        createNotificationChannel()

        return START_STICKY
    }

    private fun socketHandler() {
        SocketHandler.setSocket()
        mSocket = SocketHandler.getSocket()
        mSocket.connect()

        val options = IO.Options()
        options.reconnection = true //reconnection
        options.forceNew = true

        mSocket.on("message") { args ->
            Log.i("WEBSOCKET MSG", args.toString())
            if (args[0] != null) {
                Log.i("NEW SOCKET MESSAGE", "RECEIVED ${args[0]}")
                val new_msg = args[0] as String
                addNotification("Nouveau message", new_msg)
                sendToActivity(new_msg)
            }
        }
    }

    fun sendToActivity(message: String) {
        val intent = Intent("service.response");
        intent.putExtra("msg", message);
        sendBroadcast(intent);
        scope.launch {
          //  insertData(MessagesTable(id = 0, type = "message", content = message))
        }
    }

    suspend fun insertData(data: MessagesTable) {
        withContext(Dispatchers.IO) {
            msgDao.insert(data)
        }
    }

    fun showToast() {
        var mContext = getApplicationContext();
        if (mContext != null) {
            val handler = Handler(Looper.getMainLooper());
            handler.post {
                Toast.makeText(mContext, "DATA insert", Toast.LENGTH_LONG).show()

            }

        }

    }


    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(broadcastReceiver);
        mSocket.disconnect();
        job.cancel()
    }

}