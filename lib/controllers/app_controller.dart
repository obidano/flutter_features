import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppController with ChangeNotifier {
  int? selectedPageIndex;
  String title = "ODC FLutter";

  get_remote_data() async {
    var uri = Uri.parse('');
    var response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var reponse = json.encode(response.body) as Map;
      print(reponse['data']);
    } else {
      print("Erreur Reception données");
    }
  }

  AppController() {
    print('titile $title');
  }

  changeSelectedPageIndex(int index) {
    selectedPageIndex = index;
    notifyListeners();
  }

  showSnackBar(BuildContext context, String message, [bool success = true]) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      backgroundColor: success ? Colors.green : Colors.red,
      content: Text("$message"),
      action: SnackBarAction(
          label: 'Fermer',
          textColor: Colors.black,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
