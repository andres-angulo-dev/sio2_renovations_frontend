import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> {
  final bool mobile = false;
  String currentItem = 'Projets';

  void updateCurrentItem(String newItem) {
    setState(() {
      currentItem = newItem;
    });
  }


  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBarComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ),
      endDrawer: mobile ? 
      DrawerComponent(
        currentItem: currentItem,
        onItemSelected: updateCurrentItem,
      ) 
      : null,
      backgroundColor: GlobalColors.firstColor,
      body: Text('IMPOSIBLE'),
    );
  }
}