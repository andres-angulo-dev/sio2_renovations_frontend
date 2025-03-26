import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageIconButton extends StatefulWidget {
  const ImageIconButton({super.key, required this.onPressed, required this.imagePath, required this.iconPath});

  final VoidCallback onPressed;
  final String imagePath;
  final String iconPath;

  @override  
  ImageIconButtonState createState() => ImageIconButtonState(); 
}

class ImageIconButtonState extends State<ImageIconButton> {
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
                widget.imagePath,
                width: 60,
                height: 60,
                semanticsLabel: 'Handle cookies button',
              ),
              SvgPicture.asset(
                widget.iconPath,
                width: 40,
                height: 40,
                semanticsLabel: 'A cookie icon over the button',
              ),
            ],
          ),
        )
      ),
    );
  }
}