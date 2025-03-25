import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageIconButton extends StatelessWidget {
  const ImageIconButton({super.key, required this.onPressed, required this.imagePath, required this.icon});

  final VoidCallback onPressed;
  final String imagePath;
  final IconData icon;

  @override   
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          FaIcon(
            icon,
            color: Colors.white,
            size: 24.0,
          )
        ],
      ),
    );
  }
}