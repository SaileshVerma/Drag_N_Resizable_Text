import 'dart:io';

import 'package:flutter/material.dart';

class ChildWhenDraggingWidget extends StatelessWidget {
  final double scaleMultiplier;
  final String txt;

  const ChildWhenDraggingWidget({
    required this.scaleMultiplier,
    required this.txt,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Container(
        color: Colors.black12,
        height: MediaQuery.of(context).size.height * 0.04 * scaleMultiplier,
        width: MediaQuery.of(context).size.width * scaleMultiplier,
        child: Text(
          txt,
          style: TextStyle(fontSize: 14 * scaleMultiplier),
        ),
      ),
    );
  }
}

class ImageChildWhenDraggingWidget extends StatelessWidget {
  final double scaleMultiplier;
  final String imagePath;

  const ImageChildWhenDraggingWidget({
    required this.scaleMultiplier,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('################  $imagePath');
    return Opacity(
      opacity: 0.2,
      child: Container(
        height: 100 * scaleMultiplier,
        width: 100 * scaleMultiplier,
        color: Colors.black12,
        child: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
