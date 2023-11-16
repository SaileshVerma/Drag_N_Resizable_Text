import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositionedImageState {
  final String id;
  final String image;
  final Offset offset;
  final double scaleMultiplier;

  const PositionedImageState({
    required this.id,
    required this.image,
    required this.offset,
    required this.scaleMultiplier,
  });

  PositionedImageState copyWith({
    String? id,
    String? image,
    Offset? offset,
    double? scaleMultiplier,
  }) {
    return PositionedImageState(
      id: id ?? this.id,
      image: image ?? this.image,
      offset: offset ?? this.offset,
      scaleMultiplier: scaleMultiplier ?? this.scaleMultiplier,
    );
  }
}

class ImagesStateNotifier extends StateNotifier<List<PositionedImageState>> {
  ImagesStateNotifier(this.ref) : super([]);

  Ref ref;

  void addImageToStateList({
    required String image,
  }) {
    final newList = state;

    final newOffset = Offset(134.0, 172.7);

    newList.add(PositionedImageState(
      id: DateTime.now().toIso8601String(),
      offset: newOffset,
      scaleMultiplier: 1,
      image: image,
    ));

    state = [...newList];
  }

  void updateMultiplier({
    required String id,
    required double multiplier,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(
      scaleMultiplier: multiplier,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void updateTextOffset({
    required String id,
    required Offset offset,
  }) {
    final newList = [...state];
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(
      offset: offset,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void resetState() {
    ref.invalidate(imagesStateProvider);
  }
}

final imagesStateProvider =
    StateNotifierProvider<ImagesStateNotifier, List<PositionedImageState>>(
  (ref) => ImagesStateNotifier(ref),
);
