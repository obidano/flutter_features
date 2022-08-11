import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class RefreshIndicatorPage extends StatefulWidget {
  String title;

  RefreshIndicatorPage({required this.title});

  @override
  State<RefreshIndicatorPage> createState() => _RefreshIndicatorPageState();
}

class _RefreshIndicatorPageState extends State<RefreshIndicatorPage> {
  List<String> utilisateurs = [Faker().person.name()];

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
            SizedBox(
              height: 20,
            ),
            Expanded(child: example1(context)),
          ],
        ),
      ),
    );
  }

  example1(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // effectuer une action asynchrone
        await Future.delayed(
            Duration(milliseconds: 800)); // simuler une action asynchrone
        utilisateurs.add(Faker().person.name());
        setState(() {});
      },
      child: ListView.builder(
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
      ),
    );
  }
}
