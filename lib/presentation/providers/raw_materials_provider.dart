import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/raw_material_model.dart';

final rawMaterialProvider = StateNotifierProvider<RawMaterialNotifier, AsyncValue<List<RawMaterialModel>>>((ref) {
  return RawMaterialNotifier();
});

class RawMaterialNotifier extends StateNotifier<AsyncValue<List<RawMaterialModel>>> {
  RawMaterialNotifier() : super(const AsyncValue.loading()) {
    _fetchRawMaterials();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _fetchRawMaterials() async {
    try {
      final snapshot = await _firestore.collection('rawMaterials').get();
      final rawMaterials = snapshot.docs.map((doc) => RawMaterialModel.fromMap(doc.data(), doc.id)).toList();
      state = AsyncValue.data(rawMaterials);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addRawMaterial(RawMaterialModel rawMaterial) async {
    try {
      final docRef = await _firestore.collection('rawMaterials').add(rawMaterial.toMap());
      final newRawMaterial = rawMaterial.copyWith(id: docRef.id);
      state.whenData((rawMaterials) {
        state = AsyncValue.data([...rawMaterials, newRawMaterial]);
      });
    } catch (e, st) {
      // Handle error appropriately, maybe show a snackbar
      if (kDebugMode) {
        print('Error adding raw material: $e');
      }
    }
  }

  Future<void> updateRawMaterial(RawMaterialModel rawMaterial) async {
    try {
      await _firestore.collection('rawMaterials').doc(rawMaterial.id).update(rawMaterial.toMap());
      state.whenData((rawMaterials) {
        state = AsyncValue.data([
          for (final rm in rawMaterials)
            if (rm.id == rawMaterial.id) rawMaterial else rm,
        ]);
      });
    } catch (e, st) {
      // Handle error appropriately
      if (kDebugMode) {
        print('Error updating raw material: $e');
      }
    }
  }

  Future<void> deleteRawMaterial(String id) async {
    try {
      await _firestore.collection('rawMaterials').doc(id).delete();
      state.whenData((rawMaterials) {
        state = AsyncValue.data([
          for (final rm in rawMaterials)
            if (rm.id != id) rm,
        ]);
      });
    } catch (e, st) {
      // Handle error appropriately
      if (kDebugMode) {
        print('Error deleting raw material: $e');
      }
    }
  }
}