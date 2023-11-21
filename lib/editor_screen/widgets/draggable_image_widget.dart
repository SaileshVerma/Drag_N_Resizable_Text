import 'dart:io';

import 'package:drag_n_drop/editor_screen/widgets/child_when_dragged_widget.dart';
import 'package:drag_n_drop/editor_screen/widgets/feed_back_widget.dart';
import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DraggableNResizableImage extends ConsumerStatefulWidget {
  final String id;
  final Offset initialOffset;
  final double multiplier;
  final String image;
  final BoxConstraints constraints;

  const DraggableNResizableImage({
    required this.id,
    required this.image,
    required this.initialOffset,
    required this.multiplier,
    required this.constraints,
    super.key,
  });

  @override
  ConsumerState<DraggableNResizableImage> createState() =>
      _DraggableNResizableImageState();
}

class _DraggableNResizableImageState
    extends ConsumerState<DraggableNResizableImage> {
  final TransformationController _controller = TransformationController();
  late Offset currentTextOffset;
  double scaleMultiplier = 1;

  @override
  void initState() {
    currentTextOffset = widget.initialOffset;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scaleMultiplier = widget.multiplier;
    currentTextOffset = widget.initialOffset;

    return Positioned(
      left: currentTextOffset.dx,
      top: currentTextOffset.dy,
      child: LongPressDraggable(
        maxSimultaneousDrags: 1,
        feedback: ImageFeedBackWidget(
          scaleVal: scaleMultiplier,
          imagePath: widget.image,
        ),
        onDragEnd: (details) {
          final adjustments =
              MediaQuery.of(context).size.height - widget.constraints.maxHeight;
          // setState(() {

          currentTextOffset = Offset(
            details.offset.dx,
            details.offset.dy - adjustments,
          );

          ref.read(imagesStateProvider.notifier).updateTextOffset(
                id: widget.id,
                offset: currentTextOffset,
              );

          // });
        },
        childWhenDragging: ImageChildWhenDraggingWidget(
          scaleMultiplier: scaleMultiplier,
          imagePath: widget.image,
        ),
        child: Container(
          color: Colors.transparent,
          height: 100 * scaleMultiplier,
          width: 100 * scaleMultiplier,
          // height: MediaQuery.of(context).size.height * 0.2 * scaleMultiplier,
          // width: MediaQuery.of(context).size.width * 0.8 * scaleMultiplier,
          child: Stack(
            // alignment: Alignment.center,
            children: [
              Container(
                  height: 100 * scaleMultiplier,
                  width: 100 * scaleMultiplier,
                  child: Image.network(widget.image)),
              InteractiveViewer(
                panEnabled: false,
                trackpadScrollCausesScale: true,
                transformationController: _controller,
                scaleEnabled: true,
                boundaryMargin: const EdgeInsets.all(0),
                minScale: 1,
                maxScale: 10,
                onInteractionUpdate: (details) {
                  final val = _controller.value.getMaxScaleOnAxis();

                  ref.read(imagesStateProvider.notifier).updateMultiplier(
                        id: widget.id,
                        multiplier: val,
                      );
                },
                onInteractionEnd: (data) {},
                child: Container(
                  height: 100 * scaleMultiplier,
                  width: 100 * scaleMultiplier,
                  color: Colors.transparent,
                  child: Opacity(
                    opacity: 0,
                    child: Image.network(
                      widget.image,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
