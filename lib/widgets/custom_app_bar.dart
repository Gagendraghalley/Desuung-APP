import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title, List<Widget>? actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.account_circle_rounded,
              color: Colors.blueGrey,
              size: 28,
            ),
          ),
          padding: const EdgeInsets.only(right: 20),
            onPressed: () {
            print("profile icon pressed");
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}