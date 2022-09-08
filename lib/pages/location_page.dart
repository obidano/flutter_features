import 'package:flutter/material.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:odc_flutter_features/controllers/location_controller.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  String title;

  LocationPage({required this.title});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationController>().listenKotlinResponse();
    });
  }

  @override
  Widget build(BuildContext context) {
    LocationData? localisation =
        context
            .watch<LocationController>()
            .localisationActuelle;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          if (context
              .watch<LocationController>()
              .isGpsServiceEnabled)
            IconButton(
                onPressed: () {
                  ouvrirConfirmationDialog(context);
                },
                icon: Icon(Icons.location_disabled))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            latLongitudeView(
                "Longitude",
                localisation != null
                    ? localisation.longitude.toString()
                    : "0.0"),
            SizedBox(
              height: 20,
            ),
            latLongitudeView(
                "Latitude",
                localisation != null
                    ? localisation.latitude.toString()
                    : "0.0"),
            SizedBox(
              height: 40,
            ),
            buttonDemanderLocalisation(context),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  buttonDemanderLocalisation(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10)),
              onPressed: () async {
                context.read<LocationController>().recupererLocalisation();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Demander la localisation',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  latLongitudeView(String title, String contenu) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contenu,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      trailing: Icon(Icons.my_location_outlined),
    );
  }

  ouvrirConfirmationDialog(BuildContext context) async {
    bool? resulat = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Location"),
          content: new Text("Fermeture du service GPS"),
          actions: <Widget>[
            TextButton(
              child: new Text(
                "Annuler",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            new TextButton(
              child: new Text("Confirmer"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
// code executé apres fermeture de la boite de dialogue
    if (resulat != null) {
      context.read<LocationController>().fermerGps();
    }
  }
}
