import 'package:flutter/material.dart';

class AlertDialogPage extends StatelessWidget {
  String title;

  AlertDialogPage({required this.title});

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
            ...example3(context),
            ...example4(context),
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
                ouvrirDialog1(context);
              },
              child: Text('Ouvrir avec une information #1'))),
      SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> example2(BuildContext context) {
    return [
      Center(
          child: ElevatedButton(
              onPressed: () {
                ouvrirDialog2(context);
              },
              child: Text('Ouvrir avec une reponse #2'))),
      SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> example3(BuildContext context) {
    return [
      Center(
          child: ElevatedButton(
              onPressed: () {
                ouvrirFormulaireDialog(context);
              },
              child: Text('Ouvrir avec un formulaire #3'))),
      SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> example4(BuildContext context) {
    return [
      Center(
          child: ElevatedButton(
              onPressed: () {
                ouvrirDialogSelection(context);
              },
              child: Text('Ouvrir avec une selection #4'))),
      SizedBox(
        height: 20,
      ),
    ];
  }

  ouvrirDialog1(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("Welcome to ODC"),
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

  ouvrirDialog2(context) async {
    bool? resulat = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("Suppression"),
          actions: <Widget>[
            TextButton(
              child: new Text(
                "Annuler",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            new TextButton(
              child: new Text("Confirmer"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
// code executé apres fermeture de la boite de dialogue
    if (resulat != null) {
      var message = !resulat ? "Suppression Annulée" : "Suppression confirmée";
      showSnackBar(context, message);
    }
  }

  ouvrirFormulaireDialog(BuildContext context) async {
    TextEditingController nomCtrl = TextEditingController();
    bool? resultat = await showDialog<bool>(
        context: context,
        builder: (ctx) {
          bool _error = false;
          return StatefulBuilder(builder: (_, StateSetter setInnerState) {
            return AlertDialog(
              title: Text("Formulaire"),
              content: TextField(
                controller: nomCtrl,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Nom",
                    hintText: "Saisir un nom",
                    errorText: _error ? "Champ obligatoire" : null),
              ),
              actions: [
                TextButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: Text('Valider'),
                  onPressed: () {
                    setInnerState(() {
                      _error = nomCtrl.text.isEmpty;
                    });
                    if (!_error) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            );
          });
        });

    // apres fermeture de la boite de dialogue
    if (resultat != null) {
      showSnackBar(context, "Valeur saisie: ${nomCtrl.text} ");
    }
  }

  ouvrirDialogSelection(BuildContext context) async {
    List<String> listChoixPays = ['RDC', "Congo", 'Cameroun'];

    var resultat = await showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
              elevation: 3,
              title: const Text('Selectionner Un pays'),
              children: listChoixPays.map((String pays) {
                return contenuPourUnLigneChoix(context,pays);
              }).toList());
        });
    if (resultat != null) {
      showSnackBar(context, "Pays selectionné: $resultat");
    }
  }

  Widget contenuPourUnLigneChoix(BuildContext context, String pays) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SimpleDialogOption(
                child: Text(
                  pays,
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.pop(context, pays);
                },
              ),
            ),
          ],
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      action:
          SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
