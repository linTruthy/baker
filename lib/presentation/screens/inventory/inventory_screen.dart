import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/raw_material_model.dart';
import '../../providers/raw_materials_provider.dart';
// Assuming this path based on your file structure

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace with your actual provider for fetching raw materials
    final AsyncValue<List<RawMaterialModel>> rawMaterialsAsyncValue = ref.watch(
      rawMaterialProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: rawMaterialsAsyncValue.when(
        data: (rawMaterials) {
          return ListView.builder(
            itemCount: rawMaterials.length,
            itemBuilder: (context, index) {
              final material = rawMaterials[index];
              return ListTile(
                title: Text(material.name),
                subtitle: Text(
                  'Stock: ${material.currentStock} | Reorder Threshold: ${material.reorderLevel}',
                ),
                onTap: () {
                  // TODO: Navigate to material details screen
                  if (kDebugMode) {
                    print('Tapped on ${material.name}');
                  }
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement 'Add Material' functionality (e.g., show a dialog or navigate to a new screen)
          if (kDebugMode) {
            print('Add Material button pressed');
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
