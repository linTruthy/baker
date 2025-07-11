import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_material_model.freezed.dart';
part 'raw_material_model.g.dart';

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
  final String? supplierName;

  RawMaterialModel({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    this.currentStock = 0.0,
    this.reorderLevel = 0.0,
    required this.unitCost,
    this.supplierId,
    required this.createdAt, // Consider making this nullable or auto-generated
    required this.updatedAt, // Consider making this nullable or auto-generated
    this.supplierName,
  });

  // Method to convert the model to a Firestore document
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

  Map<Object, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'unit': unit,
      'currentStock': currentStock,
      'reorderLevel': reorderLevel,
      'unitCost': unitCost,
      'supplierId': supplierId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'supplierName': supplierName,
    };
  }

  static fromMap(Map<String, dynamic> data, String id) {
    return RawMaterialModel(
      id: id,
      name: data['name'],
      category: data['category'],
      unit: data['unit'],
      currentStock: data['currentStock'],
      reorderLevel: data['reorderLevel'],
      unitCost: data['unitCost'],
      supplierId: data['supplierId'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      supplierName: data['supplierName'],
    );
  }
}

@freezed
class BillOfMaterialsModel with _$BillOfMaterialsModel {
  const factory BillOfMaterialsModel({
    required String id,
    required String productId,
    required String productName,
    required List<BoMItem> items,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BillOfMaterialsModel;

  factory BillOfMaterialsModel.fromJson(Map<String, dynamic> json) =>
      _$BillOfMaterialsModelFromJson(json);

  factory BillOfMaterialsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BillOfMaterialsModel(
      id: doc.id,
      productId: data['productId'] as String,
      productName: data['productName'] as String,
      items: (data['items'] as List<dynamic>)
          .map((item) => BoMItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }
}

@freezed
class BoMItem with _$BoMItem {
  const factory BoMItem({
    required String rawMaterialId,
    required String rawMaterialName,
    required double quantity,
    required String unit,
  }) = _BoMItem;

  factory BoMItem.fromJson(Map<String, dynamic> json) =>
      _$BoMItemFromJson(json);
}
