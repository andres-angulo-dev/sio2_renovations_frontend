import 'package:flutter/material.dart';
import '../components/nav_items.dart';
import '../utils/global_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  final bool mobile = false;

  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return AppBar(
      toolbarHeight: mobile ? 250 : 300,
      leadingWidth: mobile ? 150 : 200,
      leading: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/landing'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),  
            child: Image.asset(
              'assets/Black.png',
              fit: BoxFit.contain,
            ),
          ) 
        ),
      ),
      actions: mobile ? null : const [NavItems(defaultColor: Colors.black, hoverColor: GlobalColors.navItemsHover, isHorizontal: true)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}