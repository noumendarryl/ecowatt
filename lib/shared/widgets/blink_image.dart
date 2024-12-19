import 'package:flutter/cupertino.dart';

class BlinkingImage extends StatefulWidget {
  final String imagePath;
  final Duration blinkDuration;
  final Duration pauseDuration;

  const BlinkingImage({
    super.key,
    required this.imagePath,
    this.blinkDuration = const Duration(milliseconds: 500),
    this.pauseDuration = const Duration(seconds: 2),
  });

  @override
  State<BlinkingImage> createState() => _BlinkingImageState();
}

class _BlinkingImageState extends State<BlinkingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      duration: widget.blinkDuration,
      vsync: this,
    )..addStatusListener((status) {
      // Repeat the animation with a pause
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.pauseDuration, () {
          if (mounted) {
            _controller.forward(from: 0.0);
          }
        });
      }
    });

    // Create an animation that goes from 1 to 0 and back to 1
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        widget.imagePath,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
