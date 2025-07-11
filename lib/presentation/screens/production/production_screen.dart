import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/production_plan_model.dart';

// Import your provider for production plans
// import 'package:your_app_name/presentation/providers/production_provider.dart';

class ProductionScreen extends ConsumerWidget {
  const ProductionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace with your actual provider that fetches production plans
    // final productionPlansAsyncValue = ref.watch(productionPlansProvider);
    final productionPlansAsyncValue = AsyncValue.data(
      <ProductionPlanModel>[],
    ); // Placeholder

    return Scaffold(
      appBar: AppBar(
        title: const Text('Production Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Production Plan',
            onPressed: () {
              // TODO: Implement add new production plan functionality
            },
          ),
        ],
      ),
      body: productionPlansAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (productionPlans) {
          if (productionPlans.isEmpty) {
            return const Center(child: Text('No production plans found.'));
          }
          return ListView.builder(
            itemCount: productionPlans.length,
            itemBuilder: (context, index) {
              final plan = productionPlans[index];
              return ListTile(
                title: Text(
                  plan.productName,
                ), // Assuming ProductionPlan has productName
                subtitle: Text(
                  'Quantity: ${plan.actualQuantity} | Date: ${DateFormat('yyyy-MM-dd').format(plan.planDate)} | Status: ${plan.status}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.build),
                  tooltip: 'Log Production',
                  onPressed: () {
                    // TODO: Implement log production output functionality
                    // Pass the plan ID or relevant data to the logging screen/dialog
                  },
                ),
                onTap: () {
                  // TODO: Implement view production plan details functionality
                },
              );
            },
          );
        },
      ),
    );
  }
}
