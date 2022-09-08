import 'package:flutter/material.dart';
import 'package:odc_flutter_features/controllers/notification_controller.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  String title;

  NotificationPage({required this.title});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int compteur = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            buttonAfficherNotifs(context),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  buttonAfficherNotifs(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10)),
              onPressed: () async {
                context
                    .read<NotificationController>()
                    .afficherNotification("#$compteur Hello ODC");
                compteur++;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Afficher une notification',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
