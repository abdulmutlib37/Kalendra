import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/figma_scale.dart';
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
    final fs = FigmaScale.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(fs.w(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnboardingHeader(showBack: true, onBackPressed: onBackPressed),
            Center(
              child: SizedBox(
                width: fs.w(347),
                height: fs.h(360),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: fs.w(180),
                      height: fs.w(180),
                      child: Image.asset(
                        'assets/images/calendar_3d.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.calendar_month,
                            size: fs.w(120),
                            color: AppColors.primaryOrange,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: fs.h(24)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: fs.w(8)),
                      child: Text(
                        "You’re all set! Let’s plan\nyour next meeting.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headline28ExtraBold().copyWith(
                          fontSize: fs.sp(28),
                          letterSpacing: -0.84,
                        ),
                      ),
                    ),
                    SizedBox(height: fs.h(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: fs.w(8)),
                      child: Text(
                        'You can change this anytime in app settings.',
                        textAlign: TextAlign.center,
                        strutStyle: const StrutStyle(
                          height: 36 / 20,
                          forceStrutHeight: true,
                        ),
                        style: AppTextStyles.body20Regular().copyWith(
                          fontSize: fs.sp(20),
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
