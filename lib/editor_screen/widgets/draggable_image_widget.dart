import 'dart:io';
import 'package:drag_n_drop/editor_screen/widgets/image_holder_widget.dart';
import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';

class DraggableNResizableImage extends ConsumerStatefulWidget {
  final String id;
  final double multiplier;
  final String image;
  final BoxConstraints constraints;
  final double xUnit;
  final double yUnit;

  const DraggableNResizableImage({
    required this.id,
    required this.image,
    required this.multiplier,
    required this.constraints,
    required this.xUnit,
    required this.yUnit,
    super.key,
  });

  @override
  ConsumerState<DraggableNResizableImage> createState() =>
      _DraggableNResizableImageState();
}

class _DraggableNResizableImageState
    extends ConsumerState<DraggableNResizableImage> {
  double scaleMultiplier = 1;
  double scaleFactor = 1;
  double xUnit = 0;
  double yUnit = 0;

  @override
  void initState() {
    scaleFactor = widget.multiplier;

    xUnit = widget.xUnit;
    yUnit = widget.yUnit;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final aspectRatio = 1; //MediaQuery.of(context).size.aspectRatio;

    return Positioned(
      left: xUnit * width, //x-axis
      top: yUnit * height, //y-axis
      child: Draggable(
        onDragUpdate: (details) {
          setState(() {
            xUnit = (((xUnit * width) + details.delta.dx)) / width;
            yUnit = (((yUnit * height) + details.delta.dy)) / height;
          });

          ref.read(imagesStateProvider.notifier).updateImageOffsetUnits(
                id: widget.id,
                xUnit: xUnit,
                yUnit: yUnit,
              );
        },
        feedback: Material(
          color: Colors.transparent,
          child: SlideContentImageHolder(
            uid: '',
            imageHolderDimension: height * 0.3 * scaleFactor,
            imageUrl: widget.image,
            scaleFactor: scaleFactor,
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: SlideContentImageHolder(
            uid: '',
            imageHolderDimension: height * 0.3 * scaleFactor,
            imageUrl: widget.image,
            scaleFactor: scaleFactor,
          ),
        ),
        child: Container(
          color: Colors.transparent,
          height: height,
          width: width,
          child: PhotoView.customChild(
            basePosition: Alignment.topLeft,
            tightMode: true,
            enablePanAlways: false,
            heroAttributes: PhotoViewHeroAttributes(tag: "tag${widget.id}"),
            // minScale: PhotoViewComputedScale.contained,
            // maxScale: PhotoViewComputedScale.covered,
            // wantKeepAlive: true,
            initialScale: scaleFactor,
            backgroundDecoration: const BoxDecoration(
              color: Colors.amber,
            ),
            onScaleEnd: (ctx, value, details) {
              setState(() {
                scaleFactor = (details.scale ?? 1);
                print(
                    '################################################### ": $scaleFactor');
              });
              ref.read(imagesStateProvider.notifier).updateMultiplier(
                    multiplier: scaleFactor,
                    id: widget.id,
                  );
            },
            child: Container(
              height: 100,
              width: 100,
              child: Image.file(
                File(widget.image),
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
