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
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            if (showBack)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                onPressed: onBackPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textBlack,
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
            const SizedBox(width: 44, height: 44),
          ],
        ),
      ),
    );
  }
}
