import 'package:drag_n_drop/providers/image_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerActionButton extends ConsumerWidget {
  const ImagePickerActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        ImagePicker picker = ImagePicker();
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        image?.path;

        ref.read(imagesStateProvider.notifier).addImageToStateList(
              image: image?.path ?? '',
            );
      },
      icon: const Icon(Icons.image),
    );
  }
}
