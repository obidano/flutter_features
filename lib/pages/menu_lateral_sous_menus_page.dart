import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class MenuLateralSousMenusPage extends StatefulWidget {
  String title;

  MenuLateralSousMenusPage({required this.title});

  @override
  State<MenuLateralSousMenusPage> createState() =>
      _MenuLateralSousMenusPageState();
}

class _MenuLateralSousMenusPageState extends State<MenuLateralSousMenusPage> {
  List<String> utilisateurs =
      List.generate(3, (index) => Faker().person.name());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: menuLateral(context),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                size: 30,
              ))
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
            Expanded(child: listeUserView(context)),
          ],
        ),
      ),
    );
  }

  menuLateral(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ODC',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
        ExpansionTile(
          title: Text('Titre principale'),
          leading: Icon(Icons.menu),
          initiallyExpanded: false,
          children: <Widget>[
            Container(
              color: Colors.white.withOpacity(.2),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.home_max),
                        title: Text('Sous menu 1')),
                    Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading: Icon(Icons.ac_unit_sharp),
                        title: Text('Sous menu 2')),
                  ],
                ),
              ),
            ),
          ],
        ),
        ListTile(leading: Icon(Icons.menu), title: Text('Un autre titre')),
      ],
    );
  }

  listeUserView(BuildContext context) {
    return ListView.builder(
      itemCount: utilisateurs.length,
      itemBuilder: (BuildContext context, int index) {
        var user = utilisateurs[index];
        return ListTile(
          onTap: () {
            final scaffold = ScaffoldMessenger.of(context);
            scaffold.showSnackBar(SnackBar(
              content: Text("J'ai cliqué sur $user"),
              action: SnackBarAction(
                  label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
            ));
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
}
