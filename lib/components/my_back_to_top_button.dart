import 'package:flutter/material.dart';
import '../utils/global_colors.dart';

class MyBackToTopButton extends StatelessWidget {
  const MyBackToTopButton({
    super.key,
    required this.controller,
    this.backgroundColor = GlobalColors.orangeColor,
  });
  
  final ScrollController controller;  
  final Color backgroundColor; 

  // Go to the top of the page
  void _scrollToTop() {
    controller.animateTo(
      0.0, 
      duration: const Duration(milliseconds: 1000), 
      curve: Curves.easeOut,
    );
  }

  @override   
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0.0,
      hoverElevation: 0.0,
      onPressed: _scrollToTop,
      backgroundColor: backgroundColor,
      child: const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white, size: 40.0,),
    );
  }
} 