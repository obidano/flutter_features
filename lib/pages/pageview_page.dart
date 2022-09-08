import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class PageViewPage extends StatefulWidget {
  String title;

  PageViewPage({required this.title});

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage>
    with SingleTickerProviderStateMixin {
  List<String> joueurs = List.generate(20, (index) => Faker().person.name());
  List<String> sports = List.generate(20, (index) => Faker().sport.name());

  late PageController pageController;
  int pageEnCours = 1;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).primaryColor,
              child: Text(
                '$pageEnCours',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: PageView.builder(
          itemCount: 2,
          controller: pageController,
          onPageChanged: (index) {
            pageEnCours = index + 1;
            setState(() {});
          },
          itemBuilder: (context, index) {
            if (index == 0) return tab1();
            return tab2();
          }),
    );
  }

  tab1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Liste Joueurs ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Liste Sports ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
