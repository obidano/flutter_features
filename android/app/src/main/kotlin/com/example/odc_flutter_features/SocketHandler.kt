package com.example.odc_flutter_features

import android.util.Log
import io.socket.client.IO
import io.socket.client.Socket

object SocketHandler {

    lateinit var mSocket: Socket

    @Synchronized
    fun setSocket() {
        try {
            Log.i("SOCKET", "CONNECT")
            val uri = "${Constantes.SCHEME}://${Constantes.IP}:${Constantes.PORT}"
            Log.i("SERVICE", "$uri")

            mSocket = IO.socket(uri)
        } catch (e: Exception) {

        }
    }

    @Synchronized
    fun getSocket(): Socket {
        return mSocket
    }

}