// Slide to the right on hover
import 'package:flutter/material.dart';

class MyHoverSlideLinkWidget extends StatefulWidget {
  final Widget child;
  final bool cursorClick;

  const MyHoverSlideLinkWidget({
    super.key,
    required this.child,
    this.cursorClick = false, 
  });

  @override
  MyHoverSlideLinkWidgetState createState() => MyHoverSlideLinkWidgetState();
}

class MyHoverSlideLinkWidgetState extends State<MyHoverSlideLinkWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.05, 0),
    ).animate(CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOut
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      cursor:  widget.cursorClick ? SystemMouseCursors.click : MouseCursor.defer,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}
