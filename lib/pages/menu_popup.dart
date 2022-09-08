import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class MenuPopup extends StatefulWidget {
  String title;

  MenuPopup({required this.title});

  @override
  State<MenuPopup> createState() => _MenuPopupState();
}

class _MenuPopupState extends State<MenuPopup> {
  List<String> utilisateurs =
      List.generate(4, (index) => Faker().person.name());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [popupMenu()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(child: example1(context)),
          ],
        ),
      ),
    );
  }

  popupMenu() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        // popupmenu item 1
        PopupMenuItem(
          value: 1,
          // row has two child icon and text.
          child: Row(
            children: [
              Icon(Icons.close_rounded),
              SizedBox(
                // sized box with width 10
                width: 10,
              ),
              Text("Fermer")
            ],
          ),
        ),
        // popupmenu item 2
        PopupMenuItem(
          value: 2,
          // row has two child icon and text
          child: Row(
            children: [
              Icon(Icons.info_outline),
              SizedBox(
                // sized box with width 10
                width: 10,
              ),
              Text("A propos")
            ],
          ),
        ),
      ],
      offset: Offset(0, 0),
      color: Colors.white,
      elevation: 2,
      onSelected: (value) {
        // if value 1 show dialog
        switch (value) {
          case 1:
            Navigator.pop(context);
            break;
          case 2:
            ouvrirInfoDialog(context);
            break;
        }
      },
    );
  }

  ouvrirInfoDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("ODC - Flutter"),
          content: new Text("C'est un outil d'apprentissage à destination "
              "des apprenants de la Digital Academy à l'ODC"),
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

  example1(BuildContext context) {
    return ListView.builder(
      itemCount: utilisateurs.length,
      itemBuilder: (BuildContext context, int index) {
        var user = utilisateurs[index];
        return ListTile(
          onTap: () {
            showSnackBar(context, "J'ai cliqué sur $user");

          },
          leading: Icon(
            Icons.account_box,
            color: Theme.of(context).primaryColor,
          ),
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("#${index + 1}"),
              SizedBox(
                width: 10,
              ),
              Text(
                "$user",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
            ],
          ),
        );
      },
    );
  }

  showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text("$message"),
      action:
      SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

}
