import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

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

class _EmbeddedPngFromSvgAsset extends StatelessWidget {
  const _EmbeddedPngFromSvgAsset({
    required this.svgAssetPath,
    required this.width,
    required this.height,
  });

  final String svgAssetPath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FutureBuilder<String>(
        future: rootBundle.loadString(svgAssetPath),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          final pngBytes = _firstEmbeddedPngBytes(snapshot.data!);
          if (pngBytes == null) {
            return const SizedBox.shrink();
          }

          return Image.memory(pngBytes, fit: BoxFit.contain);
        },
      ),
    );
  }
}

class _OutlookEmbeddedPngLogo extends StatelessWidget {
  const _OutlookEmbeddedPngLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 186,
      height: 48,
      child: FutureBuilder<String>(
        future: rootBundle.loadString('assets/images/outlook.svg'),
        builder: _build,
      ),
    );
  }

  static Widget _build(BuildContext context, AsyncSnapshot<String> snapshot) {
    if (!snapshot.hasData) {
      return const SizedBox.shrink();
    }

    final bytes = _allEmbeddedPngBytes(snapshot.data!);
    if (bytes.isEmpty) {
      return const SizedBox.shrink();
    }

    final iconPng = bytes.isNotEmpty ? bytes[0] : null;
    final textPng = bytes.length >= 2 ? bytes[1] : null;

    return Stack(
      children: [
        if (iconPng != null)
          Positioned(
            left: 0,
            top: 0,
            width: 48,
            height: 48,
            child: Image.memory(iconPng, fit: BoxFit.contain),
          ),
        if (textPng != null)
          Positioned(
            left: 59,
            top: 14,
            width: 88,
            height: 20,
            child: Image.memory(textPng, fit: BoxFit.contain),
          ),
      ],
    );
  }
}

Uint8List? _firstEmbeddedPngBytes(String svgContent) {
  final matches = _allEmbeddedPngBytes(svgContent);
  if (matches.isEmpty) return null;
  return matches.first;
}

List<Uint8List> _allEmbeddedPngBytes(String svgContent) {
  final regex = RegExp(r'data:image\/png;base64,([A-Za-z0-9+/=]+)');
  final out = <Uint8List>[];
  for (final match in regex.allMatches(svgContent)) {
    final b64 = match.group(1);
    if (b64 == null || b64.isEmpty) continue;
    try {
      out.add(base64Decode(b64));
    } catch (_) {
      // ignore decode failures
    }
  }
  return out;
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

    final Widget logo = index == 0
        ? const _EmbeddedPngFromSvgAsset(
            svgAssetPath: 'assets/images/google.svg',
            width: 214,
            height: 50,
          )
        : const _OutlookEmbeddedPngLogo();

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
        child: Row(
          children: [
            Flexible(child: logo),
            const Spacer(),
            if (isSelected)
              SizedBox(
                width: 32,
                height: 32,
                child: SvgPicture.asset(
                  'assets/images/CheckCircle.svg',
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
