
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? phoneNumber;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.phoneNumber,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      phoneNumber: data['phoneNumber'],
      isActive: data['isActive'] ?? true,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'role': role,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? phoneNumber,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ClientModel {
  final String id;
  final String name;
  final String type; // e.g., 'internal', 'external'
  final String? contactPerson;
  final String? phoneNumber;
  final String? address;

  ClientModel({
    required this.id,
    required this.name,
    required this.type,
    this.contactPerson,
    this.phoneNumber,
    this.address,
  });

  factory ClientModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ClientModel(
      id: doc.id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      contactPerson: data['contactPerson'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'type': type,
      'contactPerson': contactPerson,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}

class AuditLogModel {
  final String id;
  final String userId;
  final String action;
  final DateTime timestamp;
  final Map<String, dynamic> details;

  AuditLogModel({
    required this.id,
    required this.userId,
    required this.action,
    required this.timestamp,
    required this.details,
  });

  factory AuditLogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AuditLogModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      action: data['action'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      details: data['details'] ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'action': action,
      'timestamp': Timestamp.fromDate(timestamp),
      'details': details,
    };
  }

  AuditLogModel copyWith({
    String? id, String? userId, String? action, DateTime? timestamp, Map<String, dynamic>? details}) {    return AuditLogModel(id: id ?? this.id, userId: userId ?? this.userId, action: action ?? this.action, timestamp: timestamp ?? this.timestamp, details: details ?? this.details,);
  }
}
