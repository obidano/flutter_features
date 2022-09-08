import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class DismissiblePage extends StatefulWidget {
  String title;

  DismissiblePage({required this.title});

  @override
  State<DismissiblePage> createState() => _DismissiblePageState();
}

class _DismissiblePageState extends State<DismissiblePage> {
  List<String> utilisateurs =
      List.generate(10, (index) => Faker().person.name());

  enleverUnElement(index) {
    utilisateurs.removeAt(index);
    setState(() {});
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
            Expanded(child: listeUsersView(context)),
          ],
        ),
      ),
    );
  }

  listeUsersView(BuildContext context) {
    return ListView.builder(
      itemCount: utilisateurs.length,
      itemBuilder: (BuildContext context, int index) {
        String user = utilisateurs[index];
        return Dismissible(
            key: ValueKey(user),
            onDismissed: (_) {
              enleverUnElement(index);
            },
            confirmDismiss: (_) async {
              return await confirmerSwipeDialog(context, user);
            },
            background: swipeBackground(direction: 'left'),
            secondaryBackground: swipeBackground(direction: 'right'),
            child: userView(context, index, user));
      },
    );
  }

  userView(BuildContext context, int index, String user) {
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
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ],
      ),
    );
  }

  swipeBackground({required String direction}) {
    return Container(
      color: Colors.red.withOpacity(.8),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      alignment:
          direction == 'left' ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  Future<bool?> confirmerSwipeDialog(BuildContext ctx, String user) {
    return showDialog<bool>(
        context: ctx,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: const Text("Confirmation Suppression"),
            content: Text("${user}"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx, false);
                  },
                  child: Text("Annuler")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx, true);
                  },
                  child: Text("Valider"))
            ],
          );
        });
  }
}
