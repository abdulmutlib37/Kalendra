import 'package:flutter/material.dart';

import '../../utils/figma_scale.dart';

class HomeFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const HomeFilterChip({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: fs.w(24),
          vertical: fs.h(10),
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(fs.r(12)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fs.sp(15),
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
