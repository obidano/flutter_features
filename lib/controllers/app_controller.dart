import 'package:flutter/material.dart';

class AppController with ChangeNotifier {

  AppController();

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
