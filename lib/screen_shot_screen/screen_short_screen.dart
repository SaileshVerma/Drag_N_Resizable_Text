import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:drag_n_drop/helpers/bytes_to_xfile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShortScreen extends StatefulWidget {
  const ScreenShortScreen({super.key});

  @override
  State<ScreenShortScreen> createState() => _ScreenShortScreenState();
}

class _ScreenShortScreenState extends State<ScreenShortScreen> {
  GlobalKey previewContainer = GlobalKey();

  List<XFile> capturedScreenshots = [];
  List<GlobalKey> pageKeys = List.generate(4, (index) => GlobalKey());
  ScreenshotController screenshotController = ScreenshotController();

  final List<ScreenshotController> pageControllers =
      List.generate(3, (index) => ScreenshotController());
  final PageController pageController = PageController();

  Future<void> captureScreenshots() async {
    for (int i = 0; i < 3; i++) {
      pageController.jumpToPage(i);
      Uint8List? imageBytes = await screenshotController.capture();

      // Wait for the next frame to ensure RepaintBoundary is ready
      if (imageBytes != null) {
        final xFileImage = await getXFileFromUint8List(imageBytes);
        setState(() {
          capturedScreenshots.add(xFileImage);
        });
      }
      print(
          'Captured @@@@@@@@@@@@@@  ${capturedScreenshots.length} screenshots.');
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Screenshot(
                  controller: screenshotController,
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.amber,
                    child: Center(
                      child: Text(
                        data[index],
                      ),
                    ),
                  ),
                );
              }),
          Visibility(
            visible: capturedScreenshots.isNotEmpty,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.green,
                height: 204,
                width: 154,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: capturedScreenshots.length,
                  itemBuilder: (ctx, index) => Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Image.file(File(capturedScreenshots[index].path)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await captureScreenshots();
              setState(() {
                isLoading = false;
              });
            },
            child: isLoading ? CircularProgressIndicator() : Icon(Icons.camera),
          ),
          FloatingActionButton(
            onPressed: () async {
              print('@@@@@@@@@@@@  ${capturedScreenshots.length}');
              setState(() {
                capturedScreenshots.clear();
              });
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

final data = [
  'THis is Screen First',
  'THis is Screen Second',
  'THis is Screen THIRD',
  'THis is Screen FOURTH'
];
