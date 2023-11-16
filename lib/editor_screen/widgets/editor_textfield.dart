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

  bool isBolded = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        ref.read(showButtonProvider.notifier).state = true;
      },
      // onTapOutside: (_) {
      //   ref.read(showButtonProvider.notifier).state = false;
      // },
      controller: textEditingController,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: isBolded ? FontWeight.w700 : FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIcon: ref.watch(showButtonProvider)
            ? TextButton(
                onPressed: () {
                  setState(() {
                    isBolded = !isBolded;
                  });
                },
                child: const Text(
                  'BOLD',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : null,
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
              isBolded: isBolded,
              multiplier: 1,
            );

        textEditingController.clear();
        ref.read(showButtonProvider.notifier).state = false;
        setState(() {
          isBolded = false;
        });
      },
    );
  }
}
