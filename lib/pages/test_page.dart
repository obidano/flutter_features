import 'package:flutter/material.dart';
import 'package:odc_flutter_features/controllers/app_controller.dart';
import 'package:odc_flutter_features/pages/tabs_page.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var title = context.read<AppController>().title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('appbarTitle'),
        ),
        body: Column(
          children: [
            section1(),
            zoneImage(),
          ],
        ));
  }

  naviguerVersUneAutrePage() {
    var title = context.read<AppController>().title;
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => TabsPage(title: title)));
  }

  Image zoneImage() => Image.asset("assets/icon.png");

  Container section1() {
    return Container(
      child: Text("Section 1"),
    );
  }
}
