import 'package:drag_n_drop/widgets/drag_text.dart';
import 'package:flutter/material.dart';

class DragTargetTextHolder extends StatefulWidget {
  const DragTargetTextHolder({
    super.key,
  });

  @override
  State<DragTargetTextHolder> createState() => _DragTargetTextHolderState();
}

String text = '';
bool isVisible = false;

class _DragTargetTextHolderState extends State<DragTargetTextHolder> {
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (
        ctx,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return accepted.isEmpty
            ? Visibility.maintain(
                visible: isVisible, child: const DraggableText())
            : Container(
                height: 80,
                width: 100,
                child: Text(text),
                decoration:
                    BoxDecoration(color: Colors.green, border: Border.all()),
              );
      },
      onAccept: (data) {
        setState(() {
          text = data as String;
          isVisible = true;
        });
      },
    );
  }
}
