import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_controller.dart';

class SwitchButtonsPage extends StatefulWidget {
  String title;

  SwitchButtonsPage({required this.title});

  @override
  State<SwitchButtonsPage> createState() => _SwitchButtonsPageState();
}

class _SwitchButtonsPageState extends State<SwitchButtonsPage> {
  List<Map> langages = [
    {"name": "Français", "checked": false},
    {"name": "Anglais", "checked": false},
    {"name": "Swahili", "checked": false},
    {"name": "Lingala", "checked": false},
    {"name": "Espagnol", "checked": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Chosir les langues que vous parlez ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: checkBoxList()),
            Row(children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  var selectedLangages =
                      langages.where((e) => e['checked']).toList();
                  var message =
                      "${selectedLangages.length} langues selectionnés";
                  context.read<AppController>().showSnackBar(context, message);
                },
                child: Text('Valider'),
              ))
            ])
          ],
        ),
      ),
    );
  }

  checkBoxList() {
    return ListView(
        shrinkWrap: true,
        children: langages.mapIndexed((index, langage) {
          return ListTile(
            trailing: Switch(
              value: langage['checked'],
              onChanged: (bool? newVal) {
                langages[index]['checked'] = newVal;
                setState(() {});
              },
            ),
            title: Text(
              langage['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }).toList());
  }

  showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 70),
      content: Text("$message"),
      action:
          SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
