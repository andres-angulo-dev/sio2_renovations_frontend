import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  final bool moibile = false;
  String currentItem = 'À propos de nous';

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
      body: Text('Mais si !'),
    );
  }
}