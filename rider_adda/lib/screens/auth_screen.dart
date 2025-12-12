import 'package:flutter/material.dart';
import 'package:rider_adda/utils/constants.dart';
import 'dart:ui';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  void _submit() {
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    if (!_isLogin) {
      print('Name: ${_nameController.text}');
    }
    print(_isLogin ? 'Logging in...' : 'Signing up...');
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Blur
          Image.network(
            'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=2070&auto=format&fit=crop', // Motorcycle image
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.black);
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isLogin ? 'Login' : 'Sign Up',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.accent,
                            ),
                      ),
                      const SizedBox(height: 20),
                      if (!_isLogin)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(labelText: 'Display Name'),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Start Your Engine',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin ? 'Create an account' : 'Already have an account? Login',
                          style: const TextStyle(color: AppColors.accent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
