import 'dart:io';

import 'package:flutter/material.dart';

class FeedBackWidget extends StatelessWidget {
  final bool? isBold;

  const FeedBackWidget({
    super.key,
    required this.scaleVal,
    required this.txt,
    this.isBold,
  });

  final double scaleVal;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.04 * scaleVal,
          width: MediaQuery.of(context).size.width * 0.8 * scaleVal,
          child: Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: Text(
              txt,
              style: TextStyle(
                fontSize: 16 * scaleVal,
                fontWeight: (isBold ?? false) ? FontWeight.w700 : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageFeedBackWidget extends StatelessWidget {
  final double scaleVal;
  final String imagePath;

  const ImageFeedBackWidget({
    super.key,
    required this.scaleVal,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          height: 100 * scaleVal,
          width: 100 * scaleVal,
          color: Colors.transparent,
          child: Image.network(
            imagePath,
          ),
        ),
      ),
    );
  }
}
