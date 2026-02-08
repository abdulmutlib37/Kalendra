import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../utils/figma_scale.dart';
import 'onboarding_logo.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.showBack,
    this.onBackPressed,
    this.stepLabel,
  });

  final bool showBack;
  final VoidCallback? onBackPressed;
  final String? stepLabel;

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: fs.w(20),
          vertical: fs.h(12),
        ),
        child: Row(
          children: [
            if (showBack)
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: fs.w(44),
                constraints: BoxConstraints(
                  minWidth: fs.w(44),
                  minHeight: fs.w(44),
                ),
                onPressed: onBackPressed,
                icon: SvgPicture.asset(
                  'assets/images/Icon.svg',
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textBlack,
                    BlendMode.srcIn,
                  ),
                ),
              )
            else
              SizedBox(width: fs.w(44), height: fs.w(44)),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: fs.w(200)),
                  child: const OnboardingLogo(),
                ),
              ),
            ),
            SizedBox(
              width: fs.w(44),
              height: fs.w(44),
              child: stepLabel == null
                  ? null
                  : Center(
                      child: Text(
                        stepLabel!,
                        style: TextStyle(
                          fontSize: fs.sp(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
