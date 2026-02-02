import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../onboarding_header.dart';
import 'form_step_buttons.dart';

class FormStep2 extends StatelessWidget {
  const FormStep2({
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
  String? selectedNatureOfWork;
  String? selectedCurrentPosition;
  String? selectedTimeManagementGoal;

  int? openDropdownIndex;

  final List<String> natureOfWorkOptions = [
    'Full-time employee',
    'Part-time employee',
    'Freelancer',
    'Entrepreneur',
    'Student',
    'Consultant',
    'Other',
  ];

  final List<String> currentPositionOptions = [
    'Executive/C-Level',
    'Senior Manager',
    'Manager',
    'Team Lead',
    'Individual Contributor',
    'Intern',
    'Other',
  ];

  final List<String> timeManagementGoalOptions = [
    'Reduce meeting conflicts',
    'Better work-life balance',
    'Improve scheduling efficiency',
    'Track time more effectively',
    'Coordinate team schedules',
    'Manage travel time',
    'All of the above',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Tell us a bit about you',
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
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField(
                index: 0,
                heading: 'Nature of work',
                selectedValue: selectedNatureOfWork,
                options: natureOfWorkOptions,
                onSelect: (value) {
                  setState(() {
                    selectedNatureOfWork = value;
                    openDropdownIndex = null;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildDropdownField(
                index: 1,
                heading: 'Current position',
                selectedValue: selectedCurrentPosition,
                options: currentPositionOptions,
                onSelect: (value) {
                  setState(() {
                    selectedCurrentPosition = value;
                    openDropdownIndex = null;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildDropdownField(
                index: 2,
                heading: 'Time management goals',
                selectedValue: selectedTimeManagementGoal,
                options: timeManagementGoalOptions,
                onSelect: (value) {
                  setState(() {
                    selectedTimeManagementGoal = value;
                    openDropdownIndex = null;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required int index,
    required String heading,
    required String? selectedValue,
    required List<String> options,
    required ValueChanged<String> onSelect,
  }) {
    final isOpen = openDropdownIndex == index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF374151),
            height: 20 / 14,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              openDropdownIndex = isOpen ? null : index;
            });
          },
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 56),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFD1D5DB),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedValue ?? 'Select item',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedValue != null
                          ? const Color(0xFF111827)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 20,
                  color: const Color(0xFF6B7280),
                ),
              ],
            ),
          ),
        ),
        if (isOpen) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFD1D5DB),
                width: 1,
              ),
            ),
            child: Column(
              children: options.map((option) {
                final isSelected = selectedValue == option;
                return GestureDetector(
                  onTap: () => onSelect(option),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 44),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            size: 20,
                            color: Color(0xFFFB8624),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
