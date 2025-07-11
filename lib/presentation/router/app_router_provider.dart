
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/presentation/providers/auth_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isOnLoginPage = state.fullPath == '/login';

      if (!isAuthenticated && !isOnLoginPage) {
        return '/login';
      }

      if (isAuthenticated && isOnLoginPage) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/', redirect: (context, state) => '/dashboard'),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/production',
        builder: (context, state) => const ProductionScreen(),
      ),
      GoRoute(
        path: '/dispatch',
        builder: (context, state) => const DispatchScreen(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsScreen(),
      ),
    ],
  );
});
