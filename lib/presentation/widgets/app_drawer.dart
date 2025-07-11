import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../providers/auth_provider.dart';


class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;

    if (user == null) {
      return const Drawer(child: Center(child: CircularProgressIndicator()));
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getRoleDisplayName(user.role),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _getMenuItems(context, user.role),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              ref.read(authProvider.notifier).signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _getMenuItems(BuildContext context, String role) {
    final commonItems = [
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {
          Navigator.pop(context);
          context.go('/dashboard');
        },
      ),
      ListTile(
        leading: const Icon(Icons.shopping_cart),
        title: const Text('Orders'),
        onTap: () {
          Navigator.pop(context);
          context.go('/orders');
        },
      ),
      ListTile(
        leading: const Icon(Icons.analytics),
        title: const Text('Reports'),
        onTap: () {
          Navigator.pop(context);
          context.go('/reports');
        },
      ),
    ];

    final roleSpecificItems = <Widget>[];

    if (role == AppConstants.roleManager ||
        role == AppConstants.roleStorekeeper) {
      roleSpecificItems.add(
        ListTile(
          leading: const Icon(Icons.inventory),
          title: const Text('Inventory'),
          onTap: () {
            Navigator.pop(context);
            context.go('/inventory');
          },
        ),
      );
    }

    if (role == AppConstants.roleManager ||
        role == AppConstants.roleProductionSupervisor) {
      roleSpecificItems.add(
        ListTile(
          leading: const Icon(Icons.precision_manufacturing),
          title: const Text('Production'),
          onTap: () {
            Navigator.pop(context);
            context.go('/production');
          },
        ),
      );
    }

    if (role == AppConstants.roleManager ||
        role == AppConstants.roleDispatchOfficer) {
      roleSpecificItems.add(
        ListTile(
          leading: const Icon(Icons.local_shipping),
          title: const Text('Dispatch'),
          onTap: () {
            Navigator.pop(context);
            context.go('/dispatch');
          },
        ),
      );
    }

    return [
      ...commonItems,
      if (roleSpecificItems.isNotEmpty) const Divider(),
      ...roleSpecificItems,
    ];
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case AppConstants.roleManager:
        return 'Manager';
      case AppConstants.roleProductionSupervisor:
        return 'Production Supervisor';
      case AppConstants.roleStorekeeper:
        return 'Storekeeper';
      case AppConstants.roleDispatchOfficer:
        return 'Dispatch Officer';
      case AppConstants.roleSalesAdminClerk:
        return 'Sales/Admin Clerk';
      default:
        return 'Staff';
    }
  }
}
