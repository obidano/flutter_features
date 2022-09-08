import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:odc_flutter_features/controllers/app_controller.dart';
import 'package:odc_flutter_features/controllers/gallery_controller.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CameraImagePage extends StatefulWidget {
  String title;
  bool isVideo;

  CameraImagePage({required this.title, this.isVideo = false});

  @override
  State<CameraImagePage> createState() => _CameraImagePageState();
}

class _CameraImagePageState extends State<CameraImagePage> {
  var saisieController = TextEditingController();
  DateTime? tempChoisie;
  var formKey = GlobalKey<FormState>();
  File? selectedImage;

  // pour la video
  VideoPlayerController? videoController;
  ChewieController? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (videoController != null) videoController!.dispose();
    if (chewieController != null) chewieController!.dispose();
  }

  chargerVideo() async {
    // a executer une fois, la video enregistrée
    videoController = VideoPlayerController.file(selectedImage!);
    await videoController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: false,
      looping: false,
    );
    setState(() {});
  }

  traitementCameraImage() async {
    var galleryCtrl = context.read<GalleryContoller>();
    var appCtrl = context.read<AppController>();
    var resultatImage =
        await galleryCtrl.ouvrirCameraImage(context, widget.isVideo);
    if (resultatImage != null) {
      selectedImage = resultatImage;
      setState(() {});
    } else {
      appCtrl.showSnackBar(context, "Aucune image selectionnée", false);
    }
  }

  traitementCameraVideo() async {
    var galleryCtrl = context.read<GalleryContoller>();
    var appCtrl = context.read<AppController>();
    var resultatImage =
        await galleryCtrl.ouvrirCameraImage(context, widget.isVideo);
    if (resultatImage != null) {
      selectedImage = resultatImage;
      chargerVideo();
    } else {
      appCtrl.showSnackBar(context, "Aucune video enregistrée", false);
    }
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
            if (widget.isVideo) videoPrevisuation(context),
            if (!widget.isVideo) imagePrevisualisation(context),
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
                if (widget.isVideo) {
                  traitementCameraVideo();
                } else {
                  traitementCameraImage();
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
                    'Ouvrir Camera',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  videoPrevisuation(BuildContext context) {
    return Expanded(
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.grey.withOpacity(.4))),
            child:
                videoController != null && videoController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: videoController!.value.aspectRatio,
                        child: Chewie(controller: chewieController!),
                      )
                    : Container()));
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
