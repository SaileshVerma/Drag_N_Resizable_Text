import 'package:drag_n_drop/home_page_widgets/child_when_dragged_widget.dart';
import 'package:drag_n_drop/home_page_widgets/feed_back_widget.dart';
import 'package:drag_n_drop/home_screen.dart';
import 'package:drag_n_drop/states.dart';
import 'package:drag_n_drop/widgets/drag_target_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditorScreen extends ConsumerWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textListProvider = ref.watch(textStateProvider);
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Your Editor'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.green,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return Stack(
                  children: List.generate(textListProvider.length, (index) {
                    final textItem = textListProvider[index];

                    return DraggableNResizableText(
                      id: textItem.id,
                      text: textItem.text,
                      initialOffset: textItem.offset,
                      multiplier: textItem.scaleMultiplier,
                      constraints: constraints,
                    );
                  }),
                );
              },
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: AddContentTextField(),
            ),
          ),
        ],
      ),
    );
  }
}

class AddContentTextField extends ConsumerStatefulWidget {
  const AddContentTextField({
    super.key,
  });

  @override
  ConsumerState<AddContentTextField> createState() =>
      _AddContentTextFieldState();
}

class _AddContentTextFieldState extends ConsumerState<AddContentTextField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: const InputDecoration(
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: 'Type Your Content Here',
        hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: 20,
        ),
        labelStyle: TextStyle(
          color: Colors.black38,
          fontSize: 20,
        ),
      ),
      onFieldSubmitted: (val) {
        ref.read(textStateProvider.notifier).addTextToStateList(
              text: val,
              // offset: Offset(80, 100),
              multiplier: 1,
            );

        textEditingController.clear();
      },
    );
  }
}

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
