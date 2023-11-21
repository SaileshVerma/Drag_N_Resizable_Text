import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<XFile> getXFileFromUint8List(imageInUnit8List) async {
  final tempDir = await getTemporaryDirectory();
  File file = await File('${tempDir.path}/image.png').create();
  file.writeAsBytesSync(imageInUnit8List);

  XFile xFile = XFile(file.path);

  return xFile;
}

Future<XFile> capturePng(globalKey) async {
  RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  Image image = await boundary.toImage(pixelRatio: 3.0);

  ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

  Uint8List pngBytes = byteData!.buffer.asUint8List();

  final byteImage = getXFileFromUint8List(pngBytes);
  // XFile file = XFile(byteImage.path);
  return byteImage;
}
