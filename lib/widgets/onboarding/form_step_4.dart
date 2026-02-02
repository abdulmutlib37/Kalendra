import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../onboarding_header.dart';
import 'form_step_buttons.dart';

class FormStep4 extends StatelessWidget {
  const FormStep4({
    super.key,
    required this.onNextPressed,
    required this.onSkipPressed,
    required this.onBackPressed,
  });

  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnboardingHeader(showBack: true, onBackPressed: onBackPressed),
            Column(
              children: [
                Text(
                  'Form Step 4',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headline48ExtraBold(),
                ),
                const SizedBox(height: 12),
                Text(
                  'Replace this with Figma layout',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body20Regular(),
                ),
              ],
            ),
            FormStepButtons(
              onSkipPressed: onSkipPressed,
              onContinuePressed: onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}
