import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<ui.Image> loadImageByProvider(ImageProvider provider) async {
    Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    ImageStream stream = provider.resolve(ImageConfiguration.empty); //获取图片流
    ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      final ui.Image image = frame.image;
      completer.complete(image); //完成
      stream.removeListener(listener); //移除监听
    });
    stream.addListener(listener); //添加监听
    return completer.future;
  }

  static Future<ui.Image> loadByXFile(XFile xFile) async {
    Completer<ui.Image> completer = Completer();
    Uint8List uint8list = await xFile.readAsBytes();
    ui.decodeImageFromList(uint8list, (result) {
      print(result);
      completer.complete(result);
    });
    return completer.future;
  }
}
