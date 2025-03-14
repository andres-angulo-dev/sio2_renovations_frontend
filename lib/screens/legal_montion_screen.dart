import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/drawer_component.dart';

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
      body: Text('MY GOD'),
    );
  }
}
