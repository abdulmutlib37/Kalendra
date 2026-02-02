import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'onboarding_logo.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.showBack,
    this.onBackPressed,
  });

  final bool showBack;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 98,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (showBack)
            Positioned(
              left: 20,
              top: 54,
              width: 44,
              height: 44,
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                constraints: const BoxConstraints.tightFor(
                  width: 44,
                  height: 44,
                ),
                onPressed: onBackPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textBlack,
                ),
              ),
            ),
          const Positioned(
            left: 132,
            top: 58,
            width: 166,
            height: 36,
            child: OnboardingLogo(),
          ),
        ],
      ),
    );
  }
}
