import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_material_model.freezed.dart';
part 'raw_material_model.g.dart';

class RawMaterialModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  final String name;
  final String category;
  final String unit;
  final double currentStock;
  final double reorderLevel;
  final String? supplierId;
  final String? supplierName;

  RawMaterialModel({
    this.id,
    required this.name,
    required this.category,
    required this.unit,
    this.currentStock = 0.0, // Default value
    this.reorderLevel = 0.0, // Default value
    this.supplierId,
    this.supplierName,
  });
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'unit': unit,
      'currentStock': currentStock,
      'reorderLevel': reorderLevel,
      'unitCost': unitCost,
      'supplierId': supplierId, // Include supplierId
    };
  }

  bool get isLowStock => currentStock <= reorderLevel;

  factory RawMaterialModel.fromJson(Map<String, dynamic> json) {
    return RawMaterialModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      unit: json['unit'],
      currentStock: json['currentStock'].toDouble(),
      reorderLevel: json['reorderLevel'].toDouble(),
      supplierId: json['supplierId'],
      supplierName: json['supplierName'],
    );
  }

  Map<String, dynamic> toJson() {
    return _$RawMaterialModelToJson(this);
  }
}

@freezed
class BillOfMaterialsModel with _$BillOfMaterialsModel {
  const factory BillOfMaterialsModel({
    required String id,
    required String productId,
    required String productName,
    required List<BoMItem> items,
    @Default(0) int version, // Added version for potential updates
    required DateTime createdAt, // Consider making this nullable or auto-generated
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
      // Handle potential null or different type for createdAt
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
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
    required String unit, // e.g., 'kg', 'grams', 'liters'
  }) = _BoMItem;

  factory BoMItem.fromJson(Map<String, dynamic> json) =>
      _$BoMItemFromJson(json);
}
