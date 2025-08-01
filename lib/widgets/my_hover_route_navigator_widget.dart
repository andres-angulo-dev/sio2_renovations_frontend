import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class MyHoverRouteNavigatorWidget extends StatefulWidget{
  final String? routeName;
  final String text;
  final Object? arguments;
  final bool mobile;
  final bool italic;
  final Color? hoverColor;
  final Color? color;
  final double? mobileSize;
  final double? webSize;
  final bool boldText;
  final bool textAlign;
  
  const MyHoverRouteNavigatorWidget({
    super.key,
    this.routeName,
    required this.text,
    this.arguments,
    this.mobile = false,
    this.italic = false,
    this.hoverColor,
    this.color,
    this.mobileSize,
    this.webSize,
    this.boldText = false,
    this.textAlign = false,
  });

  @override   
  MyHoverRouteNavigatorWidgetState createState() => MyHoverRouteNavigatorWidgetState();
}

class MyHoverRouteNavigatorWidgetState extends State<MyHoverRouteNavigatorWidget>  with SingleTickerProviderStateMixin {
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
            fontSize: widget.mobile ? (widget.mobileSize ?? GlobalSize.mobileSizeText) : (widget.webSize ?? GlobalSize.webSizeText),
            fontWeight: widget.boldText ? FontWeight.bold : null,
            fontStyle: widget.italic ? FontStyle.italic : null,
          ),
          textAlign: widget.textAlign ? TextAlign.center : null,
        )
      ),
    );
  }
}