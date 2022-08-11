import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class MenuLateralSousMenus extends StatefulWidget {
  String title;

  MenuLateralSousMenus({required this.title});

  @override
  State<MenuLateralSousMenus> createState() => _MenuLateralSousMenusState();
}

class _MenuLateralSousMenusState extends State<MenuLateralSousMenus> {
  List<String> utilisateurs =
      List.generate(20, (index) => Faker().person.name());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Expanded(child: example1(context)),
            ],
          ),
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
          initiallyExpanded: false,
          children: <Widget>[
            Container(
              color: Colors.grey.withOpacity(.2),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.circle_outlined),
                        title: Text('Sous menu 1')),
                    ListTile(
                        leading: Icon(Icons.circle_outlined),
                        title: Text('Sous menu 2')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  example1(BuildContext context) {
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
