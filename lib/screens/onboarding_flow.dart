import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../routes/app_routes.dart';
import '../widgets/intro_step.dart';
import '../widgets/onboarding/form_step_1.dart';
import '../widgets/onboarding/form_step_2.dart';
import '../widgets/onboarding/form_step_3.dart';
import '../widgets/onboarding/form_step_4.dart';
import '../widgets/onboarding/form_step_5.dart';
import '../widgets/onboarding/get_started_step.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  void _goNext() {
    if (_index >= 6) return;
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

  void _skipToGetStarted() {
    _controller.animateToPage(
      6,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

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
          onSkipPressed: _skipToGetStarted,
          onBackPressed: _goBack,
        ),
        FormStep2(
          onNextPressed: _goNext,
          onSkipPressed: _skipToGetStarted,
          onBackPressed: _goBack,
        ),
        FormStep3(
          onNextPressed: _goNext,
          onSkipPressed: _skipToGetStarted,
          onBackPressed: _goBack,
        ),
        FormStep4(
          onNextPressed: _goNext,
          onSkipPressed: _skipToGetStarted,
          onBackPressed: _goBack,
        ),
        FormStep5(
          onNextPressed: _goNext,
          onSkipPressed: _skipToGetStarted,
          onBackPressed: _goBack,
        ),
        GetStartedStep(onGetStartedPressed: () => _finish(context), onBackPressed: _goBack),
      ],
    );
  }
}
