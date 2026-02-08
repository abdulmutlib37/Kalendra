import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:ui' as ui;

import '../../theme/app_colors.dart';
import '../../utils/figma_scale.dart';
import '../onboarding_header.dart';
import 'form_step_buttons.dart';

enum CalendarProvider {
  google,
  outlook,
}

class FormStep3 extends StatelessWidget {
  const FormStep3({
    super.key,
    required this.onNextPressed,
    required this.onSkipPressed,
    required this.onBackPressed,
    required this.selectedProviders,
    required this.onSelectedProvidersChanged,
  });

  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  final VoidCallback onBackPressed;
  final Set<CalendarProvider> selectedProviders;
  final ValueChanged<Set<CalendarProvider>> onSelectedProvidersChanged;

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
              stepLabel: '3/4',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: OnboardingMiddleSection(
                  selectedProviders: selectedProviders,
                  onSelectedProvidersChanged: onSelectedProvidersChanged,
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

class _EmbeddedPngFromSvgAsset extends StatefulWidget {
  const _EmbeddedPngFromSvgAsset({
    required this.svgAssetPath,
    required this.width,
    required this.height,
  });

  final String svgAssetPath;
  final double width;
  final double height;

  @override
  State<_EmbeddedPngFromSvgAsset> createState() => _EmbeddedPngFromSvgAssetState();
}

class _EmbeddedPngFromSvgAssetState extends State<_EmbeddedPngFromSvgAsset> {
  late final Future<ui.Image?> _futureImage = _loadAndTrim();

  Future<ui.Image?> _loadAndTrim() async {
    final svg = await rootBundle.loadString(widget.svgAssetPath);
    final pngBytes = _firstEmbeddedPngBytes(svg);
    if (pngBytes == null) return null;
    return _decodeAndTrimPng(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FutureBuilder<ui.Image?>(
        future: _futureImage,
        builder: (context, snapshot) {
          final img = snapshot.data;
          if (img == null) return const SizedBox.shrink();
          return FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: img.width.toDouble(),
              height: img.height.toDouble(),
              child: RawImage(image: img),
            ),
          );
        },
      ),
    );
  }
}

class _OutlookLogo extends StatelessWidget {
  const _OutlookLogo();

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return SizedBox(
      width: fs.w(147),
      height: fs.w(48),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: fs.w(48),
            height: fs.w(48),
            child: _EmbeddedPngFromSvgAsset(
              svgAssetPath: 'assets/images/Outlook_logo.svg',
              width: fs.w(48),
              height: fs.w(48),
            ),
          ),
          Positioned(
            left: fs.w(59),
            top: fs.h(14),
            width: fs.w(88),
            height: fs.h(20),
            child: Image.asset(
              'assets/images/Outlook_text.png',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
            ),
          ),
        ],
      ),
    );
  }
}

Future<ui.Image?> _decodeAndTrimPng(Uint8List bytes) async {
  try {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final trimmed = await _trimTransparentPadding(image);
    if (trimmed == null) return null;
    return trimmed;
  } catch (_) {
    return null;
  }
}

Future<ui.Image?> _trimTransparentPadding(ui.Image image) async {
  final rgba = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (rgba == null) return image;

  final data = rgba.buffer.asUint8List();
  final width = image.width;
  final height = image.height;

  int minX = width;
  int minY = height;
  int maxX = -1;
  int maxY = -1;

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final i = (y * width + x) * 4;
      final a = data[i + 3];
      if (a == 0) continue;
      if (x < minX) minX = x;
      if (y < minY) minY = y;
      if (x > maxX) maxX = x;
      if (y > maxY) maxY = y;
    }
  }

  if (maxX < minX || maxY < minY) {
    return image;
  }

  final cropW = (maxX - minX + 1);
  final cropH = (maxY - minY + 1);
  return _cropImage(image, minX, minY, cropW, cropH);
}

Future<ui.Image> _cropImage(ui.Image image, int x, int y, int w, int h) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final src = Rect.fromLTWH(x.toDouble(), y.toDouble(), w.toDouble(), h.toDouble());
  final dst = Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble());
  canvas.drawImageRect(image, src, dst, Paint());
  final picture = recorder.endRecording();
  return picture.toImage(w, h);
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

class OnboardingMiddleSection extends StatelessWidget {
  const OnboardingMiddleSection({
    super.key,
    required this.selectedProviders,
    required this.onSelectedProvidersChanged,
  });

  final Set<CalendarProvider> selectedProviders;
  final ValueChanged<Set<CalendarProvider>> onSelectedProvidersChanged;

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: fs.h(16)),
          child: Text(
            'Which calendar would you like to connect',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fs.sp(28),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
              letterSpacing: -0.84,
              height: 36 / 28,
            ),
          ),
        ),
        SizedBox(height: fs.h(32)),
        _buildSelectableContainer(context, CalendarProvider.google),
        SizedBox(height: fs.h(16)),
        _buildSelectableContainer(context, CalendarProvider.outlook),
      ],
    );
  }

  void _toggle(CalendarProvider provider) {
    final next = Set<CalendarProvider>.from(selectedProviders);
    if (next.contains(provider)) {
      next.remove(provider);
    } else {
      next.add(provider);
    }
    onSelectedProvidersChanged(next);
  }

  Widget _buildSelectableContainer(BuildContext context, CalendarProvider provider) {
    final isSelected = selectedProviders.contains(provider);
    final fs = FigmaScale.of(context);

    final Widget logo = provider == CalendarProvider.google
        ? _EmbeddedPngFromSvgAsset(
            svgAssetPath: 'assets/images/google.svg',
            width: fs.w(214),
            height: fs.h(50),
          )
        : const _OutlookLogo();

    return GestureDetector(
      onTap: () => _toggle(provider),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: fs.h(100)),
        padding: EdgeInsets.all(fs.w(20)),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(fs.r(16)),
            topRight: Radius.circular(fs.r(16)),
            bottomLeft: Radius.circular(fs.r(8)),
            bottomRight: Radius.circular(fs.r(8)),
          ),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFFFB8624),
                  width: fs.w(2),
                )
              : null,
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: logo,
            ),
            const Spacer(),
            if (isSelected)
              SizedBox(
                width: fs.w(32),
                height: fs.w(32),
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
