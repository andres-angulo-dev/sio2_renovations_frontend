// With progressive zoom effects and smooth fade transitions
import 'dart:async';
import 'package:flutter/material.dart';

class ZoomFadeIamgeCarouselWidget extends StatefulWidget {
  final List<String> imagePaths;
  final Duration interval; // Duration each image stays before switching
  final double height;

  const ZoomFadeIamgeCarouselWidget({
    super.key,
    required this.imagePaths,
    this.interval = const Duration(seconds: 6),
    required this.height,
  });

  @override
  ZoomFadeIamgeCarouselWidgetState createState() => ZoomFadeIamgeCarouselWidgetState();
}

class ZoomFadeIamgeCarouselWidgetState extends State<ZoomFadeIamgeCarouselWidget> with TickerProviderStateMixin {
  late int _currentIndex;
  late int _previousIndex;
  late Timer _timer;

  late AnimationController _fadeController; // Controls fade (transition) animation
  late Animation<double> _fadeAnimation;  

  late AnimationController _currentScaleController;  // Controls scale (zoom) animation
  late Animation<double> _currentScaleAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _previousIndex = 0;

    // Initialize fade-in animation for image transitions
    _fadeController = AnimationController( 
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward(); // Another syntax to avoid having to declare _scaleController.forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut // Smooth start and end
    );

    // Initialize zoom (scale) animation for active image
    _currentScaleController = AnimationController(
      vsync: this,
      duration: widget.interval, // Duration image interval
    );

    _currentScaleAnimation = Tween<double>(
      begin: 1.0, 
      end: 1.05, // Enlargement
    ).animate(CurvedAnimation(
        parent: _currentScaleController,
        curve: Curves.easeInOut
      ),
    );

    // Start scale animation initially
    _fadeController.forward();
    _currentScaleController.forward();
    // Begin timer that cycles images every [interval] seconds
    _startCycleTimer(); 
  }

  void _startCycleTimer() {
    _timer = Timer.periodic(widget.interval, (_) {
      setState(() {
        _previousIndex = _currentIndex; // Hold previous before switching
        _currentIndex = (_currentIndex + 1) % widget.imagePaths.length; // Loop to next image
      });

      // Reset and restart both fade and zoom animations
      _fadeController.reset();
      _currentScaleController.reset();

      _fadeController.forward();
      _currentScaleController.forward();
    });
  }

  // Cancel the timer and dispose animations to free memory
  @override
  void dispose() {
    _timer.cancel();
    _fadeController.dispose();
    _currentScaleController.dispose();
    super.dispose();
  }

  Widget _buildImage(String path, {required double scale}) {
    return ClipRect(
      child: Transform.scale(
        scale: scale, // Final value, fixed
        child: Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The previous image remains frozen at its last zoom, the same scale value as 'end' in _currentScaleAnimation.
        _buildImage(widget.imagePaths[_previousIndex], scale: 1.05),

        // Current image with progressive zoom + fade in
        ClipRect(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: AnimatedBuilder(
              animation: _currentScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _currentScaleAnimation.value,
                  child: Container(
                    height: widget.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.imagePaths[_currentIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
