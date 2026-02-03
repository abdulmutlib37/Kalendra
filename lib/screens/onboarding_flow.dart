import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../routes/app_routes.dart';
import '../widgets/intro_step.dart';
import '../widgets/onboarding/form_step_1.dart';
import '../widgets/onboarding/form_step_2.dart';
import '../widgets/onboarding/form_step_3.dart';
import '../widgets/onboarding/form_step_4.dart';
import '../widgets/onboarding/get_started_step.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _controller = PageController();
  int _index = 0;

  Set<int> _step1SelectedOptions = <int>{};
  String? _step2SelectedNatureOfWork;
  String? _step2SelectedCurrentPosition;
  String? _step2SelectedTimeManagementGoal;
  Set<CalendarProvider> _selectedCalendarProviders = <CalendarProvider>{};
  int? _step4SelectedIndex;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  void _goNext() {
    if (_index >= 5) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _goBack() {
    if (_index <= 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  // Skip should behave like Continue: advance to the next page.
  void _skip() => _goNext();

  void _finish(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        setState(() {
          _index = value;
        });
      },
      children: [
        IntroStep(onNextPressed: _goNext),
        FormStep1(
          onNextPressed: _goNext,
          onSkipPressed: _skip,
          onBackPressed: _goBack,
          selectedOptions: _step1SelectedOptions,
          onSelectedOptionsChanged: (next) {
            setState(() {
              _step1SelectedOptions = next;
            });
          },
        ),
        FormStep2(
          onNextPressed: _goNext,
          onSkipPressed: _skip,
          onBackPressed: _goBack,
          selectedNatureOfWork: _step2SelectedNatureOfWork,
          selectedCurrentPosition: _step2SelectedCurrentPosition,
          selectedTimeManagementGoal: _step2SelectedTimeManagementGoal,
          onNatureOfWorkChanged: (value) {
            setState(() {
              _step2SelectedNatureOfWork = value;
            });
          },
          onCurrentPositionChanged: (value) {
            setState(() {
              _step2SelectedCurrentPosition = value;
            });
          },
          onTimeManagementGoalChanged: (value) {
            setState(() {
              _step2SelectedTimeManagementGoal = value;
            });
          },
        ),
        FormStep3(
          onNextPressed: _goNext,
          onSkipPressed: _skip,
          onBackPressed: _goBack,
          selectedProviders: _selectedCalendarProviders,
          onSelectedProvidersChanged: (next) {
            setState(() {
              _selectedCalendarProviders = next;
            });
          },
        ),
        FormStep4(
          onNextPressed: _goNext,
          onSkipPressed: _skip,
          onBackPressed: _goBack,
          selectedIndex: _step4SelectedIndex,
          onSelectedIndexChanged: (value) {
            setState(() {
              _step4SelectedIndex = value;
            });
          },
        ),
        GetStartedStep(onGetStartedPressed: () => _finish(context), onBackPressed: _goBack),
      ],
    );
  }
}
