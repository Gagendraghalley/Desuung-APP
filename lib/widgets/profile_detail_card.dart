import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetailCard extends StatelessWidget {
  final bool isEditing;
  final XFile? profileImage;
  final VoidCallback pickImage;

  const ProfileDetailCard({
    super.key,
    required this.isEditing,
    this.profileImage,
    required this.pickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: profileImage != null
              ? FileImage(File(profileImage!.path))
              : null,
          child: profileImage == null ? const Icon(Icons.person, size: 60) : null,
        ),
        if (isEditing)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
            child: FloatingActionButton(
              mini: true,
              onPressed: pickImage,
              child: const Icon(Icons.edit),
            ),
          ),
      ],
    );
  }
}
// TODO Implement this library.