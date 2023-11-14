import 'package:drag_n_drop/editor_screen/widgets/child_when_dragged_widget.dart';
import 'package:drag_n_drop/editor_screen/widgets/feed_back_widget.dart';
import 'package:drag_n_drop/providers/text_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DraggableNResizableText extends ConsumerStatefulWidget {
  final String id;
  final Offset initialOffset;
  final double multiplier;
  final String text;
  final BoxConstraints constraints;

  const DraggableNResizableText({
    required this.id,
    required this.text,
    required this.initialOffset,
    required this.multiplier,
    required this.constraints,
    super.key,
  });

  @override
  ConsumerState<DraggableNResizableText> createState() =>
      _DraggableNResizableTextState();
}

class _DraggableNResizableTextState
    extends ConsumerState<DraggableNResizableText> {
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
        feedback: FeedBackWidget(
          scaleVal: scaleMultiplier,
          txt: widget.text,
        ),
        onDragEnd: (details) {
          final adjustments =
              MediaQuery.of(context).size.height - widget.constraints.maxHeight;
          // setState(() {

          currentTextOffset = Offset(
            details.offset.dx,
            details.offset.dy - adjustments,
          );

          ref.read(textStateProvider.notifier).updateTextOffset(
                id: widget.id,
                offset: currentTextOffset,
              );

          // });
        },
        childWhenDragging: ChildWhenDraggingWidget(
          scaleMultiplier: scaleMultiplier,
          txt: widget.text,
        ),
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.2 * scaleMultiplier,
          width: MediaQuery.of(context).size.width * 0.8 * scaleMultiplier,
          child: Stack(
            // alignment: Alignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(fontSize: 14 * scaleMultiplier),
              ),
              InteractiveViewer(
                panEnabled: false,
                trackpadScrollCausesScale: true,
                transformationController: _controller,
                scaleEnabled: true,
                boundaryMargin: const EdgeInsets.all(0),
                minScale: 1,
                maxScale: 4,
                onInteractionUpdate: (details) {
                  final val = _controller.value.getMaxScaleOnAxis();

                  ref.read(textStateProvider.notifier).updateMultiplier(
                        id: widget.id,
                        multiplier: val,
                      );
                },
                onInteractionEnd: (data) {},
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery.of(context).size.height *
                      0.04 *
                      scaleMultiplier,
                  width: MediaQuery.of(context).size.width * scaleMultiplier,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
