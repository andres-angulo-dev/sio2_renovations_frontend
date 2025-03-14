import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/drawer_component.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  final bool moibile = false;
  
  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: mobile ? 
        DrawerComponent()
        :
        null,
      body: Text('Mais si'),
    );
  }
}