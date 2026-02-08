import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/figma_scale.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final double width;
  final double height;
  final double calendarSize;
  final double voiceSize;
  final double chatSize;
  final VoidCallback onCalendarPressed;
  final VoidCallback onVoicePressed;
  final VoidCallback onChatPressed;

  const HomeBottomNavigationBar({
    super.key,
    required this.width,
    required this.height,
    required this.calendarSize,
    required this.voiceSize,
    required this.chatSize,
    required this.onCalendarPressed,
    required this.onVoicePressed,
    required this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: fs.h(20),
        left: (fs.screenW - width) / 2,
        right: (fs.screenW - width) / 2,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF4A5661),
          borderRadius: BorderRadius.circular(fs.r(50)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.15),
              Colors.white.withValues(alpha: 0.0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: onCalendarPressed,
              child: SvgPicture.asset(
                'assets/images/calendardots.svg',
                width: calendarSize,
                height: calendarSize,
                fit: BoxFit.contain,
              ),
            ),
            GestureDetector(
              onTap: onVoicePressed,
              child: Container(
                width: voiceSize,
                height: voiceSize,
                decoration: const BoxDecoration(
                  color: Color(0xFFFB8624),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/voice.svg',
                    width: voiceSize * 0.5,
                    height: voiceSize * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onChatPressed,
              child: SvgPicture.asset(
                'assets/images/chat.svg',
                width: chatSize,
                height: chatSize,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
