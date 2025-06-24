import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key,});

  @override  
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  final bool mobile = false;
  String currentItem = 'Contact';
  // bool _isDesktopMenuOpen = false; // Check if the child (MyAppBarComment) has the dropdown menu or not (only for NavItem with click)


  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {

    final mobile = GlobalScreenSizes.isMobileScreen(context);

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
        // onDesktopMenuOpenChanged: (bool isOpen) {setState(() => _isDesktopMenuOpen = isOpen);}, // receive whether the dropdown menu is open or not and update the variable // (only for NavItem with click)
      ),
      endDrawer: mobile // && !_isDesktopMenuOpen (only for NavItem with click)
        ? DrawerComponent(
          currentItem: currentItem,
          onItemSelected: updateCurrentItem,
        ) 
        : null,
      backgroundColor: GlobalColors.firstColor,
      body: Text('NOOOO!'),
    );
  }
}