import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyButton extends StatefulWidget {
  const MyButton({super.key, 
  required this.onPressed, 
  required this.buttonPath,
  this.buttonLabel, 
  required this.foregroundPath,
  this.foregroundLabel,
  });

  final VoidCallback onPressed;
  final String buttonPath;
  final String? buttonLabel;
  final String foregroundPath;
  final String? foregroundLabel;


  @override  
  MyButtonState createState() => MyButtonState(); 
}

class MyButtonState extends State<MyButton> {
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
              SvgPicture.asset(
                widget.buttonPath,
                width: 60,
                height: 60,
                semanticsLabel: widget.buttonLabel,
              ),
              SvgPicture.asset(
                widget.foregroundPath,
                width: 40,
                height: 40,
                semanticsLabel: widget.foregroundLabel,
              ),
            ],
          ),
        )
      ),
    );
  }
}