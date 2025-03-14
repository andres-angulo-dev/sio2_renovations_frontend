import 'package:flutter/material.dart';
import '../components/nav_items.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  final bool mobile = false;

  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return AppBar(
      toolbarHeight: mobile ? null : 300,
      leadingWidth: mobile ? null : 200,
      leading: mobile ?
        null
        :
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/landing'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),  
            child: Image.asset(
              'assets/Black.png',
              fit: BoxFit.contain,
            ),
          ) 
        ),
      actions: mobile ? null : const [NavItems(color: Colors.black, isHorizontal: true)],
    );
  }

  @override
  Size get preferredSize => mobile ? const Size.fromHeight(kToolbarHeight) : const Size.fromHeight(100.0);
}