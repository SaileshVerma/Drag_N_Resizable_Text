import 'package:flutter/material.dart';

class ChildWhenDraggingWidget extends StatelessWidget {
  const ChildWhenDraggingWidget({
    super.key,
    required this.scaleMultiplier,
    required this.txt,
  });

  final double scaleMultiplier;
  final String txt;

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
