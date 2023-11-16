import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositionedTextState {
  final String id;
  final String text;
  final bool? isBold;
  final Offset offset;
  final double scaleMultiplier;

  const PositionedTextState({
    required this.id,
    required this.text,
    this.isBold,
    required this.offset,
    required this.scaleMultiplier,
  });

  PositionedTextState copyWith({
    String? id,
    String? text,
    Offset? offset,
    double? scaleMultiplier,
    bool? isBold,
  }) {
    return PositionedTextState(
      id: id ?? this.id,
      text: text ?? this.text,
      offset: offset ?? this.offset,
      scaleMultiplier: scaleMultiplier ?? this.scaleMultiplier,
      isBold: isBold ?? this.isBold,
    );
  }
}

class TextStateNotifier extends StateNotifier<List<PositionedTextState>> {
  TextStateNotifier(this.ref) : super([]);
  Ref ref;

  void addTextToStateList({
    required String text,
    required bool isBolded,
    // required Offset offset,
    required double multiplier,
  }) {
    if (text.isEmpty) {
      return;
    }
    final newList = state;

    final newOffset = const Offset(59.0, 97.7);

    newList.add(PositionedTextState(
      id: DateTime.now().toString() + '@42532532352r',
      offset: newOffset,
      scaleMultiplier: multiplier,
      text: text,
      isBold: isBolded,
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
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(
      offset: offset,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void toggleTextBold({
    required String id,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);
    var itemIsBold = item.isBold ?? false;

    final updatedItem = item.copyWith(
      isBold: !itemIsBold,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void resetState() {
    ref.invalidate(textStateProvider);
  }
}

final textStateProvider =
    StateNotifierProvider<TextStateNotifier, List<PositionedTextState>>(
  (ref) => TextStateNotifier(ref),
);

final showButtonProvider = StateProvider((ref) => false);
