import 'package:flutter/material.dart';
import 'drawer_items.dart';
import '../utils/global_colors.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: GlobalColors.primaryColor,
      child: ListView(
        padding: EdgeInsets.zero, // Removes default padding for the ListView.
        children: [
          DrawerItems(
            defaultColor: Colors.black, 
            hoverColor: GlobalColors.orangeColor, 
            isHorizontal: false
          )
        ],
      ),
    );
  }
}

