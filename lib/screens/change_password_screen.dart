import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  bool _passwordsMatch = true;

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
       _formKey.currentState!.save();
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmNewPasswordController.clear();
    setState(() {
      _passwordsMatch = true;
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
                TextField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    labelText: 'Old Password',
                    hintText: 'Enter your old password',
                    fillColor: Colors.white70,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              TextField(
                controller: _newPasswordController,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              TextField(
                controller: _confirmNewPasswordController,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    setState(() {
                      _passwordsMatch = false;
                    });
                    return 'Passwords do not match';
                  } else {
                    setState(() {
                      _passwordsMatch = true;
                    });
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              if (!_passwordsMatch)
                const Text(
                  'Passwords do not match',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: (_currentPasswordController.text.isEmpty ||
                        _newPasswordController.text.isEmpty ||
                        _confirmNewPasswordController.text.isEmpty || !_passwordsMatch)
                    ? null
                    : _changePassword,
                child: const Text('Save Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: _clearForm,
                  child: const Text('Clear form')
              )
            ],
          ),
        ),
      ),
    );
  }
}