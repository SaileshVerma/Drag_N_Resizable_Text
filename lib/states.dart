import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositionedTextState {
  final String id;
  final String text;
  final Offset offset;
  final double scaleMultiplier;

  const PositionedTextState({
    required this.id,
    required this.text,
    required this.offset,
    required this.scaleMultiplier,
  });

  PositionedTextState copyWith({
    String? id,
    String? text,
    Offset? offset,
    double? scaleMultiplier,
  }) {
    return PositionedTextState(
      id: id ?? this.id,
      text: text ?? this.text,
      offset: offset ?? this.offset,
      scaleMultiplier: scaleMultiplier ?? this.scaleMultiplier,
    );
  }
}

class TextStateNotifier extends StateNotifier<List<PositionedTextState>> {
  TextStateNotifier() : super([]);

  void addTextToStateList({
    required String text,
    // required Offset offset,
    required double multiplier,
  }) {
    final newList = state;

    final newOffset = state.isEmpty
        ? const Offset(80, 100)
        : Offset(
            state[state.length - 1].offset.dx - 20,
            state[state.length - 1].offset.dy - 20,
          );
    newList.add(PositionedTextState(
      id: DateTime.now().toString(),
      offset: newOffset,
      scaleMultiplier: multiplier,
      text: text,
    ));

    state = newList;
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
}

final textStateProvider =
    StateNotifierProvider<TextStateNotifier, List<PositionedTextState>>(
  (ref) => TextStateNotifier(),
);
