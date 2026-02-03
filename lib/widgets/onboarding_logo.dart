import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 166,
      height: 36,
      child: Row(
        children: [
          // TODO: Replace with Image.asset for logo
          SizedBox(
            width: 35.62,
            height: 36,
            child: Stack(
              children: [
                ClipPath(
                  clipper: const _BorderRingClipper(
                    borderRadius: 10,
                    strokeWidth: 1,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const SizedBox.expand(),
                  ),
                ),
                CustomPaint(
                  painter: _GradientBorderPainter(
                    borderRadius: 10,
                    strokeWidth: 1,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.72, 1.0],
                      colors: [
                        Color(0x4DFB8624),
                        Color(0x4D2E363C),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 23.74,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/images/kalendra_mark.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SvgPicture.asset(
              'assets/images/kalendra_text.svg',
              height: 36,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  _GradientBorderPainter({
    required this.gradient,
    required this.borderRadius,
    required this.strokeWidth,
  });

  final Gradient gradient;
  final double borderRadius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.miter
      ..shader = gradient.createShader(rect);

    if (borderRadius <= 0) {
      canvas.drawRect(rect, paint);
      return;
    }

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class _BorderRingClipper extends CustomClipper<Path> {
  const _BorderRingClipper({
    required this.borderRadius,
    required this.strokeWidth,
  });

  final double borderRadius;
  final double strokeWidth;

  @override
  Path getClip(Size size) {
    final rect = Offset.zero & size;
    final outer = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final innerRect = Rect.fromLTWH(
      strokeWidth,
      strokeWidth,
      size.width - strokeWidth * 2,
      size.height - strokeWidth * 2,
    );
    final inner = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular((borderRadius - strokeWidth).clamp(0, borderRadius)),
    );

    return Path()
      ..addRRect(outer)
      ..addRRect(inner)
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant _BorderRingClipper oldClipper) {
    return oldClipper.borderRadius != borderRadius ||
        oldClipper.strokeWidth != strokeWidth;
  }
}
