import 'package:flutter/material.dart';

class ChildWhenDraggingWidget extends StatelessWidget {
  final double scaleMultiplier;
  final String txt;
  final bool? isBold;
  const ChildWhenDraggingWidget({
    required this.scaleMultiplier,
    required this.txt,
    this.isBold,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.04 * scaleMultiplier,
        width: MediaQuery.of(context).size.width * 0.8 * scaleMultiplier,
        child: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 16 * scaleMultiplier,
              fontWeight: (isBold ?? false) ? FontWeight.w700 : null,
            ),
          ),
        ),
      ),
    );
  }
}
