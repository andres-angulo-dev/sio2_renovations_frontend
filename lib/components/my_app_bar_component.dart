import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'drawer_items.dart';
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
      backgroundColor: GlobalColors.primaryColor,
      leading: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/landing'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),  
            child: SvgPicture.asset(
              'assets/black.svg',
              semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
              fit: BoxFit.contain,
            ),
          ) 
        ),
      ),
      actions: mobile ? null : const [DrawerItems(defaultColor: Colors.black, hoverColor: GlobalColors.orangeColor, isHorizontal: true)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}