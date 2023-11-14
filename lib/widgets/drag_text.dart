import 'package:flutter/material.dart';

class DraggableText extends StatelessWidget {
  const DraggableText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const text =
        'nav bar mode ignore false downX 573 downY 1784 mScreenHeight ? nav bar mode ignore false downX 573 downY 1784 mScreenHeight ?nav bar mode ignore false downX 573 downY 1784 mScreenHeight ?';
    return Draggable(
      data: text,
      childWhenDragging: Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.black.withOpacity(0.1)),
      ),
      feedback: const Material(
        color: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 40,
            color: Colors.blue,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }
}
