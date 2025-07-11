// pubspec.yaml dependencies

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductionPlanModel {
  final String id;
  final String productId;
  final String productName;
  final DateTime planDate;
  final String shift; // 'morning', 'afternoon', 'night'
  final double plannedQuantity;
  final double? actualQuantity;
  final String status;
  final String createdBy;
  final Map<String, double> rawMaterialRequirements;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductionPlanModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.planDate,
    required this.shift,
    required this.plannedQuantity,
    this.actualQuantity,
    required this.status,
    required this.createdBy,
    required this.rawMaterialRequirements,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductionPlanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductionPlanModel(
      id: doc.id,
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      planDate: (data['planDate'] as Timestamp).toDate(),
      shift: data['shift'] ?? 'morning',
      plannedQuantity: (data['plannedQuantity'] ?? 0.0).toDouble(),
      actualQuantity: data['actualQuantity']?.toDouble(),
      status: data['status'] ?? 'planned',
      createdBy: data['createdBy'] ?? '',
      rawMaterialRequirements: Map<String, double>.from(
        data['rawMaterialRequirements'] ?? {}
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productId': productId,
      'productName': productName,
      'planDate': Timestamp.fromDate(planDate),
      'shift': shift,
      'plannedQuantity': plannedQuantity,
      'actualQuantity': actualQuantity,
      'status': status,
      'createdBy': createdBy,
      'rawMaterialRequirements': rawMaterialRequirements,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
