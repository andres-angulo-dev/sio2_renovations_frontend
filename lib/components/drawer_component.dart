import 'package:flutter/material.dart';
import 'drawer_items.dart';
import '../utils/global_colors.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: const[drawerItems(defaultColor: Colors.black, hoverColor: GlobalColors.navItemsHover, isHorizontal: false)],
      ),
    );
  }
}