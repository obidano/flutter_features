import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_controller.dart';

class ValidationPage extends StatefulWidget {
  String title;

  ValidationPage({required this.title});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  var saisieController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            formulaire(context),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        validerFormulaire();
                      },
                      child: Text('Valider')),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  formulaire(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [zoneDeSaisie()],
        ),
      ),
    );

    ;
  }

  zoneDeSaisie() {
    return TextFormField(
      autofocus: true,
      controller: saisieController,
      validator: (String? val) {
        var tempVal = val ?? "";
        if (tempVal.isEmpty) {
          return "Ce champ est vide";
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Champ Obligatoire",
          labelText: "Champs de saisie"),
    );
  }

  void validerFormulaire() {
    FormState? etatFormulaire = formKey.currentState;

    if (!etatFormulaire!.validate()) {
      // showSnackBar(context, "Certains champs ne sont pas valides", false);
      return;
    }
    var saisieText = saisieController.text;
    var message = "Valeur recuperée: $saisieText";
    context.read<AppController>().showSnackBar(context, message);
  }
}
