import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key,});

  @override  
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  final bool mobile = false;
  String currentItem = 'Contact';

  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ),
      endDrawer: mobile 
        ? DrawerComponent(
          currentItem: currentItem,
          onItemSelected: updateCurrentItem,
        ) 
        : null,
      backgroundColor: GlobalColors.primaryColor,
      body: Text('NOOOO!'),
    );
  }
}