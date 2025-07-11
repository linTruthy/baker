// pubspec.yaml dependencies

import 'package:cloud_firestore/cloud_firestore.dart';

class RawMaterialModel {
  final String id;
  final String name;
  final String category;
  final String unit;
  final double currentStock;
  final double reorderLevel;
  final double unitCost;
  final String? supplierId;
  final DateTime createdAt;
  final DateTime updatedAt;

  RawMaterialModel({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.currentStock,
    required this.reorderLevel,
    required this.unitCost,
    this.supplierId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RawMaterialModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RawMaterialModel(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      unit: data['unit'] ?? '',
      currentStock: (data['currentStock'] ?? 0.0).toDouble(),
      reorderLevel: (data['reorderLevel'] ?? 0.0).toDouble(),
      unitCost: (data['unitCost'] ?? 0.0).toDouble(),
      supplierId: data['supplierId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'unit': unit,
      'currentStock': currentStock,
      'reorderLevel': reorderLevel,
      'unitCost': unitCost,
      'supplierId': supplierId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  bool get isLowStock => currentStock <= reorderLevel;
}
