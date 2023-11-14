import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:drag_n_drop/providers/text_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClearActionButtonWidget extends ConsumerWidget {
  const ClearActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(imagesStateProvider.notifier).resetState();
        ref.read(textStateProvider.notifier).resetState();
      },
      child: const Text(
        'CLEAR',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
