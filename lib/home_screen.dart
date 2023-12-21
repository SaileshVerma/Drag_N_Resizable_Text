import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:drag_n_drop/providers/text_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height > 926
        ? 1000.0
        : MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width > 428
        ? 450.0
        : MediaQuery.of(context).size.width;
    // final aspectRatio = MediaQuery.of(context).size.aspectRatio;
    final textState = ref.watch(textStateProvider);
    final imagesListState = ref.watch(imagesStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Your Highlight'),
      ),
      body: Center(
        child: Container(
          height: height * (MediaQuery.of(context).size.aspectRatio),
          width: width * (MediaQuery.of(context).size.aspectRatio),
          color: Colors.pink,
          child: Center(
            child: Stack(children: [
              Stack(
                children: List.generate(imagesListState.length, (index) {
                  final textData = imagesListState[index];
                  final containerHeight =
                      textData.scaleMultiplier * height * 0.2;
                  final containerWidth =
                      textData.scaleMultiplier * height * 0.2;

                  return Positioned(
                    left: textData.xUnit * width,
                    top: textData.yUnit * height,
                    child: Stack(
                      children: [
                        Container(
                          height: containerHeight,
                          width: containerWidth,
                          color: Colors.amber,
                          child: Center(
                            child: Text('$containerHeight X $containerWidth'),
                          ),
                        ),
                        Text(
                            '(${textData.xUnit * width},${textData.yUnit * height})'),
                      ],
                    ),
                  );
                }),
              ),
              Stack(
                children: List.generate(textState.length, (index) {
                  final textData = textState[index];

                  return Positioned(
                    left: textData.offset.dx,
                    top: textData.offset.dy,
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height *
                          0.2 *
                          textData.scaleMultiplier,
                      width: MediaQuery.of(context).size.width *
                          0.8 *
                          textData.scaleMultiplier,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Text(
                          textData.text,
                          style: TextStyle(
                            fontSize: 16 * (textData.scaleMultiplier),
                            fontWeight: (textData.isBold ?? false)
                                ? FontWeight.w700
                                : null,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
