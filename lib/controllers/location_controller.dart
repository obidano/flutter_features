import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

class LocationController with ChangeNotifier {
  LocationData? localisationActuelle;
  Location location = Location();
  MethodChannel channel = MethodChannel('odc.channel');
  bool isGpsServiceEnabled = false;

  LocationController() {
    verifierGps();
  }

  listenKotlinResponse() {
    print('listenKotlinResponse');
    channel.setMethodCallHandler((call) async {
      print('channel cal method ${call.method}');
      if (call.method == 'fin_gps_fermeture') {
        verifierGps();
      }

      return Future.value(null);
    });
  }

  verifierGps() async {
    isGpsServiceEnabled = await location.serviceEnabled();
    print("isGpsServiceEnabled $isGpsServiceEnabled");
    notifyListeners();
  }

  recupererLocalisation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // demander la permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showToast("Echec demande permission", Colors.red);
        return;
      }
    }

    // demander l'activation du GPS
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        showToast("Echec activation GPS", Colors.red);
        return;
      }
    }

    isGpsServiceEnabled = true;
    notifyListeners();

    localisationActuelle = await location.getLocation();
    print(
        "INITIAL GPS Data: LAT=> ${localisationActuelle?.latitude} : LONG=> ${localisationActuelle?.longitude}");
    notifyListeners();

    location.onLocationChanged.listen((LocationData currentLocation) {
      print(
          "GPS Data: LAT=> ${currentLocation.latitude} : LONG=>${currentLocation.longitude}");
      localisationActuelle = currentLocation;
      notifyListeners();
    });
  }

  fermerGps() async {
    try {
      var reponse = await channel.invokeMethod('fermer_gps');
      print("reponse $reponse");
      print(reponse.runtimeType);
    } catch (error) {
      print(error);
    }
  }

  showToast(String message, [Color color = Colors.green]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
