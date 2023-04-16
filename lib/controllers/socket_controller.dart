import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketController with ChangeNotifier {
  Socket? socket;

  openSocket(username) {
    socket = io('http://192.168.10.198:3200',
        OptionBuilder().setTransports(['websocket']).build());
    print('open connection');
    socket?.onDisconnect((_) => print('disconnect'));
    socket?.onConnect((_) {
      print('connect');
      socket?.emit('messageClient', '$username connecté');
    });

    socket?.on('messageNewClient', (_) => print(_));

    socket?.on('messageNewClient', (msg) {
      print(msg);
    });
  }
}
