import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/figma_scale.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return SizedBox(
      width: fs.w(166),
      height: fs.h(36),
      child: Row(
        children: [
          // TODO: Replace with Image.asset for logo
          SizedBox(
            width: fs.w(35.62),
            height: fs.h(36),
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
                    borderRadius: fs.r(10),
                    strokeWidth: fs.w(1),
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
                    borderRadius: BorderRadius.circular(fs.r(10)),
                    child: Padding(
                      padding: EdgeInsets.all(fs.w(1)),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(fs.r(9)),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: fs.w(23.74),
                            height: fs.h(24),
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
          SizedBox(width: fs.w(8)),
          Expanded(
            child: SvgPicture.asset(
              'assets/images/kalendra_text.svg',
              height: fs.h(36),
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
