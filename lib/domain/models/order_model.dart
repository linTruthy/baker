// pubspec.yaml dependencies

import 'package:cloud_firestore/cloud_firestore.dart';

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
