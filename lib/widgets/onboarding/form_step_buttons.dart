import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/figma_scale.dart';

class FormStepButtons extends StatelessWidget {
  const FormStepButtons({
    super.key,
    required this.onSkipPressed,
    required this.onContinuePressed,
  });

  final VoidCallback onSkipPressed;
  final VoidCallback onContinuePressed;

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: fs.h(60)),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: fs.h(60),
              child: ElevatedButton(
                onPressed: onSkipPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightGrey,
                  foregroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(fs.r(16)),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Skip',
                  style: AppTextStyles.button20ExtraBold(
                    color: AppColors.primaryOrange,
                  ).copyWith(fontSize: fs.sp(20)),
                ),
              ),
            ),
          ),
          SizedBox(width: fs.w(14)),
          Expanded(
            child: SizedBox(
              height: fs.h(60),
              child: ElevatedButton(
                onPressed: onContinuePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(fs.r(16)),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.button20ExtraBold(color: AppColors.white)
                      .copyWith(fontSize: fs.sp(20)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
