import 'package:flutter/material.dart';
import '../components/nav_items.dart';
import '../utils/global_colors.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const[NavItems(defaultColor: Colors.black, hoverColor: GlobalColors.navItemsHover, isHorizontal: false)],
      ),
    );
  }
}