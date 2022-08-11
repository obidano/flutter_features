import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  String title;

  TabsPage({required this.title});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<String> joueurs = List.generate(20, (index) => Faker().person.name());
  List<String> sports = List.generate(20, (index) => Faker().sport.name());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.people),
                text: "Joueurs",
              ),
              Tab(
                icon: Icon(Icons.sports_baseball_outlined),
                text: "Sports",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [tab1(), tab2()],
        ),
      ),
    );
  }

  tab1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(child: listJoueursVue(context)),
        ],
      ),
    );
  }

  tab2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(child: listSportsVue(context)),
        ],
      ),
    );
  }

  listJoueursVue(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // effectuer une action asynchrone
        await Future.delayed(
            Duration(milliseconds: 800)); // simuler une action asynchrone
        joueurs.add(Faker().person.name());
        setState(() {});
      },
      child: ListView.builder(
        itemCount: joueurs.length,
        itemBuilder: (BuildContext context, int index) {
          var joueur = joueurs[index];
          return ListTile(
            onTap: () {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(SnackBar(
                content: Text("J'ai cliqué sur $joueur"),
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
                  "$joueur",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  listSportsVue(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // effectuer une action asynchrone
        await Future.delayed(
            Duration(milliseconds: 800)); // simuler une action asynchrone
        sports.add(Faker().sport.name());
        setState(() {});
      },
      child: ListView.builder(
        itemCount: sports.length,
        itemBuilder: (BuildContext context, int index) {
          var sport = sports[index];
          return ListTile(
            onTap: () {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(SnackBar(
                content: Text("J'ai cliqué sur $sport"),
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
                  "$sport",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
