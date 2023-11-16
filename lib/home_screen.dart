import 'dart:io';

import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:drag_n_drop/providers/text_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textState = ref.watch(textStateProvider);
    final imagesListState = ref.watch(imagesStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Your Highlight'),
      ),
      body: Stack(children: [
        Stack(
          children: List.generate(imagesListState.length, (index) {
            final textData = imagesListState[index];

            return Positioned(
              left: textData.offset.dx,
              top: textData.offset.dy,
              child: Container(
                height: 100 * textData.scaleMultiplier,
                width: 100 * textData.scaleMultiplier,
                // color: Colors.black12,
                child: Image.file(
                  File(textData.image),
                ),
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
                      fontWeight:
                          (textData.isBold ?? false) ? FontWeight.w700 : null,
                    ),
                  ),
                ),
              ),
            );
          }),
        )
      ]),
    );
  }
}
