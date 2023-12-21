import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositionedImageState {
  final String id;
  final String image;
  final double xUnit;
  final double yUnit;
  final double scaleMultiplier;

  const PositionedImageState({
    required this.id,
    required this.image,
    required this.scaleMultiplier,
    required this.xUnit,
    required this.yUnit,
  });

  PositionedImageState copyWith({
    String? id,
    String? image,
    double? scaleMultiplier,
    double? xUnit,
    double? yUnit,
  }) {
    return PositionedImageState(
      id: id ?? this.id,
      image: image ?? this.image,
      scaleMultiplier: scaleMultiplier ?? this.scaleMultiplier,
      xUnit: xUnit ?? this.xUnit,
      yUnit: yUnit ?? this.yUnit,
    );
  }

  factory PositionedImageState.fromJson({required Map<String, dynamic> json}) {
    return PositionedImageState(
      id: json['id'],
      image: json['imageURL'],
      scaleMultiplier: double.parse(json['scaleMultiplier']),
      xUnit: double.parse(json['xUnit']),
      yUnit: double.parse(json['yUnit']),
    );
  }

  Map toJson() => {
        'id': id,
        'imageURL': image,
        'scaleMultiplier': scaleMultiplier,
        'xUnit': xUnit,
        'yUnit': yUnit,
      };
}

class ImagesStateNotifier extends StateNotifier<List<PositionedImageState>> {
  ImagesStateNotifier(this.ref) : super([]);

  Ref ref;

  void addImageToStateList({
    required String image,
  }) {
    final newList = state;

    final newOffset = Offset(134.0, 172.7);

    newList.add(
      PositionedImageState(
        id: DateTime.now().toIso8601String(),
        xUnit: 0.2,
        yUnit: 0.2,
        scaleMultiplier: 1,
        image: image,
      ),
    );

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

  void updateImageOffsetUnits({
    required String id,
    required double xUnit,
    required double yUnit,
  }) {
    final newList = [...state];
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(
      xUnit: xUnit,
      yUnit: yUnit,
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
