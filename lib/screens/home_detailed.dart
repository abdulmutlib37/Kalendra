import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../routes/app_routes.dart';
import '../utils/figma_scale.dart';

class HomeDetailedScreen extends StatefulWidget {
  const HomeDetailedScreen({super.key});

  @override
  State<HomeDetailedScreen> createState() => _HomeDetailedScreenState();
}

class _HomeDetailedScreenState extends State<HomeDetailedScreen> {
  bool _isListening = false;

  String _getCurrentDate() {
    final now = DateTime.now();
    final dateFormatter = DateFormat('EEEE, d');
    final day = now.day;
    final monthYear = DateFormat('MMM yyyy').format(now);

    String getOrdinal(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    return '${dateFormatter.format(now)}${getOrdinal(day)} $monthYear';
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    final screenWidth = fs.screenW;
    final screenHeight = fs.screenH;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.2,
                colors: [
                  Color(0xFF4A3726),
                  Color(0xFF2E363C),
                  Color(0xFF1A1E21),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          Positioned(
            left: (screenWidth - fs.w(509.95)) / 2,
            top: fs.h(233),
            child: Container(
              width: fs.w(509.95),
              height: fs.h(482),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFB8624).withValues(alpha: 0.4),
                    const Color(0xFF7B92A4).withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                  stops: const [0.2, 0.6, 1.0],
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: safeAreaTop),
              _buildHeader(fs),
              Expanded(
                child: _buildMainContent(
                  fs,
                ),
              ),
              _buildMicrophoneButton(fs),
              SizedBox(height: safeAreaBottom + fs.h(20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(FigmaScale fs) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        fs.w(16),
        fs.h(16),
        fs.w(16),
        fs.h(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: SvgPicture.asset(
              'assets/images/Hello.svg',
              height: fs.h(58),
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(width: fs.w(12)),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
            child: SvgPicture.asset(
              'assets/images/settings.svg',
              width: fs.w(56),
              height: fs.w(56),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(
    FigmaScale fs,
  ) {
    final screenWidth = fs.screenW;
    final welcomeLeft = fs.w(117.87);
    final welcomeTop = fs.h(65.0);
    final welcomeWidth = fs.w(194.26);

    return Stack(
      children: [
        Positioned(
          top: welcomeTop + fs.h(13.5),
          left: 0,
          child: Container(
            width: welcomeLeft,
            height: 1,
            color: const Color(0xFF484848),
          ),
        ),
        Positioned(
          left: welcomeLeft,
          top: welcomeTop,
          child: Container(
            width: welcomeWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(fs.r(50)),
              border: Border.all(
                color: const Color(0xFF484848),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: fs.w(14),
                vertical: fs.h(10),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Welcome, Start Scheduling',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: fs.sp(12),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: welcomeTop + fs.h(13.5),
          left: welcomeLeft + welcomeWidth,
          child: Container(
            width: screenWidth - (welcomeLeft + welcomeWidth),
            height: 1,
            color: const Color(0xFF484848),
          ),
        ),
        Positioned(
          left: fs.w(153),
          top: fs.h(234),
          child: Container(
            width: fs.w(124),
            height: fs.h(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(fs.r(20)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2F3641),
                  Color(0xFF2F3741),
                ],
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(fs.w(1)),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(fs.r(19)),
              ),
              child: Center(
                child: Text(
                  _getCurrentDate(),
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: fs.sp(10),
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.3,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: fs.w(49),
          top: fs.h(283),
          child: SizedBox(
            width: fs.w(332),
            height: fs.h(62),
            child: Text(
              'How can I help with your\ncalendar today?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: fs.sp(22),
                fontWeight: FontWeight.w600,
                height: 1.409,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMicrophoneButton(FigmaScale fs) {
    return Column(
      children: [
        CustomPaint(
          size: Size(fs.screenW, fs.h(180)),
          painter: const WavePainter(),
        ),
        SizedBox(height: fs.h(30)),
        GestureDetector(
          onTap: () {
            setState(() {
              _isListening = !_isListening;
            });
          },
          child: SizedBox(
            width: fs.w(119),
            height: fs.w(120),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: fs.w(119),
                  height: fs.w(120),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFB8624),
                        Color(0xFFFFFFFF),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: fs.w(115),
                  height: fs.w(116),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2E363C),
                  ),
                ),
                Container(
                  width: fs.w(70),
                  height: fs.w(70),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFB8624),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFB8624).withValues(alpha: 0.6),
                        blurRadius: 50,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: fs.w(42),
                  height: fs.w(42),
                  child: SvgPicture.asset(
                    'assets/images/Microphone.svg',
                    width: fs.w(42),
                    height: fs.w(42),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: fs.h(20)),
      ],
    );
  }
}

class WavePainter extends CustomPainter {
  const WavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF2F3641),
          Color(0xFF2F3741),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF2F3641),
          Color(0xFF2F3741),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height);

    final controlPointY = size.height * 0.3;
    final midPointY = size.height * 0.5;

    path.quadraticBezierTo(
      size.width * 0.25,
      controlPointY,
      size.width * 0.5,
      midPointY,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.7,
      size.width,
      size.height,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, fillPaint);

    final strokePath = Path();
    strokePath.moveTo(0, size.height);
    strokePath.quadraticBezierTo(
      size.width * 0.25,
      controlPointY,
      size.width * 0.5,
      midPointY,
    );
    strokePath.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.7,
      size.width,
      size.height,
    );

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
