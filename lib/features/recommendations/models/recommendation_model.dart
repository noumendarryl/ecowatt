import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation_model.freezed.dart';
// part 'recommendation_model.g.dart';

@freezed
class RecommendationModel with _$RecommendationModel {
  const factory RecommendationModel({
    required String rid,
    required String title,
    required String category,
    required IconData icon,
    required List<String> tips,
    required String impact,
  }) = _RecommendationModel;

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      rid: json['rid'],
      title: json['title'],
      category: json['category'],
      icon: _parseIcon(json['icon']),
      tips: List<String>.from(json['tips']),
      impact: json['impact'],
    );
  }

  // Custom method to convert string to IconData
  static IconData _parseIcon(String iconString) {
    switch (iconString) {
      case 'bolt':
        return Icons.bolt;
      case 'energy_savings_leaf':
        return Icons.energy_savings_leaf;
      case 'biotech':
        return Icons.biotech;
      default:
        return CupertinoIcons.heart; // Default fallback icon
    }
  }
}