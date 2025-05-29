import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class BeforeAfterSection extends StatelessWidget {
  const BeforeAfterSection({super.key});

  @override 
  Widget build(BuildContext context) {
    final bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return Wrap(
      alignment: WrapAlignment.spaceBetween, 
      children: [
        _builRightContent(context, isMobile, "APRÈS"),
        _buildLeftContent(context, isMobile, "AVANT"),
      ],
    );
  }

  Widget _builRightContent(BuildContext context, bool isMobile, String title) {
    return SizedBox(
      width: 1000.0,
      height: 600.0,
      child: Stack(
        children: [
          _buildBackgroundImage(context),
          _buildTitle(title, isMobile, left: true),
          _buildSquares(leftAligned: true),
        ],
      ),
    );
  }

  Widget _buildLeftContent(BuildContext context, bool isMobile, String title) {
    return SizedBox(
      width: 1000.0,
      height: 600.0,
      child: Stack(
        children: [
          _buildBackgroundImage(context),
          _buildTitle(title, isMobile, left: false,),
          _buildSquares(leftAligned: false),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/immeuble.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle(String text, bool isMobile, {required bool left}) {
    return Positioned(
      top: left ? 0.0 : null,
      bottom: left ? null : 0.0,
      right: left ? null : 0.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(
            color: GlobalColors.firstColor,
            fontSize: isMobile ? GlobalSize.mobileTitle : GlobalSize.webTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSquares({required bool leftAligned}) {
    return Stack(
      children: [
        WhiteSquare(left: leftAligned ? 0.0 : null, right: leftAligned ? null : 0.0, bottom: leftAligned ? 0.0 : null, top: leftAligned ? null : 0.0, size: 100, color: GlobalColors.firstColor, delayIndex: 1),
        WhiteSquare(left: leftAligned ? 100.0 : null, right: leftAligned ? null : 100.0, bottom: leftAligned ? 0.0 : null, top: leftAligned ? null : 0.0, size: 100, color: GlobalColors.firstColor, opacity: 0.8, delayIndex: 2),
        WhiteSquare(left: leftAligned ? 0.0 : null, right: leftAligned ? null : 0.0, bottom: leftAligned ? 100.0 : null, top: leftAligned ? null : 100.0, size: 100, color: GlobalColors.firstColor, opacity: 0.8, delayIndex: 2),
        WhiteSquare(left: leftAligned ? 200.0 : null, right: leftAligned ? null : 200.0, bottom: leftAligned ? 0.0 : null, top: leftAligned ? null : 0.0, size: 100, color: GlobalColors.firstColor, opacity: 0.5, delayIndex: 3),
        WhiteSquare(left: leftAligned ? 0.0 : null, right: leftAligned ? null : 0.0, bottom: leftAligned ? 200.0 : null, top: leftAligned ? null : 200.0, size: 100, color: GlobalColors.firstColor, opacity: 0.5, delayIndex: 3),
        WhiteSquare(left: leftAligned ? 100.0 : null, right: leftAligned ? null : 100.0, bottom: leftAligned ? 100.0 : null, top: leftAligned ? null : 100.0, size: 100, color: GlobalColors.firstColor, opacity: 0.4, delayIndex: 3),
      ],
    );
  }
}

class WhiteSquare extends StatefulWidget {
  final double size;
  final Color color;
  final double opacity;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final int delayIndex;

  const WhiteSquare({
    super.key,
    required this.size,
    required this.color,
    this.opacity = 1.0,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.delayIndex = 0,
  });

  @override
  WhiteSquareState createState() => WhiteSquareState();
}

class WhiteSquareState extends State<WhiteSquare> {
  bool _isVisible = false;
  bool _animationTriggered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.left}-${widget.right}-${widget.delayIndex}"), // Unique key for each element
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 0.1 && !_animationTriggered) {  
          setState(() {
            _animationTriggered = true;
          });

          // Adds a delay for each square according to its `delayIndex`
          Future.delayed(Duration(milliseconds: 300 * widget.delayIndex), () {
            if (mounted) { 
              setState(() {
                _isVisible = true;
              });
            }
          });
        }
      },
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOut,
            left: _isVisible ? widget.left : (widget.left != null ? widget.left! - 200 : null), 
            right: _isVisible ? widget.right : (widget.right != null ? widget.right! - 200 : null),
            top: widget.top,
            bottom: widget.bottom,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _isVisible ? widget.opacity : 0.0,
              child: Container(
                width: widget.size,
                height: widget.size,
                color: widget.color.withValues(alpha: widget.opacity),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

