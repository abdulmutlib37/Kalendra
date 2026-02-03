import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'onboarding_header.dart';
import 'primary_button.dart';

class IntroStep extends StatelessWidget {
  const IntroStep({super.key, required this.onNextPressed});

  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const OnboardingHeader(showBack: false),
            Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.headline48ExtraBold().copyWith(
                      letterSpacing: -1.44,
                    ),
                    children: const [
                      TextSpan(text: "Let's "),
                      TextSpan(
                        text: 'set up ',
                        style: TextStyle(color: AppColors.primaryOrange),
                      ),
                      TextSpan(text: 'Kalendra'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'this only takes a moment',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body20Regular().copyWith(
                    letterSpacing: -0.6,
                  ),
                ),
              ],
            ),
            PrimaryButton(label: 'Set up', onPressed: onNextPressed),
          ],
        ),
      ),
    );
  }
}
