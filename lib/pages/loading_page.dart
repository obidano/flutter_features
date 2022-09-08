import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  String title;

  LoadingPage({required this.title});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  List<String> utilisateurs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      simulerChargement(context, 3500);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                simulerChargement(context);
              },
              icon: Icon(Icons.sync))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(child: listeUsersView(context))
          ],
        ),
      ),
    );
  }

  simulerChargement(BuildContext context, [int duree = 1500]) async {
    ouvrirDialog(context);
    await Future.delayed(Duration(milliseconds: duree));
    // fermeture de la boite de dialogue
    Navigator.pop(context);
    utilisateurs.add(Faker().person.name());
    setState(() {});
  }

  listeUsersView(BuildContext context) {
    return ListView.builder(
      itemCount: utilisateurs.length,
      itemBuilder: (BuildContext context, int index) {
        var user = utilisateurs[index];
        return ListTile(
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

  ouvrirDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: new Text("Alert!!"),
          content: Text("Chargement en cours..."),
        );
      },
    );
  }
}
