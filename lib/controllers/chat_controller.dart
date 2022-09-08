import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatController with ChangeNotifier {
  MethodChannel channel = MethodChannel('odc.channel');
  bool isGpsServiceEnabled = false;

  LocationController() {}

  envoyerMessage(String saisieText) async {
    try {
      var reponse = await channel.invokeMethod('envoyer_chat', saisieText);
      print("reponse $reponse");
      print(reponse.runtimeType);
    } catch (error) {
      print(error);
    }
  }

  initKoltin() async{
    try {
      var reponse = await channel.invokeMethod('init', "");
      print("init reponse $reponse");
      print(reponse.runtimeType);
      recevoirMessage();
    } catch (error) {
      print(error);
    }
  }

  recevoirMessage() {
    print('ChatController listenKotlinResponse');
    channel.setMethodCallHandler((call) async {
      print('channel cal method ${call.method}');
      if (call.method == 'chat_response') {
        print("REPONSE ${call.arguments}");
      }

      return Future.value(null);
    });
  }
}
