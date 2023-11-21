import 'dart:convert';
import 'dart:io';

import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:drag_n_drop/providers/text_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textState = [
      {
        'id': '2023-11-21 13:58:15.739017@42532532352r',
        'text': 'ENGINEERING',
        'offsetX': '-46.9999999999998',
        'offsetY': '162.3666666666668',
        'scaleMultiplier': '2.5566236002072187',
        'isBold': 'true'
      },
    ];
    // final imagesListState = ref.watch(imagesStateProvider);
    final imagesListState = [
      {
        'id': '2023-11-21T13:41:09.024525',
        'imageURL':
            'https://fifo.im/_next/image?url=https%3A%2F%2Fmedia.glue.is%2Fget-file%2Fpost_media%2F7SM0WEFR9MN1XSJQQ1S87-large&w=1080&q=75',
        'offsetX': '18.333333333333428',
        'offsetY': '134.03333333333296',
        'scaleMultiplier': '3.300770224247944'
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Your Highlight'),
      ),
      body: Stack(children: [
        Stack(
          children: List.generate(imagesListState.length, (index) {
            final textData = PositionedImageState.fromJson(
              json: imagesListState[index],
            );

            return Positioned(
              left: textData.offset.dx,
              top: textData.offset.dy,
              child: Container(
                height: 100 * textData.scaleMultiplier,
                width: 100 * textData.scaleMultiplier,
                // color: Colors.black12,
                child: Image.network(
                  textData.image,
                ),
              ),
            );
          }),
        ),
        Stack(
          children: List.generate(textState.length, (index) {
            final textData =
                PositionedTextState.fromJson(json: textState[index]);

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
