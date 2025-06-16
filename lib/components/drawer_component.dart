import 'package:flutter/material.dart';
import 'nav_items.dart';
import '../utils/global_colors.dart';

class DrawerComponent extends StatefulWidget{
  const DrawerComponent({super.key,
  required this.currentItem,
  required this.onItemSelected,
  this.currentSubItem,
  });

  final String currentItem;   // The currently active menu item
  final Function(String) onItemSelected; // Callback to notify the parent when a menu item is selected
  final String? currentSubItem;   // The currently active menu item

  @override  
  DrawerComponentState createState() => DrawerComponentState();
}

class DrawerComponentState extends State<DrawerComponent> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: GlobalColors.firstColor,
      child: ListView(
        padding: EdgeInsets.zero, // Removes default padding for the ListView.
        children: [
          NavItems(
            defaultColor: Colors.black, 
            hoverColor: GlobalColors.orangeColor, 
            isHorizontal: false, // Display menu items vertically
            currentItem: widget.currentItem, // Pass the active item
            onItemSelected: widget.onItemSelected, // Pass the callback
            currentSubItem: widget.currentSubItem, // Pass the active item
          )
        ],
      ),
    );
  }
}



