// pubspec.yaml dependencies

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class OrderModel {
  final String id;
  final String clientId;
  final String clientName;
  final String clientType; // 'internal' or 'external'
  final String status;
  final DateTime orderDate;
  final DateTime? requiredDate;
  final double totalAmount;
  final String createdBy;
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientType,
    required this.status,
    required this.orderDate,
    this.requiredDate,
    required this.totalAmount,
    required this.createdBy,
    this.approvedBy,
    this.approvedAt,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      clientId: data['clientId'] ?? '',
      clientName: data['clientName'] ?? '',
      clientType: data['clientType'] ?? 'external',
      status: data['status'] ?? 'requested',
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      requiredDate: data['requiredDate'] != null 
          ? (data['requiredDate'] as Timestamp).toDate() 
          : null,
      totalAmount: (data['totalAmount'] ?? 0.0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      approvedBy: data['approvedBy'],
      approvedAt: data['approvedAt'] != null 
          ? (data['approvedAt'] as Timestamp).toDate() 
          : null,
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'clientId': clientId,
      'clientName': clientName,
      'clientType': clientType,
      'status': status,
      'orderDate': Timestamp.fromDate(orderDate),
      'requiredDate': requiredDate != null ? Timestamp.fromDate(requiredDate!) : null,
      'totalAmount': totalAmount,
      'createdBy': createdBy,
      'approvedBy': approvedBy,
      'approvedAt': approvedAt != null ? Timestamp.fromDate(approvedAt!) : null,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

@JsonSerializable()
class DispatchModel {
  final String id;
  final String orderId;
  final String recipientName;
  final DateTime deliveryDate;
  final String status; // e.g., 'prepared', 'dispatched', 'delivered'
  final String? signatureImageUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  DispatchModel({
    required this.id,
    required this.orderId,
    required this.recipientName,
    required this.deliveryDate,
    required this.status,
    this.signatureImageUrl,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DispatchModel.fromJson(Map<String, dynamic> json) => _$DispatchModelFromJson(json);
  Map<String, dynamic> toJson() => _$DispatchModelToJson(this);

  factory DispatchModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DispatchModel(
      id: doc.id,
      orderId: data['orderId'] ?? '',
      recipientName: data['recipientName'] ?? '',
      deliveryDate: (data['deliveryDate'] as Timestamp).toDate(),
      status: data['status'] ?? 'prepared',
      signatureImageUrl: data['signatureImageUrl'],
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'recipientName': recipientName,
      'deliveryDate': Timestamp.fromDate(deliveryDate),
      'status': status,
      'signatureImageUrl': signatureImageUrl,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
