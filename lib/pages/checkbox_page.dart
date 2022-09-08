import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:odc_flutter_features/controllers/app_controller.dart';
import 'package:provider/provider.dart';

class CheckBoxpage extends StatefulWidget {
  String title;

  CheckBoxpage({required this.title});

  @override
  State<CheckBoxpage> createState() => _CheckBoxpageState();
}

class _CheckBoxpageState extends State<CheckBoxpage> {
  List<Map> langages = [
    {"name": "Python", "checked": false},
    {"name": "Java", "checked": false},
    {"name": "C++", "checked": false},
    {"name": "Golang", "checked": false},
    {"name": "Visual Basic", "checked": false}
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
              'Chosir vos langages preferées',
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
                      "${selectedLangages.length} langages selectionnés";
                  context
                      .read<AppController>()
                      .showSnackBar(context, message);
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
            leading: Checkbox(
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


}
