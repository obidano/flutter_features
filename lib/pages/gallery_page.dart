import 'dart:io';

import 'package:flutter/material.dart';
import 'package:odc_flutter_features/controllers/app_controller.dart';
import 'package:odc_flutter_features/controllers/gallery_controller.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatefulWidget {
  String title;

  GalleryPage({required this.title});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  File? selectedImage;

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
                selectedImage = null;
                setState(() {});
              },
              icon: Icon(Icons.delete))
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
            imagePrevisualisation(context),
            buttonOuvrirGallery(context),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  buttonOuvrirGallery(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10)),
              onPressed: () async {
                var galleryCtrl = context.read<GalleryContoller>();
                var appCtrl = context.read<AppController>();
                var resultatImage = await galleryCtrl.ouvrirGallerie(context);
                if (resultatImage != null) {
                  selectedImage = resultatImage;
                  setState(() {});
                } else {
                  appCtrl.showSnackBar(context, "Aucune image selectionnée", false);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_camera_back_sharp,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Ouvrir Gallerie Photos',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  imagePrevisualisation(BuildContext context) {
    return Expanded(
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.grey.withOpacity(.4))),
            child: selectedImage != null
                ? Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.image)));
  }
}
