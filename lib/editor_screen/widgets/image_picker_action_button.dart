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
        final url =
            'https://fifo.im/_next/image?url=https%3A%2F%2Fmedia.glue.is%2Fget-file%2Fpost_media%2F7SM0WEFR9MN1XSJQQ1S87-large&w=1080&q=75';
        ref.read(imagesStateProvider.notifier).addImageToStateList(
              image: url,
            );
      },
      icon: const Icon(Icons.image),
    );
  }
}
