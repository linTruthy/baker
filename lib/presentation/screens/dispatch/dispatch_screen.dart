import 'package:flutter/material.dart';

class DispatchScreen extends StatelessWidget {
  const DispatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Removed unused variable.
    // Example list of dispatches
    final dispatches = [
      {'id': '1', 'orderId': 'ORD001', 'status': 'Dispatched'},
      {'id': '2', 'orderId': 'ORD002', 'status': 'Delivered'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dispatch Management')),
      body: ListView.builder(
        itemCount: dispatches.length,
        itemBuilder: (context, index) {
          final dispatch = dispatches[index];
          return ListTile(
            title: Text('Dispatch ID: ${dispatch['id']}'),
            subtitle: Text(
              'Order ID: ${dispatch['orderId']} - Status: ${dispatch['status']}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // TODO: Navigate to dispatch details screen and signature capture
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('View/Edit Dispatch ${dispatch['id']}'),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement logic to create a new dispatch
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Create New Dispatch')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Placeholder for signature capture functionality (to be implemented later)
// class SignatureCaptureWidget extends StatelessWidget {...}
