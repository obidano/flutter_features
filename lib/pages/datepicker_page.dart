import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatepickerPage extends StatefulWidget {
  String title;

  DatepickerPage({required this.title});

  @override
  State<DatepickerPage> createState() => _DatepickerPageState();
}

class _DatepickerPageState extends State<DatepickerPage> {
  var saisieController = TextEditingController();
  DateTime? tempChoisie;
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
      onTap: () {
        ouvrirCalendrier(context);
      },
      readOnly: true,
      controller: saisieController,
      validator: (String? val) {
        var tempVal = val ?? "";
        if (tempVal.isEmpty) {
          return "Ce champ est vide";
        }
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                ouvrirCalendrier(context);
              },
              icon: Icon(Icons.calendar_month)),
          border: OutlineInputBorder(),
          hintText: "Champ Obligatoire",
          labelText: "Champs de saisie"),
    );
  }

  ouvrirCalendrier(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: tempChoisie ?? DateTime.now(),
        firstDate: DateTime(2020),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));
    // traitement des infos de la selection
    if (pickedDate != null) {
      print(pickedDate);
      tempChoisie = pickedDate;
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate);
      saisieController.text = formattedDate;

      setState(() {});
    }
  }

  void validerFormulaire() {
    FormState? etatFormulaire = formKey.currentState;

    if (!etatFormulaire!.validate()) {
      // showSnackBar(context, "Certains champs ne sont pas valides", false);
      return;
    }
    var saisieText = saisieController.text;
    showSnackBar(context, "Valeur recuperée: $saisieText");
  }

  showSnackBar(BuildContext context, String message, [bool success = true]) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      backgroundColor: success ? Colors.green : Colors.red,
      content: Text("$message"),
      action: SnackBarAction(
          label: 'OK',
          textColor: Colors.black,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
