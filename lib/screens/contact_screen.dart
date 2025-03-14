import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/nav_items.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final bool mobile = false;

  @override
  Widget build(BuildContext context) {

    final mobile = MediaQuery.of(context).size.width > 768 ? false : true;

    return Scaffold(
      appBar: MyAppBar(),
      drawer: mobile ?
        Drawer(
          child: ListView(
            children: const [NavItems(color: Colors.black, isHorizontal: false)],
        )
        )
        :
        null,
      body: Text('NOOOO!'),
    );
  }
}