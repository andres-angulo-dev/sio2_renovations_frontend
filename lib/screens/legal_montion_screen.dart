import 'package:flutter/material.dart';
import '../components/my_app_bar_component.dart';
import '../components/drawer_component.dart';
import '../utils/global_colors.dart';

class LegalMontionScreen extends StatelessWidget {
  const LegalMontionScreen({super.key});

  final bool mobile = false;

  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: mobile ?
        DrawerComponent()
        :
        null,
      backgroundColor: GlobalColors.primaryColor,
      body: Text('MY GOD'),
    );
  }
}
