import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../onboarding_header.dart';
import 'form_step_buttons.dart';

class FormStep1 extends StatelessWidget {
  const FormStep1({
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
  Set<int> selectedOptions = {};

  final List<String> options = [
    'Managing multiple calendars is chaotic',
    'I often schedule meetings on the go.',
    'My calendar does not reflect my travel times',
    'I double book meetings / events too frequently',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Which of these do you\nresonate with?',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF000000),
              height: 36 / 28,
              letterSpacing: -0.84,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Select all that apply',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000),
            height: 36 / 20,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate(options.length, (index) {
          final isSelected = selectedOptions.contains(index);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedOptions.remove(index);
                  } else {
                    selectedOptions.add(index);
                  }
                });
              },
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF5F5F4) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFD1D5DB),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(minHeight: 64),
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    options[index],
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                      height: 24 / 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
