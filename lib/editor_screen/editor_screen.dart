import 'package:drag_n_drop/editor_screen/widgets/clear_screen_button.dart';
import 'package:drag_n_drop/editor_screen/widgets/draggable_image_widget.dart';
import 'package:drag_n_drop/editor_screen/widgets/draggable_resizable_text.dart';
import 'package:drag_n_drop/editor_screen/widgets/editor_textfield.dart';
import 'package:drag_n_drop/editor_screen/widgets/image_picker_action_button.dart';
import 'package:drag_n_drop/home_screen.dart';
import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:drag_n_drop/providers/text_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditorScreen extends ConsumerWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textListProvider = ref.watch(textStateProvider);
    final imagesProvider = ref.watch(imagesStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Your Editor'),
        backgroundColor: Colors.white,
        actions: [
          const ClearActionButtonWidget(),
          const ImagePickerActionButton(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: EditorBody(
        textListProvider: textListProvider,
        imagesListProvider: imagesProvider,
      ),
    );
  }
}

class EditorBody extends StatelessWidget {
  const EditorBody({
    super.key,
    required this.textListProvider,
    required this.imagesListProvider,
  });

  final List<PositionedTextState> textListProvider;
  final List<PositionedImageState> imagesListProvider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(
              children: [
                Visibility(
                  visible: imagesListProvider.isNotEmpty,
                  child: Stack(
                    children: List.generate(imagesListProvider.length, (index) {
                      final textItem = imagesListProvider[index];

                      return DraggableNResizableImage(
                        id: textItem.id,
                        image: textItem.image,
                        xUnit: textItem.xUnit,
                        yUnit: textItem.yUnit,
                        multiplier: textItem.scaleMultiplier,
                        constraints: constraints,
                      );
                    }),
                  ),
                ),
                Stack(
                  children: List.generate(textListProvider.length, (index) {
                    final textItem = textListProvider[index];

                    return DraggableNResizableText(
                      isBold: textItem.isBold,
                      id: textItem.id,
                      text: textItem.text,
                      initialOffset: textItem.offset,
                      multiplier: textItem.scaleMultiplier,
                      constraints: constraints,
                    );
                  }),
                ),
              ],
            );
          },
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AddContentTextField(),
          ),
        ),
      ],
    );
  }
}
