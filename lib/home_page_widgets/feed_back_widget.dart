import 'package:flutter/material.dart';

class FeedBackWidget extends StatelessWidget {
  const FeedBackWidget({
    super.key,
    required this.scaleVal,
    required this.txt,
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
          color: Colors.black12,
          height: MediaQuery.of(context).size.height * 0.04 * scaleVal,
          width: MediaQuery.of(context).size.width * scaleVal,
          child: Text(
            txt,
            style: TextStyle(fontSize: 14 * scaleVal),
          ),
        ),
      ),
    );
  }
}
