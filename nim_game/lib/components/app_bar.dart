import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Nim game',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
