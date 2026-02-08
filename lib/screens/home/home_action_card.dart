import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/figma_scale.dart';

class HomeActionCard extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final double titleWidth;
  final double titleHeight;
  final double subtitleWidth;
  final double subtitleHeight;
  final String iconAsset;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const HomeActionCard({
    super.key,
    required this.width,
    required this.height,
    required this.iconSize,
    required this.titleWidth,
    required this.titleHeight,
    required this.subtitleWidth,
    required this.subtitleHeight,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(fs.w(16)),
        decoration: BoxDecoration(
          color: const Color(0xFF4A5661),
          borderRadius: BorderRadius.circular(fs.r(16)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/$iconAsset',
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            SizedBox(
              width: titleWidth,
              height: titleHeight,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fs.sp(16),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ),
            SizedBox(height: fs.h(4)),
            SizedBox(
              width: subtitleWidth,
              height: subtitleHeight,
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fs.sp(12),
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
