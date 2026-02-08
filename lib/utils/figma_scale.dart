import 'package:flutter/widgets.dart';

class FigmaScale {
  static const double figmaWidth = 430.0;
  static const double figmaHeight = 932.0;

  final double screenW;
  final double screenH;
  final double sx;
  final double sy;
  final double s;

  FigmaScale._(
    this.screenW,
    this.screenH,
    this.sx,
    this.sy,
    this.s,
  );

  factory FigmaScale.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final sx = size.width / figmaWidth;
    final sy = size.height / figmaHeight;
    final s = sx < sy ? sx : sy;
    return FigmaScale._(size.width, size.height, sx, sy, s);
  }

  double w(double v) => v * sx;
  double h(double v) => v * sy;

  double u(double v) => v * s;

  double sp(double v) => v * s;
  double r(double v) => v * s;

  EdgeInsets insets({double l = 0, double t = 0, double r = 0, double b = 0}) {
    return EdgeInsets.fromLTRB(w(l), h(t), w(r), h(b));
  }

  EdgeInsets sym({double h = 0, double v = 0}) {
    return EdgeInsets.symmetric(horizontal: w(h), vertical: this.h(v));
  }
}
