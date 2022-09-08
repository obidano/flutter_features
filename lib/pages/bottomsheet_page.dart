import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  String title;

  BottomSheetPage({required this.title});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  List<String> utilisateurs =
      List.generate(10, (index) => Faker().person.name());

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
        return userView(context, index, user);
      },
    );
  }

  userView(BuildContext context, int index, String user) {
    return ListTile(
      onTap: () {
        ouvrirModalBottomsheet(context, user);
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

  void ouvrirModalBottomsheet(BuildContext context, String user) {
    showModalBottomSheet(
      context: context,
      // color is applied to main screen when modal bottom screen is displayed
      barrierColor: Colors.grey.withOpacity(.1),
      //background color for modal bottom screen
      backgroundColor: Colors.white,
      //elevates modal bottom screen
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.verified_user,
                    size: 30,
                  ),
                  title: Text(user),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                      iconSize: 13,
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Partager'),
                ),
                ListTile(
                  leading: Icon(Icons.copy),
                  title: Text('Copier'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
