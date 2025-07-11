import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../domain/models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/stats_card.dart';
import '../../../core/constants/app_constants.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: user == null 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                _buildWelcomeSection(context, user),
                const SizedBox(height: 24),
                
                // Stats Cards
                _buildStatsSection(context, user),
                const SizedBox(height: 24),
                
                // Quick Actions
                _buildQuickActions(context, user),
                const SizedBox(height: 24),
                
                // Recent Activity
                _buildRecentActivity(context),
              ],
            ),
          ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, UserModel user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, ${user.name}!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getRoleDisplayName(user.role),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Today is ${_formatDate(DateTime.now())}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    ).animate().slideY(delay: 200.ms);
  }

  Widget _buildStatsSection(BuildContext context, UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: _getStatsCards(user.role),
        ),
      ],
    ).animate().slideY(delay: 400.ms);
  }

  List<Widget> _getStatsCards(String role) {
    switch (role) {
      case AppConstants.roleManager:
        return [
          const StatsCard(
            title: 'Pending Orders',
            value: '12',
            icon: Icons.shopping_cart_outlined,
            color: Colors.orange,
          ),
          const StatsCard(
            title: 'Production Plans',
            value: '8',
            icon: Icons.assignment_outlined,
            color: Colors.blue,
          ),
          const StatsCard(
            title: 'Low Stock Items',
            value: '5',
            icon: Icons.warning_outlined,
            color: Colors.red,
          ),
          const StatsCard(
            title: 'Deliveries',
            value: '15',
            icon: Icons.local_shipping_outlined,
            color: Colors.green,
          ),
        ];
      case AppConstants.roleProductionSupervisor:
        return [
          const StatsCard(
            title: 'Today\'s Plans',
            value: '6',
            icon: Icons.calendar_today_outlined,
            color: Colors.blue,
          ),
          const StatsCard(
            title: 'Completed',
            value: '4',
            icon: Icons.check_circle_outlined,
            color: Colors.green,
          ),
          const StatsCard(
            title: 'In Progress',
            value: '2',
            icon: Icons.hourglass_empty_outlined,
            color: Colors.orange,
          ),
          const StatsCard(
            title: 'Efficiency',
            value: '92%',
            icon: Icons.trending_up_outlined,
            color: Colors.purple,
          ),
        ];
      case AppConstants.roleStorekeeper:
        return [
          const StatsCard(
            title: 'Total Items',
            value: '45',
            icon: Icons.inventory_outlined,
            color: Colors.blue,
          ),
          const StatsCard(
            title: 'Low Stock',
            value: '5',
            icon: Icons.warning_outlined,
            color: Colors.red,
          ),
          const StatsCard(
            title: 'Issued Today',
            value: '8',
            icon: Icons.output_outlined,
            color: Colors.green,
          ),
          const StatsCard(
            title: 'Received',
            value: '3',
            icon: Icons.input_outlined,
            color: Colors.orange,
          ),
        ];
      default:
        return [
          const StatsCard(
            title: 'Orders',
            value: '12',
            icon: Icons.shopping_cart_outlined,
            color: Colors.blue,
          ),
          const StatsCard(
            title: 'Tasks',
            value: '8',
            icon: Icons.task_outlined,
            color: Colors.green,
          ),
        ];
    }
  }

  Widget _buildQuickActions(BuildContext context, UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: _getQuickActions(context, user.role),
        ),
      ],
    ).animate().slideY(delay: 600.ms);
  }

  List<Widget> _getQuickActions(BuildContext context, String role) {
    final commonActions = [
      DashboardCard(
        title: 'View Orders',
        icon: Icons.shopping_cart_outlined,
        color: Colors.blue,
        onTap: () => Navigator.pushNamed(context, '/orders'),
      ),
      DashboardCard(
        title: 'Reports',
        icon: Icons.analytics_outlined,
        color: Colors.purple,
        onTap: () => Navigator.pushNamed(context, '/reports'),
      ),
    ];

    switch (role) {
      case AppConstants.roleManager:
        return [
          ...commonActions,
          DashboardCard(
            title: 'Inventory',
            icon: Icons.inventory_outlined,
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, '/inventory'),
          ),
          DashboardCard(
            title: 'Production',
            icon: Icons.precision_manufacturing_outlined,
            color: Colors.orange,
            onTap: () => Navigator.pushNamed(context, '/production'),
          ),
        ];
      case AppConstants.roleProductionSupervisor:
        return [
          DashboardCard(
            title: 'Production Plans',
            icon: Icons.assignment_outlined,
            color: Colors.blue,
            onTap: () => Navigator.pushNamed(context, '/production'),
          ),
          DashboardCard(
            title: 'Log Production',
            icon: Icons.add_circle_outlined,
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, '/production?tab=log'),
          ),
          ...commonActions,
        ];
      case AppConstants.roleStorekeeper:
        return [
          DashboardCard(
            title: 'Inventory',
            icon: Icons.inventory_outlined,
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, '/inventory'),
          ),
          DashboardCard(
            title: 'Add Stock',
            icon: Icons.add_box_outlined,
            color: Colors.blue,
            onTap: () => Navigator.pushNamed(context, '/inventory?action=add'),
          ),
          ...commonActions,
        ];
      case AppConstants.roleDispatchOfficer:
        return [
          DashboardCard(
            title: 'Dispatch',
            icon: Icons.local_shipping_outlined,
            color: Colors.orange,
            onTap: () => Navigator.pushNamed(context, '/dispatch'),
          ),
          DashboardCard(
            title: 'Deliveries',
            icon: Icons.assignment_turned_in_outlined,
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, '/dispatch?tab=deliveries'),
          ),
          ...commonActions,
        ];
      default:
        return commonActions;
    }
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              _buildActivityItem(
                'New order received from Supermarket',
                '2 hours ago',
                Icons.shopping_cart_outlined,
                Colors.blue,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Production completed: White Bread',
                '3 hours ago',
                Icons.check_circle_outlined,
                Colors.green,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Low stock alert: Wheat Flour',
                '4 hours ago',
                Icons.warning_outlined,
                Colors.orange,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Delivery completed to Client A',
                '5 hours ago',
                Icons.local_shipping_outlined,
                Colors.purple,
              ),
            ],
          ),
        ),
      ],
    ).animate().slideY(delay: 800.ms);
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      subtitle: Text(time),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: () {
        // TODO: Navigate to relevant screen
      },
    );
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

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
