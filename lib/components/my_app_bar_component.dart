import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'drawer_items.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key,
  required this.currentItem,
  required this.onItemSelected,
  });

  final bool mobile = false;
  final String currentItem;  // The currently active menu item
  final Function(String) onItemSelected;  // Callback to notify the parent when a menu item is selected

  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return AppBar(
      toolbarHeight: mobile ? 250 : 300,
      leadingWidth: mobile ? 150 : 200,
      scrolledUnderElevation: 0.0, // Disables the effect of change caused by scrolling.
      backgroundColor: GlobalColors.primaryColor,
      leading: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/landing'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),  
            child: SvgPicture.asset(
              GlobalLogo.blackLogo,
              semanticsLabel: 'Circular orange logo with the text "SIO2 Rénovations" displayed to its right',
              fit: BoxFit.contain,
            ),
          ) 
        ),
      ),
      actions: mobile 
      ? null 
      : [ DrawerItems(
        defaultColor: Colors.black, 
        hoverColor: GlobalColors.orangeColor, 
        isHorizontal: true,
        currentItem: currentItem, // Pass the active item
        onItemSelected: onItemSelected, // Pass the callback
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}