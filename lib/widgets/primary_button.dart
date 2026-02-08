import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/figma_scale.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return SizedBox(
      width: double.infinity,
      height: fs.h(60),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(fs.r(16)),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: AppTextStyles.button20ExtraBold(color: AppColors.white).copyWith(
            fontSize: fs.sp(20),
          ),
        ),
      ),
    );
  }
}
