import 'package:desuungapp/screens/footer.dart';
import 'package:flutter/material.dart';
import './login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo and title
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 100,
                          filterQuality: FilterQuality.high,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'De-Suung Login',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Login Form
                    const LoginForm(),
                    
                    const SizedBox(height: 40),
                    
                    // Copyright
                    const CopyrightText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}