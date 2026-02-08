import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../utils/figma_scale.dart';
import '../onboarding_header.dart';
import 'form_step_buttons.dart';

class FormStep2 extends StatelessWidget {
  const FormStep2({
    super.key,
    required this.onNextPressed,
    required this.onSkipPressed,
    required this.onBackPressed,
    required this.selectedNatureOfWork,
    required this.selectedCurrentPosition,
    required this.selectedTimeManagementGoal,
    required this.onNatureOfWorkChanged,
    required this.onCurrentPositionChanged,
    required this.onTimeManagementGoalChanged,
  });

  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  final VoidCallback onBackPressed;
  final String? selectedNatureOfWork;
  final String? selectedCurrentPosition;
  final String? selectedTimeManagementGoal;
  final ValueChanged<String?> onNatureOfWorkChanged;
  final ValueChanged<String?> onCurrentPositionChanged;
  final ValueChanged<String?> onTimeManagementGoalChanged;

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
            OnboardingHeader(
              showBack: true,
              onBackPressed: onBackPressed,
              stepLabel: '2/4',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: OnboardingMiddleSection(
                  selectedNatureOfWork: selectedNatureOfWork,
                  selectedCurrentPosition: selectedCurrentPosition,
                  selectedTimeManagementGoal: selectedTimeManagementGoal,
                  onNatureOfWorkChanged: onNatureOfWorkChanged,
                  onCurrentPositionChanged: onCurrentPositionChanged,
                  onTimeManagementGoalChanged: onTimeManagementGoalChanged,
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
    required this.selectedNatureOfWork,
    required this.selectedCurrentPosition,
    required this.selectedTimeManagementGoal,
    required this.onNatureOfWorkChanged,
    required this.onCurrentPositionChanged,
    required this.onTimeManagementGoalChanged,
  });

  final String? selectedNatureOfWork;
  final String? selectedCurrentPosition;
  final String? selectedTimeManagementGoal;
  final ValueChanged<String?> onNatureOfWorkChanged;
  final ValueChanged<String?> onCurrentPositionChanged;
  final ValueChanged<String?> onTimeManagementGoalChanged;

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
  void initState() {
    super.initState();
    selectedNatureOfWork = widget.selectedNatureOfWork;
    selectedCurrentPosition = widget.selectedCurrentPosition;
    selectedTimeManagementGoal = widget.selectedTimeManagementGoal;
  }

  @override
  void didUpdateWidget(covariant OnboardingMiddleSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedNatureOfWork != widget.selectedNatureOfWork) {
      selectedNatureOfWork = widget.selectedNatureOfWork;
    }
    if (oldWidget.selectedCurrentPosition != widget.selectedCurrentPosition) {
      selectedCurrentPosition = widget.selectedCurrentPosition;
    }
    if (oldWidget.selectedTimeManagementGoal != widget.selectedTimeManagementGoal) {
      selectedTimeManagementGoal = widget.selectedTimeManagementGoal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: fs.h(16)),
          child: Text(
            'Tell us a bit about you',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fs.sp(28),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
              height: 36 / 28,
              letterSpacing: -0.84,
            ),
          ),
        ),
        SizedBox(height: fs.h(24)),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(fs.r(8)),
          ),
          padding: EdgeInsets.all(fs.w(16)),
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
                  widget.onNatureOfWorkChanged(value);
                },
              ),
              SizedBox(height: fs.h(24)),
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
                  widget.onCurrentPositionChanged(value);
                },
              ),
              SizedBox(height: fs.h(24)),
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
                  widget.onTimeManagementGoalChanged(value);
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
    final fs = FigmaScale.of(context);
    final isOpen = openDropdownIndex == index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: fs.sp(14),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF374151),
            height: 20 / 14,
          ),
        ),
        SizedBox(height: fs.h(8)),
        GestureDetector(
          onTap: () {
            setState(() {
              openDropdownIndex = isOpen ? null : index;
            });
          },
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: fs.h(56)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(fs.r(8)),
              border: Border.all(
                color: const Color(0xFFD1D5DB),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: fs.w(16),
              vertical: fs.h(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedValue ?? 'Select item',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: fs.sp(16),
                      fontWeight: FontWeight.w500,
                      color: selectedValue != null
                          ? const Color(0xFF111827)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: fs.w(20),
                  color: const Color(0xFF6B7280),
                ),
              ],
            ),
          ),
        ),
        if (isOpen) ...[
          SizedBox(height: fs.h(8)),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(fs.r(8)),
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
                    constraints: BoxConstraints(minHeight: fs.h(44)),
                    padding: EdgeInsets.symmetric(
                      horizontal: fs.w(16),
                      vertical: fs.h(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: fs.sp(14),
                              fontWeight:
                                  isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: const Color(0xFF111827),
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check,
                            size: fs.w(18),
                            color: const Color(0xFFFB8624),
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
