import 'package:flutter/material.dart';

enum ShapeType {
  circle,
  square,
  triangle,
  rectangle,
  star,
  heart,
  diamond,
  pentagon,
}

class ShapeModel {
  final ShapeType type;
  final Color color;
  final String name;
  bool isPlaced;

  ShapeModel({
    required this.type,
    required this.color,
    required this.name,
    this.isPlaced = false,
  });

  String get colorName {
    if (color == ShapeColors.red) return 'Red';
    if (color == ShapeColors.blue) return 'Blue';
    if (color == ShapeColors.yellow) return 'Yellow';
    if (color == ShapeColors.green) return 'Green';
    if (color == ShapeColors.orange) return 'Orange';
    if (color == ShapeColors.purple) return 'Purple';
    if (color == ShapeColors.pink) return 'Pink';
    return '';
  }
}

class ShapeColors {
  static const Color red = Color(0xFFE53935);
  static const Color blue = Color(0xFF1E88E5);
  static const Color yellow = Color(0xFFFDD835);
  static const Color green = Color(0xFF43A047);
  static const Color orange = Color(0xFFFB8C00);
  static const Color purple = Color(0xFF8E24AA);
  static const Color pink = Color(0xFFE91E8C);
}

class LevelData {
  final String name;
  final String emoji;
  final List<ShapeModel> shapes;
  final double targetSize;

  LevelData({
    required this.name,
    required this.emoji,
    required this.shapes,
    required this.targetSize,
  });
}

LevelData getLevel(int level) {
  switch (level) {
    case 0:
      return LevelData(
        name: 'Starter',
        emoji: '🌱',
        targetSize: 110,
        shapes: [
          ShapeModel(type: ShapeType.circle, color: ShapeColors.red, name: 'Circle'),
          ShapeModel(type: ShapeType.square, color: ShapeColors.blue, name: 'Square'),
          ShapeModel(type: ShapeType.triangle, color: ShapeColors.yellow, name: 'Triangle'),
        ],
      );
    case 1:
      return LevelData(
        name: 'Explorer',
        emoji: '🌤️',
        targetSize: 90,
        shapes: [
          ShapeModel(type: ShapeType.circle, color: ShapeColors.red, name: 'Circle'),
          ShapeModel(type: ShapeType.square, color: ShapeColors.blue, name: 'Square'),
          ShapeModel(type: ShapeType.triangle, color: ShapeColors.yellow, name: 'Triangle'),
          ShapeModel(type: ShapeType.rectangle, color: ShapeColors.green, name: 'Rectangle'),
          ShapeModel(type: ShapeType.star, color: ShapeColors.orange, name: 'Star'),
        ],
      );
    case 2:
    default:
      return LevelData(
        name: 'Champion',
        emoji: '🌈',
        targetSize: 75,
        shapes: [
          ShapeModel(type: ShapeType.circle, color: ShapeColors.red, name: 'Circle'),
          ShapeModel(type: ShapeType.square, color: ShapeColors.blue, name: 'Square'),
          ShapeModel(type: ShapeType.triangle, color: ShapeColors.yellow, name: 'Triangle'),
          ShapeModel(type: ShapeType.rectangle, color: ShapeColors.green, name: 'Rectangle'),
          ShapeModel(type: ShapeType.star, color: ShapeColors.orange, name: 'Star'),
          ShapeModel(type: ShapeType.heart, color: ShapeColors.purple, name: 'Heart'),
          ShapeModel(type: ShapeType.diamond, color: ShapeColors.pink, name: 'Diamond'),
          ShapeModel(type: ShapeType.pentagon, color: ShapeColors.red, name: 'Pentagon'),
        ],
      );
  }
}