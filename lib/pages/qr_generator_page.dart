import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGeneratorPage extends StatefulWidget {
  String title;

  QRCodeGeneratorPage({required this.title});

  @override
  State<QRCodeGeneratorPage> createState() => _QRCodeGeneratorPageState();
}

class _QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  List<String> qr_code_data = [
    "Bienvenue à l'ODC",
    "ODC est Centre numerique d'apprentissage",
    "Ce QR Code contient des informations utilisables une fois scannées",
    "https://www.orangedigitalcenters.com/country/CD/home"
  ];

  String selectedData = '';

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      genererQRCOde();
    });
  }

  genererQRCOde() {
    var randomIndex = Random().nextInt(qr_code_data.length);
    print("randomIndex $randomIndex");
    selectedData = qr_code_data[randomIndex];
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
              onPressed: () {
                genererQRCOde();
              },
              icon: Icon(Icons.sync))
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
            qrCodePrevisualisation(context),
            SizedBox(
              height: 10,
            ),
            Text(
              "Données du QR Code",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                  fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              selectedData,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  qrCodePrevisualisation(BuildContext context) {
    return Center(
      child: QrImage(
        data: selectedData,
        version: QrVersions.auto,
        size: 200.0,
        gapless: true,
        embeddedImage: AssetImage('assets/app_icon.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(50, 40),
        ),
      ),
    );
  }
}
