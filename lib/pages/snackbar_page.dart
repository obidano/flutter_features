import 'package:flutter/material.dart';

class SnackBarPage extends StatelessWidget {
  String title;

  SnackBarPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...example1(context),
            ...example2(context),
          ],
        ),
      ),
    );
  }

  List<Widget> example1(BuildContext context) {
    return [
      Center(
          child: ElevatedButton(
              onPressed: () {
                final scaffold = ScaffoldMessenger.of(context);
                scaffold.showSnackBar(SnackBar(
                  content: Text("Welcome to ODC"),
                ));
              },
              child: Text('Ouvrir #1'))),
      SizedBox(
        height: 20,
      )
    ];
  }

  List<Widget> example2(BuildContext context) {
    return [
      Center(
          child: ElevatedButton(
              onPressed: () {
                final scaffold = ScaffoldMessenger.of(context);
                scaffold.showSnackBar(SnackBar(
                  content: Text("Welcome to ODC"),
                  action: SnackBarAction(
                      label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
                ));
              },
              child: Text('Ouvrir #2'))),
      SizedBox(
        height: 20,
      )
    ];
  }
}
