import 'package:flutter/foundation.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.flavorLine,
    required this.imageAsset,
    required this.notes,
  });

  final String id;
  final String name;
  final String flavorLine;
  final String imageAsset;

  /// Short ingredient / tasting notes revealed on hover/tap.
  final List<String> notes;
}
