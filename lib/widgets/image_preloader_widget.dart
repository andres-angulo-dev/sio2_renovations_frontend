import 'package:flutter/material.dart';

class ImagePreloaderWidget extends StatefulWidget {
  final List<String> imagePaths;
  final Widget child;
  final VoidCallback? onLoaded;

  const ImagePreloaderWidget({
    required this.imagePaths,
    required this.child,
    this.onLoaded,
    super.key,
  });

  @override
  ImagePreloaderWidgetState createState() => ImagePreloaderWidgetState();
}

class ImagePreloaderWidgetState extends State<ImagePreloaderWidget> {

  // Is called right after initState of parent and ensures that the context is fully ready
  @override
  void didChangeDependencies() { 
    super.didChangeDependencies();
    _preloadImages();
  }

  void _preloadImages() async {
    for (final path in widget.imagePaths) {
      await precacheImage(AssetImage(path), context);
    }
    if (mounted) {
      widget.onLoaded?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
