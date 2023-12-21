import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';

class SlideContentImageHolder extends ConsumerWidget {
  final String uid;
  final String imageUrl;
  final double imageHolderDimension;
  final double scaleFactor;

  const SlideContentImageHolder({
    required this.uid,
    required this.imageUrl,
    required this.imageHolderDimension,
    required this.scaleFactor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: PhotoView.customChild(
        basePosition: Alignment.topLeft,
        tightMode: true,
        enablePanAlways: false,
        // heroAttributes: PhotoViewHeroAttributes(
        //     tag: "tag${widget.slideImageContentObject?.id ?? ''}"),
        // minScale: PhotoViewComputedScale.contained,
        // maxScale: PhotoViewComputedScale.covered,
        wantKeepAlive: false,
        disableGestures: true,
        initialScale: scaleFactor,
        backgroundDecoration: const BoxDecoration(color: Colors.transparent),

        child: SizedBox(
          height: (height * 0.3 * scaleFactor),
          width: (height * 0.3 * scaleFactor),
          child: Image.file(
            File(imageUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
