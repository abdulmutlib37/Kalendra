import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/figma_scale.dart';

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
                          _showCalendarColorModal(context);
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

class _DefaultCalendarDialog extends StatefulWidget {
  const _DefaultCalendarDialog();

  @override
  State<_DefaultCalendarDialog> createState() => _DefaultCalendarDialogState();
}

class _DefaultCalendarDialogState extends State<_DefaultCalendarDialog> {
  String selectedCalendar = 'google';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSelectedCalendar();
  }

  Future<void> _loadSelectedCalendar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCalendar = prefs.getString('default_calendar') ?? 'google';
      isLoading = false;
    });
  }

  Future<void> _saveSelectedCalendar(String calendar) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('default_calendar', calendar);
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: fs.w(44)),
      child: Container(
        width: fs.w(343),
        height: fs.h(304),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(fs.r(20)),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(fs.w(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Default Calendar',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(24),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: fs.w(28),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
              child: _buildCalendarOption(
                name: 'Outlook',
                iconPath: 'assets/images/outlook.png',
                accountType: 'Work',
                isSelected: selectedCalendar == 'outlook',
                onTap: () {
                  setState(() => selectedCalendar = 'outlook');
                  _saveSelectedCalendar('outlook');
                },
              ),
            ),
            SizedBox(height: fs.h(16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
              child: _buildCalendarOption(
                name: 'Google',
                iconPath: 'assets/images/google_calendar.png',
                accountType: 'Personal',
                isSelected: selectedCalendar == 'google',
                onTap: () {
                  setState(() => selectedCalendar = 'google');
                  _saveSelectedCalendar('google');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarOption({
    required String name,
    required String iconPath,
    required String accountType,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final fs = FigmaScale.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(fs.w(16)),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(fs.r(12)),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFB8624)
                : Colors.black.withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: fs.w(24),
              height: fs.w(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFB8624)
                      : Colors.black.withOpacity(0.2),
                  width: 2,
                ),
                color: isSelected ? const Color(0xFFFB8624) : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: fs.w(16),
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: fs.w(16)),
            Image.asset(
              iconPath,
              width: fs.w(40),
              height: fs.w(40),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: fs.w(40),
                  height: fs.w(40),
                  decoration: BoxDecoration(
                    color: name == 'Outlook'
                        ? const Color(0xFF0078D4)
                        : const Color(0xFF4285F4),
                    borderRadius: BorderRadius.circular(fs.r(8)),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: fs.w(24),
                  ),
                );
              },
            ),
            SizedBox(width: fs.w(16)),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: fs.sp(18),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Icon(
              Icons.link,
              color: const Color(0xFF00CA48),
              size: fs.w(20),
            ),
            SizedBox(width: fs.w(8)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: fs.w(12),
                vertical: fs.h(6),
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(fs.r(8)),
                border: Border.all(
                  color: Colors.black.withOpacity(0.12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    accountType,
                    style: TextStyle(
                      color: Colors.red.withOpacity(0.85),
                      fontSize: fs.sp(14),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(width: fs.w(4)),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: fs.w(16),
                    color: Colors.red.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarColorDialog extends StatefulWidget {
  const _CalendarColorDialog();

  @override
  State<_CalendarColorDialog> createState() => _CalendarColorDialogState();
}

class _CalendarColorDialogState extends State<_CalendarColorDialog> {
  String googleSelectedColor = 'indigo/500';
  String outlookSelectedColor = 'green/400';
  bool isLoading = true;

  final List<Map<String, dynamic>> colors = [
    {'name': 'red/500', 'color': Color(0xFFEF4444)},
    {'name': 'orange/500', 'color': Color(0xFFF97316)},
    {'name': 'yellow/400', 'color': Color(0xFFFBBF24)},
    {'name': 'green/400', 'color': Color(0xFF4ADE80)},
    {'name': 'teal/400', 'color': Color(0xFF2DD4BF)},
    {'name': 'blue/500', 'color': Color(0xFF3B82F6)},
    {'name': 'indigo/500', 'color': Color(0xFF6366F1)},
    {'name': 'pink/500', 'color': Color(0xFFEC4899)},
    {'name': 'rose/500', 'color': Color(0xFFF43F5E)},
    {'name': 'fuchsia/500', 'color': Color(0xFFD946EF)},
    {'name': 'violet/500', 'color': Color(0xFF8B5CF6)},
    {'name': 'lightBlue/500', 'color': Color(0xFF06B6D4)},
    {'name': 'emerald/500', 'color': Color(0xFF10B981)},
    {'name': 'lime/500', 'color': Color(0xFF84CC16)},
  ];

  @override
  void initState() {
    super.initState();
    _loadColors();
  }

  Future<void> _loadColors() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      googleSelectedColor =
          prefs.getString('google_calendar_color') ?? 'indigo/500';
      outlookSelectedColor =
          prefs.getString('outlook_calendar_color') ?? 'green/400';
      isLoading = false;
    });
  }

  Future<void> _saveColor(String key, String colorName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, colorName);
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: fs.w(44)),
      child: Container(
        width: fs.w(343),
        height: fs.h(363),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(fs.r(20)),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(fs.w(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Calendar Color',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(24),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: fs.w(28),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Text(
                'Google',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: fs.sp(18),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: fs.h(12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Wrap(
                spacing: fs.w(12),
                runSpacing: fs.h(12),
                children: colors.map((colorData) {
                  final isSelected = googleSelectedColor == colorData['name'];
                  return _buildColorCircle(
                    color: colorData['color'],
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => googleSelectedColor = colorData['name']);
                      _saveColor('google_calendar_color', colorData['name']);
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: fs.h(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Text(
                'Outlook',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: fs.sp(18),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: fs.h(12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Wrap(
                spacing: fs.w(12),
                runSpacing: fs.h(12),
                children: colors.map((colorData) {
                  final isSelected = outlookSelectedColor == colorData['name'];
                  return _buildColorCircle(
                    color: colorData['color'],
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => outlookSelectedColor = colorData['name']);
                      _saveColor('outlook_calendar_color', colorData['name']);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorCircle({
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final fs = FigmaScale.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fs.w(40),
        height: fs.w(40),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Colors.red.withOpacity(0.9),
                  width: 3,
                )
              : null,
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: fs.w(24),
              )
            : null,
      ),
    );
  }
}

class _BlurredDialogBackdrop extends StatelessWidget {
  final Widget child;

  const _BlurredDialogBackdrop({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.20),
          ),
        ),
        Center(child: child),
      ],
    );
  }
}

class _WorkingHoursDialog extends StatefulWidget {
  const _WorkingHoursDialog();

  @override
  State<_WorkingHoursDialog> createState() => _WorkingHoursDialogState();
}

class _WorkingHoursDialogState extends State<_WorkingHoursDialog> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedTimes();
  }

  Future<void> _loadSavedTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final startHour = prefs.getInt('wh_start_hour');
    final startMinute = prefs.getInt('wh_start_minute');
    final endHour = prefs.getInt('wh_end_hour');
    final endMinute = prefs.getInt('wh_end_minute');

    setState(() {
      if (startHour != null && startMinute != null) {
        startTime = TimeOfDay(hour: startHour, minute: startMinute);
      }
      if (endHour != null && endMinute != null) {
        endTime = TimeOfDay(hour: endHour, minute: endMinute);
      }
      isLoading = false;
    });
  }

  Future<void> _saveTimes() async {
    if (startTime != null && endTime != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('wh_start_hour', startTime!.hour);
      await prefs.setInt('wh_start_minute', startTime!.minute);
      await prefs.setInt('wh_end_hour', endTime!.hour);
      await prefs.setInt('wh_end_minute', endTime!.minute);
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: (isStart ? startTime : endTime) ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFB8624),
              onSurface: Colors.white,
              surface: Color(0xFF2E363C),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'Select hours';
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: fs.w(44)),
      child: Container(
        width: fs.w(343),
        height: fs.h(357),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(fs.r(20)),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(fs.w(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Working Hours',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(24),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: fs.w(28),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(16),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: fs.h(8)),
                  GestureDetector(
                    onTap: () => _selectTime(true),
                    child: Container(
                      width: double.infinity,
                      height: fs.h(50),
                      padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(fs.r(12)),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(startTime),
                            style: TextStyle(
                              color: startTime == null
                                  ? Colors.red.withOpacity(0.55)
                                  : Colors.red,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.red.withOpacity(0.6),
                            size: fs.w(24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: fs.h(24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(16),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: fs.h(8)),
                  GestureDetector(
                    onTap: () => _selectTime(false),
                    child: Container(
                      width: double.infinity,
                      height: fs.h(50),
                      padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(fs.r(12)),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(endTime),
                            style: TextStyle(
                              color: endTime == null
                                  ? Colors.red.withOpacity(0.55)
                                  : Colors.red,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.red.withOpacity(0.6),
                            size: fs.w(24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(fs.w(24)),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: fs.h(50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(fs.r(12)),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.35),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: fs.w(16)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await _saveTimes();
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: fs.h(50),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(fs.r(12)),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalWorkingHoursDialog extends StatefulWidget {
  const _PersonalWorkingHoursDialog();

  @override
  State<_PersonalWorkingHoursDialog> createState() =>
      _PersonalWorkingHoursDialogState();
}

class _PersonalWorkingHoursDialogState extends State<_PersonalWorkingHoursDialog> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedTimes();
  }

  Future<void> _loadSavedTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final startHour = prefs.getInt('pwh_start_hour');
    final startMinute = prefs.getInt('pwh_start_minute');
    final endHour = prefs.getInt('pwh_end_hour');
    final endMinute = prefs.getInt('pwh_end_minute');

    setState(() {
      if (startHour != null && startMinute != null) {
        startTime = TimeOfDay(hour: startHour, minute: startMinute);
      }
      if (endHour != null && endMinute != null) {
        endTime = TimeOfDay(hour: endHour, minute: endMinute);
      }
      isLoading = false;
    });
  }

  Future<void> _saveTimes() async {
    if (startTime != null && endTime != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('pwh_start_hour', startTime!.hour);
      await prefs.setInt('pwh_start_minute', startTime!.minute);
      await prefs.setInt('pwh_end_hour', endTime!.hour);
      await prefs.setInt('pwh_end_minute', endTime!.minute);
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: (isStart ? startTime : endTime) ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFB8624),
              onSurface: Colors.white,
              surface: Color(0xFF2E363C),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'Select hours';
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: fs.w(44)),
      child: Container(
        width: fs.w(343),
        height: fs.h(357),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(fs.r(20)),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(fs.w(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Personal Working Hours',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: fs.sp(22),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  SizedBox(width: fs.w(8)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: fs.w(28),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(16),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: fs.h(8)),
                  GestureDetector(
                    onTap: () => _selectTime(true),
                    child: Container(
                      width: double.infinity,
                      height: fs.h(50),
                      padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(fs.r(12)),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(startTime),
                            style: TextStyle(
                              color: startTime == null
                                  ? Colors.red.withOpacity(0.55)
                                  : Colors.red,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.red.withOpacity(0.6),
                            size: fs.w(24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: fs.h(24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(16),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: fs.h(8)),
                  GestureDetector(
                    onTap: () => _selectTime(false),
                    child: Container(
                      width: double.infinity,
                      height: fs.h(50),
                      padding: EdgeInsets.symmetric(horizontal: fs.w(16)),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(fs.r(12)),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(endTime),
                            style: TextStyle(
                              color: endTime == null
                                  ? Colors.red.withOpacity(0.55)
                                  : Colors.red,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.red.withOpacity(0.6),
                            size: fs.w(24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(fs.w(24)),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: fs.h(50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(fs.r(12)),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.35),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: fs.w(16)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await _saveTimes();
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: fs.h(50),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(fs.r(12)),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsDialog extends StatefulWidget {
  const _NotificationsDialog();

  @override
  State<_NotificationsDialog> createState() => _NotificationsDialogState();
}

class _NotificationsDialogState extends State<_NotificationsDialog> {
  bool generalNotification = true;
  bool sound = false;
  bool vibrate = true;
  bool tasks = false;
  bool meetingReminders = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      generalNotification = prefs.getBool('notif_general') ?? true;
      sound = prefs.getBool('notif_sound') ?? false;
      vibrate = prefs.getBool('notif_vibrate') ?? true;
      tasks = prefs.getBool('notif_tasks') ?? false;
      meetingReminders = prefs.getBool('notif_meeting') ?? true;
      isLoading = false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: fs.w(44)),
      child: Container(
        width: fs.w(343),
        height: fs.h(349),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(fs.r(20)),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(fs.w(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fs.sp(24),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: fs.w(28),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Text(
                'Common',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: fs.sp(18),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: fs.h(12)),
            _buildToggleItem(
              title: 'General Notification',
              value: generalNotification,
              onChanged: (value) {
                setState(() => generalNotification = value);
                _saveSetting('notif_general', value);
              },
            ),
            _buildToggleItem(
              title: 'Sound',
              value: sound,
              onChanged: (value) {
                setState(() => sound = value);
                _saveSetting('notif_sound', value);
              },
            ),
            _buildToggleItem(
              title: 'Vibrate',
              value: vibrate,
              onChanged: (value) {
                setState(() => vibrate = value);
                _saveSetting('notif_vibrate', value);
              },
            ),
            SizedBox(height: fs.h(16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
              child: Text(
                'Others',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: fs.sp(18),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: fs.h(12)),
            _buildToggleItem(
              title: 'Tasks',
              value: tasks,
              onChanged: (value) {
                setState(() => tasks = value);
                _saveSetting('notif_tasks', value);
              },
            ),
            _buildToggleItem(
              title: 'Meeting Reminders',
              value: meetingReminders,
              onChanged: (value) {
                setState(() => meetingReminders = value);
                _saveSetting('notif_meeting', value);
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isLast = false,
  }) {
    final fs = FigmaScale.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: fs.w(24),
        right: fs.w(24),
        bottom: isLast ? 0 : fs.h(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.red,
              fontSize: fs.sp(16),
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: fs.w(51),
              height: fs.h(31),
              decoration: BoxDecoration(
                color:
                    value ? const Color(0xFFFB8624) : const Color(0xFFE0E0E0),
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
}
