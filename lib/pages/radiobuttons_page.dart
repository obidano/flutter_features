import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class RadioButtonspage extends StatefulWidget {
  String title;

  RadioButtonspage({required this.title});

  @override
  State<RadioButtonspage> createState() => _RadioButtonspageState();
}

class _RadioButtonspageState extends State<RadioButtonspage> {
  List<Map> teams = [
    {"name": "Real Madrid", "value": 0},
    {"name": "Barca", "value": 1},
    {"name": "Milan", "value": 2},
    {"name": "Chelsea", "value": 3},
    {"name": "LiverPool", "value": 4}
  ];

  int? selectedChoixe;

  @override
  void initState() {
    teams.shuffle();
    super.initState();
  }

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
              'Quelle est la meilleure equipe du monde?',
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
                  if (selectedChoixe == null) {
                    showSnackBar(context, "Veuillez faire un choix");
                    return;
                  }
                  ouvrirReponseDialog(context);
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
        children: teams.mapIndexed((index, langage) {
          return ListTile(
            leading: Radio<int>(
              value: langage['value'],
              groupValue: selectedChoixe,
              onChanged: (int? value) {
                selectedChoixe = value;
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
      backgroundColor: Colors.red,
      content: Text("$message"),
      action: SnackBarAction(
          label: 'OK',
          textColor: Colors.black,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  ouvrirReponseDialog(BuildContext context) {
    int finalChoice = 0;
    Map finalTeam = teams.firstWhere((e) => e['value'] == finalChoice);
    Map selectedTeam = teams.firstWhere((e) => e['value'] == selectedChoixe);

    bool isGoodAnswer = finalChoice == selectedTeam['value'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: new Text("Resultat")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isGoodAnswer)
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 50,
                ),
              if (!isGoodAnswer)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close_rounded,
                      color: Colors.red,
                      size: 20,
                    ),
                    Text("Votre reponse "),
                    SizedBox(
                      width: 10,
                    ),
                    Text(selectedTeam['name'],
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Text("La bonne reponse est "),
              Text(
                finalTeam['name'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
