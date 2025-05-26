import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class MyHoverRouteNavigator extends StatefulWidget{
  const MyHoverRouteNavigator({super.key,
  this.routeName,
  required this.text,
  this.arguments,
  this.mobile = false,
  this.hoverColor,
  this.color,
  this.mobileSize,
  this.webSize,
  this.boldText = false,
  });

  final String? routeName;
  final String text;
  final Object? arguments;
  final bool mobile;
  final Color? hoverColor;
  final Color? color;
  final double? mobileSize;
  final double? webSize;
  final bool boldText;

  @override   
  MyHoverRouteNavigatorState createState() => MyHoverRouteNavigatorState();
}

class MyHoverRouteNavigatorState extends State<MyHoverRouteNavigator>  with SingleTickerProviderStateMixin {
  bool _hovering = false;

  @override  
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() {
        _hovering = true;
      }),
      onExit: (_) => setState(() {
        _hovering = false;
      }),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, widget.routeName!, arguments: widget.arguments),
        child: Text(
          widget.text,
          style: TextStyle(
            color: _hovering ? (widget.hoverColor ?? GlobalColors.hoverHyperLinkColor) : (widget.color ?? GlobalColors.hyperLinkColor),
            fontSize: widget.mobile ? (widget.mobileSize ?? GlobalSize.mobileSizeText) : (widget.webSize ?? GlobalSize.mobileSizeText),
            fontWeight: widget.boldText ? FontWeight.bold : null,
          )
        )
      ),
    );
  }
}