import 'package:drag_n_drop/states.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textState = ref.watch(textStateProvider);
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Your Highlight'),
      ),
      body: Stack(children: [
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
                child: Text(
                  textData.text,
                  style: TextStyle(
                    fontSize: 14 * (textData.scaleMultiplier),
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
