import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MyButtonRive extends StatefulWidget {
  const MyButtonRive({super.key, 
  required this.onPressed, 
  required this.buttonPath,

  });

  final VoidCallback onPressed;
  final String buttonPath;
  // final String? buttonLabel;

  @override  
  MyButtonRiveState createState() => MyButtonRiveState(); 
}

class MyButtonRiveState extends State<MyButtonRive> {
  double _scale = 1.0;

  @override   
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _scale = 1.05;
        });
      },
      onExit: (_) {
        setState(() {
          _scale = 1.0;
        });
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_scale),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 150,
                child: RiveAnimation.asset(
                  widget.buttonPath,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}