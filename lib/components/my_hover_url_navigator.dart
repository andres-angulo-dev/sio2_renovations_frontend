import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class MyHoverUrlNavigator extends StatefulWidget{
  const MyHoverUrlNavigator({super.key,
  required this.url,
  required this.text,
  this.arguments,
  this.mobile = false,
  this.hoverColor,
  this.color,
  this.mobileSize, 
  this.webSize
  });

  final String url;
  final String text;
  final Object? arguments;
  final bool mobile;
  final Color? hoverColor;
  final Color? color;
  final double? mobileSize;
  final double? webSize;


  @override   
  MyHoverUrlNavigatorState createState() => MyHoverUrlNavigatorState();
}

class MyHoverUrlNavigatorState extends State<MyHoverUrlNavigator>  with SingleTickerProviderStateMixin {
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
        onTap: () async {
          try {
            await launchUrl(Uri.parse(widget.url));
          } catch (error) {
            throw "Could not launch $widget.url, error: $error";
          }
        },
        child: Text(
          widget.text,
          style: TextStyle(
            color: _hovering ? (widget.hoverColor ?? GlobalColors.hoverHyperLinkColor) : (widget.color ?? GlobalColors.hyperLinkColor),
            fontSize: widget.mobile ? (widget.mobileSize ?? GlobalSize.mobileSizeText) : (widget.webSize ?? GlobalSize.webSizeText),
          )
        )
      ),
    );
  }
}