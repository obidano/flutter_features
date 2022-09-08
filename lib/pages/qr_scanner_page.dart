import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  String title;

  QRCodeScannerPage({required this.title});

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  String scannedData = '';

  @override
  initState() {
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
            Expanded(
              child: qrCodeScanner(context),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Données scannées",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                scannedData,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  qrCodeScanner(BuildContext context) {
    return Center(
      child: MobileScanner(onDetect: (barcode, args) {
        var msg = "";
        var color = Colors.red;
        if (barcode.rawValue == null) {
          debugPrint('Failed to scan QR CODE');
          msg = "Aucun QR Code reconnu";
        } else {
          String code = barcode.rawValue!;
          debugPrint('QR Code found! $code');
          msg = "QR Code Reconnu";
          color = Colors.green;
          scannedData = code;
          setState(() {});
        }

        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: color,
            textColor: Colors.white,
            fontSize: 16.0);
      }),
    );
  }
}
