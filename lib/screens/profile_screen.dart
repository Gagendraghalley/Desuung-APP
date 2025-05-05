
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'change_password_screen.dart';
// ignore: library_private_types_in_public_api

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  XFile? _profileImage;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize with dummy data or fetch from storage
    _nameController.text = "John Doe";
    _emailController.text = "john.doe@example.com";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });      
    }
  }

  void _changePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
    );
  }



  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Save the profile information here
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      _toggleEdit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveProfile : _toggleEdit,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue.shade100, Colors.white],
          ),
        ),        
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: _formKey,
            child: _buildProfileContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _isEditing ? _pickImage : null,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: isLandscape ? 50 : 70,
                backgroundImage:
                    _profileImage != null ? NetworkImage(_profileImage!.path) as ImageProvider : null,
                child: _profileImage == null
                    ? Icon(Icons.person,
                        size: isLandscape ? 50 : 70, color: Colors.white)
                    : null,
              ),
              if (_isEditing)
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(Icons.camera_alt, color: Colors.blue),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _nameController,
          enabled: _isEditing,
          decoration: const InputDecoration(
            labelText: 'Name',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          enabled: _isEditing,
          decoration: const InputDecoration(
            labelText: 'Email',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),

        const SizedBox(height: 24), // Add spacing before the button
          ElevatedButton(
          onPressed: () => _changePassword(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button color
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Padding
            textStyle: const TextStyle(fontSize: 16), // Text style
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
          ),
          child: const Text('Change Password', style: TextStyle(color: Colors.white)), // Text color
        ),

      ],
    );
  }
}
