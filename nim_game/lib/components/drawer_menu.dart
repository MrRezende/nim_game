import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Aluno: Caio Rezende de Oliveira",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "RA: 1431432312024",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
