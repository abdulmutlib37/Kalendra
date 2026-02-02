import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../onboarding_header.dart';
import 'form_step_buttons.dart';

class FormStep3 extends StatelessWidget {
  const FormStep3({
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
            Expanded(
              child: SingleChildScrollView(
                child: OnboardingMiddleSection(),
              ),
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

class OnboardingMiddleSection extends StatefulWidget {
  const OnboardingMiddleSection({super.key});

  @override
  State<OnboardingMiddleSection> createState() => _OnboardingMiddleSectionState();
}

class _OnboardingMiddleSectionState extends State<OnboardingMiddleSection> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Which calendar would you like to connect',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF000000),
              letterSpacing: -0.84,
              height: 36 / 28,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildSelectableContainer(0),
        const SizedBox(height: 16),
        _buildSelectableContainer(1),
      ],
    );
  }

  Widget _buildSelectableContainer(int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFFFB8624),
                  width: 2,
                )
              : null,
        ),
        child: Container(),
      ),
    );
  }
}
