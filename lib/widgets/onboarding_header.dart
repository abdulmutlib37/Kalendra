import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
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
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            if (showBack)
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 44,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
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
              const SizedBox(width: 44, height: 44),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: const OnboardingLogo(),
                ),
              ),
            ),
            SizedBox(
              width: 44,
              height: 44,
              child: stepLabel == null
                  ? null
                  : Center(
                      child: Text(
                        stepLabel!,
                        style: const TextStyle(
                          fontSize: 16,
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
