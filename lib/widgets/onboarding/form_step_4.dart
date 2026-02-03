import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../onboarding_header.dart';
import 'form_step_buttons.dart';

class FormStep4 extends StatelessWidget {
  const FormStep4({
    super.key,
    required this.onNextPressed,
    required this.onSkipPressed,
    required this.onBackPressed,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
  });

  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  final VoidCallback onBackPressed;
  final int? selectedIndex;
  final ValueChanged<int?> onSelectedIndexChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnboardingHeader(
              showBack: true,
              onBackPressed: onBackPressed,
              stepLabel: '4/4',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: OnboardingMiddleSection(
                  selectedIndex: selectedIndex,
                  onSelectedIndexChanged: onSelectedIndexChanged,
                ),
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
  const OnboardingMiddleSection({
    super.key,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
  });

  final int? selectedIndex;
  final ValueChanged<int?> onSelectedIndexChanged;

  @override
  State<OnboardingMiddleSection> createState() => _OnboardingMiddleSectionState();
}

class _OnboardingMiddleSectionState extends State<OnboardingMiddleSection> {
  int? selectedIndex;

  final List<String> options = [
    '1 hour',
    '2 hours',
    '3 hours',
    'No limit',
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant OnboardingMiddleSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 108),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'How long can you stay in meetings without a break?',
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
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "We'll remind you to take a breather.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                    letterSpacing: -0.6,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              LayoutBuilder(
                builder: (context, constraints) {
                  const spacing = 12.0;
                  final itemWidth = (constraints.maxWidth - spacing) / 2;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: List.generate(options.length, (index) {
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          widget.onSelectedIndexChanged(index);
                        },
                        child: Container(
                          width: itemWidth,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFFB8624)
                                : const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              options[index],
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFF000000),
                                letterSpacing: -0.6,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
