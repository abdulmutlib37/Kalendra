import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/figma_scale.dart';

part 'settings/blurred_dialog_backdrop.dart';
part 'settings/default_calendar_dialog.dart';
part 'settings/working_hours_dialog.dart';
part 'settings/personal_working_hours_dialog.dart';
part 'settings/notifications_dialog.dart';
part 'settings/calendar_color_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool autoConfirmation = true;

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF2E363C),
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
          Column(
            children: [
              SafeArea(
                child: Container(
                  height: fs.h(60),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFF484848),
                        width: 1,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: fs.w(8)),
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/arrow.svg',
                          width: fs.w(24),
                          height: fs.w(24),
                        ),
                        onPressed: () => Navigator.maybePop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: fs.w(8)),
                      SvgPicture.asset(
                        'assets/images/setting.svg',
                        height: fs.h(28),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(fs.w(16)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(fs.r(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleItem(
                        icon: Icons.verified_outlined,
                        title: 'Auto Confirmation',
                        value: autoConfirmation,
                        onChanged: (value) {
                          setState(() {
                            autoConfirmation = value;
                          });
                        },
                      ),
                      _buildDivider(),
                      _buildNavigationItem(
                        icon: Icons.calendar_today_outlined,
                        title: 'Default Calendar',
                        onTap: () {
                          _showDefaultCalendarModal(context);
                        },
                      ),
                      _buildDivider(),
                      _buildNavigationItem(
                        icon: Icons.access_time,
                        title: 'Working Hours',
                        onTap: () {
                          _showWorkingHoursModal(context);
                        },
                      ),
                      _buildDivider(),
                      _buildNavigationItem(
                        icon: Icons.access_time_outlined,
                        title: 'Personal Working Hours',
                        onTap: () {
                          _showPersonalWorkingHoursModal(context);
                        },
                      ),
                      _buildDivider(),
                      _buildNavigationItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        onTap: () {
                          _showNotificationsModal(context);
                        },
                      ),
                      _buildDivider(),
                      _buildNavigationItem(
                        icon: Icons.palette_outlined,
                        title: 'Connected Calendar Color',
                        onTap: () {
                          // Will add popup later as per user request
                        },
                      ),
                      _buildDivider(),
                      _buildNavigationItem(
                        icon: Icons.chat_outlined,
                        title: 'Clear AI Chat',
                        onTap: () {},
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    final fs = FigmaScale.of(context);
    return Container(
      height: fs.h(1),
      margin: EdgeInsets.symmetric(horizontal: fs.w(16)),
      color: const Color(0xFFA3A3A3),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final fs = FigmaScale.of(context);
    return Container(
      width: double.infinity,
      height: fs.h(80),
      padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
      child: Row(
        children: [
          Container(
            width: fs.w(40),
            height: fs.w(40),
            decoration: BoxDecoration(
              color: const Color(0xFFFB8624),
              borderRadius: BorderRadius.circular(fs.r(8)),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: fs.w(24),
            ),
          ),
          SizedBox(width: fs.w(16)),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: fs.sp(18),
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: fs.w(51),
              height: fs.h(31),
              decoration: BoxDecoration(
                color: value
                    ? const Color(0xFF00CA48)
                    : const Color(0xFFFFFFFF).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(fs.r(20)),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: value ? fs.w(23) : fs.w(3),
                    top: fs.h(3),
                    child: Container(
                      width: fs.w(25),
                      height: fs.w(25),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    final fs = FigmaScale.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: fs.h(80),
        padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
        child: Row(
          children: [
            Container(
              width: fs.w(40),
              height: fs.w(40),
              decoration: BoxDecoration(
                color: const Color(0xFFFB8624),
                borderRadius: BorderRadius.circular(fs.r(8)),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: fs.w(24),
              ),
            ),
            SizedBox(width: fs.w(16)),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fs.sp(18),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFFA3A3A3),
              size: fs.w(28),
            ),
          ],
        ),
      ),
    );
  }

  void _showWorkingHoursModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => const _BlurredDialogBackdrop(
        child: _WorkingHoursDialog(),
      ),
    );
  }

  void _showPersonalWorkingHoursModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => const _BlurredDialogBackdrop(
        child: _PersonalWorkingHoursDialog(),
      ),
    );
  }

  void _showNotificationsModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => const _BlurredDialogBackdrop(
        child: _NotificationsDialog(),
      ),
    );
  }

  void _showDefaultCalendarModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => const _BlurredDialogBackdrop(
        child: _DefaultCalendarDialog(),
      ),
    );
  }

  void _showCalendarColorModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => const _BlurredDialogBackdrop(
        child: _CalendarColorDialog(),
      ),
    );
  }
}
