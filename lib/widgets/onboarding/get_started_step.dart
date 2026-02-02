import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../onboarding_header.dart';
import '../primary_button.dart';

class GetStartedStep extends StatelessWidget {
  const GetStartedStep({
    super.key,
    required this.onGetStartedPressed,
    required this.onBackPressed,
  });

  final VoidCallback onGetStartedPressed;
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
            Center(
              child: SizedBox(
                width: 347,
                height: 360,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: Image.asset(
                        'assets/images/calendar_3d.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.calendar_month,
                            size: 120,
                            color: AppColors.primaryOrange,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "You’re all set! Let’s plan\nyour next meeting.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headline28ExtraBold().copyWith(
                          letterSpacing: -0.84,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'You can change this anytime in app settings.',
                        textAlign: TextAlign.center,
                        strutStyle: const StrutStyle(
                          height: 36 / 20,
                          forceStrutHeight: true,
                        ),
                        style: AppTextStyles.body20Regular().copyWith(
                          height: 36 / 20,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PrimaryButton(label: 'Get Started', onPressed: onGetStartedPressed),
          ],
        ),
      ),
    );
  }
}
