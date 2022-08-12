import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class GalleryContoller with ChangeNotifier {
  GalleryContoller();

  Future<File?>? ouvrirGallerie(BuildContext context) async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(maxAssets: 1));
    print(result);
    if (result != null) {
      AssetEntity imageAsset = result[0];
      File file = await imageAsset.file as File;
      return file;
    }
    return null;
  }

  Future<File?>? ouvrirCameraImage(BuildContext context, bool isVideo) async {
    final AssetEntity? result = await CameraPicker.pickFromCamera(context,
        pickerConfig: CameraPickerConfig(
            enableRecording: isVideo,
            onlyEnableRecording: isVideo,
            enableTapRecording: isVideo));
    print(result);
    if (result != null) {
      var type = result.type.name;
      print("type $type");
      File file = await result.file as File;
      return file;
    }
    return null;
  }
}
