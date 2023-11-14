import 'package:drag_n_drop/providers/text_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddContentTextField extends ConsumerStatefulWidget {
  const AddContentTextField({
    super.key,
  });

  @override
  ConsumerState<AddContentTextField> createState() =>
      _AddContentTextFieldState();
}

class _AddContentTextFieldState extends ConsumerState<AddContentTextField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: const InputDecoration(
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: 'Type Your Content Here',
        hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: 20,
        ),
        labelStyle: TextStyle(
          color: Colors.black38,
          fontSize: 20,
        ),
      ),
      onFieldSubmitted: (val) {
        ref.read(textStateProvider.notifier).addTextToStateList(
              text: val,
              // offset: Offset(80, 100),
              multiplier: 1,
            );

        textEditingController.clear();
      },
    );
  }
}
