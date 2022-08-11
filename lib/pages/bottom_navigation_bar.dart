import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarPage extends StatefulWidget {
  String title;

  BottomNavigationBarPage({required this.title});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  List<String> utilisateurs = [Faker().person.name()];
  int selectedIndex = 0;
  List choixCouleursMap = [Colors.orange, Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: bottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Container(
              color: choixCouleursMap[selectedIndex],
              padding: EdgeInsets.all(80),
              child: Text(
                'Naviguer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )),
          ],
        ),
      ),
    );
  }

  bottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: this.selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.phone),
          label: "Orange",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: "Bleu",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.energy_savings_leaf),
          label: "Vert",
        )
      ],
      onTap: (int index) {
        selectedIndex = index;
        setState(() {});
      },
    );
  }


}
