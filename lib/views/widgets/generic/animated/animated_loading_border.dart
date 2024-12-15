import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedLoadingBorder extends StatefulWidget {
  final Widget child;
  final ValueChanged<AnimationController>? controller;
  final Duration duration;
  final double cornerRadius;
  final double borderWidth;
  final Color borderColor;
  final Color trailingBorderColor;
  final EdgeInsets padding;

  /// Used to set starting position of SweepGradient
  final bool startWithRandomPosition;

  /// Used to set starting color of SweepGradient
  final bool isTrailingTransparent;

  const AnimatedLoadingBorder({
    required this.child,
    this.controller,
    this.duration = const Duration(seconds: 4),
    this.cornerRadius = 0.0,
    this.borderWidth = 1,
    this.borderColor = Colors.black,
    this.trailingBorderColor = Colors.black,
    this.padding = EdgeInsets.zero,
    this.startWithRandomPosition = true,
    this.isTrailingTransparent = true,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedLoadingBorderState createState() => _AnimatedLoadingBorderState();
}

class _AnimatedLoadingBorderState extends State<AnimatedLoadingBorder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Color borderColor = Colors.transparent;

  @override
  void didUpdateWidget(AnimatedLoadingBorder oldWidget) {
    if (oldWidget != oldWidget) {
      // Starts the widget animation
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    borderColor = widget.borderColor;

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((AnimationStatus status) {
        // Used to hide the animation and passing the child widget to this animated widget
        if (status == AnimationStatus.reverse) {
          setState(() {
            // To hide the animated border
            borderColor = Colors.transparent;
          });
        }
      });
    _controller.repeat();

    widget.controller?.call(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BorderPainter(
        animation: _controller,
        cornerRadius: widget.cornerRadius,
        borderWidth: widget.borderWidth,
        borderColor: borderColor,
        trailingBorderColor: widget.trailingBorderColor,
        isTrailingTransparent: widget.isTrailingTransparent,
        startingPosition: widget.startWithRandomPosition ? getRandomNumber() : 0,
      ),
      child: Padding(
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }

  /// Generate the starting position that used in SweepGradient
  int getRandomNumber() {
    math.Random random = math.Random();
    return random.nextInt(20) + 6;
  }
}

/// Class to Paint the Animated Loading Border
class _BorderPainter extends CustomPainter {
  final Animation<double> animation;
  final double cornerRadius;
  final double borderWidth;
  final Color borderColor;
  final Color trailingBorderColor;

  /// Used to set starting color of SweepGradient
  final bool isTrailingTransparent;

  /// Starting position used in SweepGradient
  final int startingPosition;

  _BorderPainter({
    required this.animation,
    required this.cornerRadius,
    required this.borderWidth,
    required this.borderColor,
    required this.trailingBorderColor,
    required this.isTrailingTransparent,
    required this.startingPosition,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()..color = Colors.transparent;
    final double progress = animation.value;

    if (progress > 0.0) {
      paint
        ..color = trailingBorderColor
        ..shader = SweepGradient(
          colors: <Color>[
            if (isTrailingTransparent) Colors.transparent else borderColor.withOpacity(0.1),
            borderColor,
            Colors.transparent,
          ],
          stops: const <double>[
            0.0,
            1.0,
            1.0,
          ],
          startAngle: math.pi / 8,
          endAngle: math.pi / 2,
          transform: GradientRotation(
            (math.pi * 2 * progress) + startingPosition,
          ),
        ).createShader(rect);
    }

    RRect rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(cornerRadius),
    );

    final Path path = Path()..addRRect(rRect);

    canvas
      ..drawRRect(
        rRect,
        paint
          ..strokeWidth = borderWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      )
      ..drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BorderPainter oldDelegate) => true;
}
