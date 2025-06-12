import 'package:desuungapp/screens/announcement/announcement_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title, List<Widget>? actions,
  });

  @override
  /// Builds a custom app bar.
  ///
  /// The app bar is titled with [title] and has a white background.
  /// There is a single action that navigates to the AnnouncementScreen when pressed.
  /// The action is a blueGrey person icon in a white circle avatar.
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title, 
        style: TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.bold, 
          color: const Color.fromARGB(255, 230, 134, 44), 
        ),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 238, 236, 233),
      actions: [
        IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.white, // Change CircleAvatar background to white
            child: Icon( 
              Icons.person, 
              color: Colors.blueGrey,
              size: 28,
            ),
          ),
          padding: const EdgeInsets.only(right: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnnouncementScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
