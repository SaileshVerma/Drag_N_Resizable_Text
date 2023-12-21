import 'package:flutter/material.dart';
import 'dart:math' as math;

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final TransformationController _controller = TransformationController();
  double prevScale = 1;
  double scale = 1;
  var xUnit = 0.2;
  var yUnit = 0.2;
  double prevScale2 = 1;
  double scale2 = 1;
  var xUnit2 = 0.2;
  var yUnit2 = 0.2;
  // var scale = 1.0;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);
  void commitScale() => setState(() => prevScale = scale);
  var isAllowed = false;
  late Offset currentTextOffset;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // height = height > 1100 ? 1100 : height;
    // width = width > 450 ? 450 : width;

    final aspectRatio = width / height;
    final containerHeight = height * 0.4 * scale * aspectRatio;
    final containerWidth = height * 0.4 * scale * aspectRatio;

    return Scaffold(
      body: Center(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Stack(
              children: [
                Positioned(
                  top: yUnit * height,
                  left: xUnit * width,
                  child: LongPressDraggable(
                    maxSimultaneousDrags: 1,
                    feedback: Container(
                      height: containerHeight * 1.09,
                      width: containerWidth * 1.09,
                      color: Colors.amber,
                      child: const FlutterLogo(),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.9,
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        color: Colors.amber,
                        child: const FlutterLogo(),
                      ),
                    ),
                    onDragUpdate: (details) {
                      setState(() {
                        xUnit = (((xUnit * width) + details.delta.dx)) / width;
                        yUnit =
                            (((yUnit * height) + details.delta.dy)) / height;
                      });
                    },
                    child: GestureDetector(
                      onScaleUpdate: (details) => updateScale(details.scale),
                      onScaleEnd: (_) => commitScale(),
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        color: Colors.amber,
                        child: const FlutterLogo(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: yUnit2 * height * 1, //y-axis
                  left: xUnit2 * width * 1, //x-axis

                  // right:
                  //     (width - (containerWidth + (xUnit2 * width * aspectRatio))),
                  // bottom: (height -
                  //     (containerHeight + (yUnit2 * height * aspectRatio))),
                  child: GestureDetector(
                    // onScaleUpdate: (details) => updateScale(details.scale),
                    // onScaleEnd: (_) => commitScale(),
                    onPanUpdate: (delta) {
                      setState(() {
                        xUnit2 = (((xUnit2 * width) + delta.delta.dx)) / width;
                        yUnit2 =
                            (((yUnit2 * height) + delta.delta.dy)) / height;
                      });
                    },

                    child: Container(
                      height: containerHeight,
                      width: containerWidth,
                      color: Colors.blue,
                      child: const FlutterLogo(),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
