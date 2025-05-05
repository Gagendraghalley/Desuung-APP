import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/config/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        IconButton(
          icon: Icon(
           Icons.notifications,
           color: Theme.of(context).colorScheme.background,
          
          ),
          onPressed: () {
            print("Notification button pressed");
          },
        ),
        IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.account_circle_rounded,
              color: Colors.blueGrey,
              size: 28,
            ),
          ),
          padding: const EdgeInsets.only(right: 10),
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