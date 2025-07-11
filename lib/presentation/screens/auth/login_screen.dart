// pubspec.yaml dependencies

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/widgets/custom_text_field.dart';
import 'package:myapp/presentation/widgets/loading_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    try {
      await ref.read(authProvider.notifier).signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo and Title
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.bakery_dining,
                          size: 40,
                          color: Colors.white,
                        ),
                      ).animate().scale(delay: 200.ms),
                      
                      const SizedBox(height: 24),
                      
                      Text(
                        'Chello Bakery',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ).animate().slideY(delay: 400.ms),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Management System',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ).animate().slideY(delay: 600.ms),
                      
                      const SizedBox(height: 32),
                      
                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ).animate().slideX(delay: 800.ms),
                      
                      const SizedBox(height: 16),
                      
                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: _obscurePassword,
                        prefixIcon: Icons.lock_outlined,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ).animate().slideX(delay: 1000.ms),
                      
                      const SizedBox(height: 32),
                      
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: LoadingButton(
                          onPressed: _signIn,
                          isLoading: _isLoading,
                          child: const Text('Sign In'),
                        ),
                      ).animate().slideY(delay: 1200.ms),
                      
                      const SizedBox(height: 16),
                      
                      // Demo credentials info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Demo Credentials',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Manager: manager@chello.com / password123\n'
                              'Supervisor: supervisor@chello.com / password123\n'
                              'Storekeeper: store@chello.com / password123',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.blue.shade700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 1400.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}