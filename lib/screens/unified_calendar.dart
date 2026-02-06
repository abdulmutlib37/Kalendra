
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/figma_scale.dart';

class UnifiedCalendarScreen extends StatefulWidget {
  const UnifiedCalendarScreen({super.key});

  @override
  State<UnifiedCalendarScreen> createState() => _UnifiedCalendarScreenState();
}

class _UnifiedCalendarScreenState extends State<UnifiedCalendarScreen> {
  DateTime selectedMonth = DateTime(2025, 12);
  DateTime? selectedDate;
  String selectedView = 'Month';
  String _selectedSourceFilter = 'Both';

  final List<CalendarEvent> upcomingEvents = [
    CalendarEvent(
      title: 'Weekly meeting with PM',
      startDate: DateTime(2025, 12, 1),
      endDate: DateTime(2025, 12, 1),
      source: 'Google',
    ),
    CalendarEvent(
      title: 'Read a book for at least\n30 minutes.',
      startDate: DateTime(2025, 12, 1, 13, 0),
      endDate: DateTime(2025, 12, 1),
      source: 'Outlook',
    ),
    CalendarEvent(
      title: 'Watch Demon Slayer on\nNetflix',
      startDate: DateTime(2025, 12, 1),
      endDate: DateTime(2025, 12, 1),
      source: 'Google',
    ),
    CalendarEvent(
      title: 'Read a book for at least\n30 minutes.',
      startDate: DateTime(2025, 12, 1, 19, 0),
      endDate: DateTime(2025, 12, 1),
      source: 'Outlook',
    ),
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = DateTime(now.year, now.month);
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF2E363C),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF2E363C),
          ),
          Positioned(
            right: -fs.w(50),
            top: -fs.h(50),
            child: Container(
              width: fs.w(300),
              height: fs.w(300),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFB8624).withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(fs),
                SizedBox(height: fs.h(10)),
                Expanded(flex: 7, child: _buildCalendar()),
                SizedBox(height: fs.h(12)),
                Expanded(flex: 5, child: _buildUpcomingEvents()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(FigmaScale fs) {
    return Container(
      height: fs.h(60),
      padding: EdgeInsets.symmetric(horizontal: fs.w(8)),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF484848),
            width: 1,
          ),
        ),
      ),
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
          SizedBox(
            width: fs.w(179),
            height: fs.h(28),
            child: SvgPicture.asset(
              'assets/images/cal.svg',
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          SourceDropdownButton(
            onSelected: (value) {
              setState(() {
                _selectedSourceFilter = value;
              });
            },
          ),
          SizedBox(width: fs.w(12)),
          GestureDetector(
            onTap: () async {
              final result = await _openFiltersSheet(context);
              if (!mounted || result == null) return;
              setState(() {
                _selectedSourceFilter = result.selectedSource;
              });
            },
            child: SvgPicture.asset(
              'assets/images/filter.svg',
              height: fs.h(28),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: fs.w(8)),
        ],
      ),
    );
  }

  Future<CalendarFiltersResult?> _openFiltersSheet(BuildContext context) {
    return showModalBottomSheet<CalendarFiltersResult>(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.85),
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.20),
              ),
            ),
            CalendarFiltersSheet(
              initialSource: _selectedSourceFilter,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: FigmaScale.of(context).w(20)),
      padding: EdgeInsets.fromLTRB(
        FigmaScale.of(context).w(16),
        FigmaScale.of(context).h(12),
        FigmaScale.of(context).w(16),
        FigmaScale.of(context).h(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(FigmaScale.of(context).r(16)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildViewToggle('Day'),
              SizedBox(width: FigmaScale.of(context).w(8)),
              _buildViewToggle('Week'),
              SizedBox(width: FigmaScale.of(context).w(8)),
              _buildViewToggle('Month'),
            ],
          ),
          SizedBox(height: FigmaScale.of(context).h(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  setState(() {
                    selectedMonth = DateTime(
                      selectedMonth.year,
                      selectedMonth.month - 1,
                    );
                  });
                },
              ),
              Text(
                '${_getMonthName(selectedMonth.month)} ${selectedMonth.year}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  setState(() {
                    selectedMonth = DateTime(
                      selectedMonth.year,
                      selectedMonth.month + 1,
                    );
                  });
                },
              ),
            ],
          ),
          SizedBox(height: FigmaScale.of(context).h(12)),
          Expanded(child: _buildCalendarGrid()),
        ],
      ),
    );
  }

  Widget _buildViewToggle(String view) {
    final isSelected = selectedView == view;
    final fs = FigmaScale.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedView = view;
          });
        },
        child: Container(
          height: fs.h(44),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFF8A3D)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(fs.r(22)),
          ),
          child: Center(
            child: Text(
              view,
              style: TextStyle(
                color: Colors.white,
                fontSize: fs.sp(16),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final fs = FigmaScale.of(context);
    final daysInWeek = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
    final startIndex = firstDayOfMonth.weekday - 1;
    final prevMonthDays = DateTime(selectedMonth.year, selectedMonth.month, 0).day;

    final weeksInMonth = ((startIndex + daysInMonth) / 7).ceil().clamp(5, 6);
    final totalCells = weeksInMonth * 7;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: daysInWeek
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: fs.sp(12),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: fs.h(12)),
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              final int dayNumber;
              final bool isCurrentMonth;

              if (index < startIndex) {
                dayNumber = prevMonthDays - (startIndex - 1 - index);
                isCurrentMonth = false;
              } else if (index < startIndex + daysInMonth) {
                dayNumber = index - startIndex + 1;
                isCurrentMonth = true;
              } else {
                dayNumber = index - (startIndex + daysInMonth) + 1;
                isCurrentMonth = false;
              }

              final currentDate = isCurrentMonth
                  ? DateTime(selectedMonth.year, selectedMonth.month, dayNumber)
                  : null;

              final isSelected = currentDate != null &&
                  selectedDate != null &&
                  selectedDate!.year == currentDate.year &&
                  selectedDate!.month == currentDate.month &&
                  selectedDate!.day == currentDate.day;

              return GestureDetector(
                onTap: currentDate == null
                    ? null
                    : () {
                        setState(() {
                          selectedDate = currentDate;
                        });
                      },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFF8A3D)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Center(
                    child: Text(
                      dayNumber.toString(),
                      style: TextStyle(
                        color: isCurrentMonth
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        fontSize: fs.sp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEvents() {
    final fs = FigmaScale.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Events',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
              Row(
                children: [
                  SourceDropdownButton(
                    onSelected: (value) {
                      setState(() {
                        _selectedSourceFilter = value;
                      });
                    },
                  ),
                  SizedBox(width: fs.w(8)),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/images/pluss.svg',
                      height: fs.h(28),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: fs.h(16)),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
            itemCount: upcomingEvents.length,
            itemBuilder: (context, index) {
              return _buildEventCard(upcomingEvents[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(CalendarEvent event) {
    return CalendarEventCard(event: event);
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

class CalendarEvent {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String source;

  CalendarEvent({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.source,
  });

  String getFormattedDate() {
    if (startDate.hour == 0 && startDate.minute == 0) {
      return '${_formatDate(startDate)} - ${_formatDate(endDate)}';
    } else {
      return '${startDate.hour.toString().padLeft(2, '0')}:${startDate.minute.toString().padLeft(2, '0')} | ${_formatDate(startDate)}';
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class SourceDropdownButton extends StatelessWidget {
  final ValueChanged<String> onSelected;
  final double? buttonWidth;
  final double? buttonHeight;
  final double iconHeight;

  const SourceDropdownButton({
    super.key,
    required this.onSelected,
    this.buttonWidth,
    this.buttonHeight,
    this.iconHeight = 28,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedWidth = buttonWidth ?? 103;
    final resolvedHeight = buttonHeight ?? 30;

    return PopupMenuButton<String>(
      onSelected: onSelected,
      offset: const Offset(0, 44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFF2E363C),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Both',
          child: SvgPicture.asset(
            'assets/images/both.svg',
            height: 26,
            fit: BoxFit.contain,
          ),
        ),
        PopupMenuItem(
          value: 'Google',
          child: SvgPicture.asset(
            'assets/images/gooogle.svg',
            height: 26,
            fit: BoxFit.contain,
          ),
        ),
        PopupMenuItem(
          value: 'Outlook',
          child: SvgPicture.asset(
            'assets/images/outlooks.svg',
            height: 26,
            fit: BoxFit.contain,
          ),
        ),
      ],
      child: SizedBox(
        width: resolvedWidth,
        height: resolvedHeight,
        child: SvgPicture.asset(
          'assets/images/both.svg',
          height: iconHeight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _BothButton extends StatelessWidget {
  final double height;

  const _BothButton({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(height / 2),
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/google.svg',
            height: height * 0.55,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 6),
          SvgPicture.asset(
            'assets/images/outlook.svg',
            height: height * 0.55,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: height * 0.75,
          ),
        ],
      ),
    );
  }
}

class _BothMenuItem extends StatelessWidget {
  final double height;

  const _BothMenuItem({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/google.svg',
            height: height,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            'assets/images/outlook.svg',
            height: height,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class CalendarFiltersResult {
  final String selectedSource;
  final String? selectedPeriod;
  final int? startDate;
  final int? endDate;
  final int currentMonth;
  final int currentYear;

  const CalendarFiltersResult({
    required this.selectedSource,
    required this.selectedPeriod,
    required this.startDate,
    required this.endDate,
    required this.currentMonth,
    required this.currentYear,
  });
}

class CalendarFiltersSheet extends StatefulWidget {
  final String initialSource;

  const CalendarFiltersSheet({super.key, required this.initialSource});

  @override
  State<CalendarFiltersSheet> createState() => _CalendarFiltersSheetState();
}

class _CalendarFiltersSheetState extends State<CalendarFiltersSheet> {
  late String selectedSource;
  String? selectedPeriod;
  int? startDate;
  int? endDate;
  int currentMonth = 11;
  int currentYear = 2025;
  int? lastTappedDate;
  DateTime? lastTapTime;

  final List<String> months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final List<String> dayLabels = const [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN'
  ];

  @override
  void initState() {
    super.initState();
    selectedSource = widget.initialSource.toLowerCase();
    if (selectedSource != 'both' &&
        selectedSource != 'google' &&
        selectedSource != 'outlook') {
      selectedSource = 'both';
    }
    startDate = 1;
    endDate = 8;
  }

  void selectSource(String source) {
    setState(() {
      selectedSource = source;
    });
  }

  void selectPeriod(String period) {
    setState(() {
      selectedPeriod = period;
    });
  }

  void selectDate(int date) {
    setState(() {
      final now = DateTime.now();

      if (lastTappedDate == date &&
          lastTapTime != null &&
          now.difference(lastTapTime!).inMilliseconds < 500) {
        if (startDate == date) {
          startDate = null;
          endDate = null;
        } else if (endDate == date) {
          endDate = null;
        }
        lastTappedDate = null;
        lastTapTime = null;
        return;
      }

      lastTappedDate = date;
      lastTapTime = now;

      if (startDate == null) {
        startDate = date;
        endDate = null;
      } else if (endDate == null) {
        if (date > startDate!) {
          endDate = date;
        } else if (date < startDate!) {
          endDate = startDate;
          startDate = date;
        }
      } else {
        startDate = date;
        endDate = null;
      }
    });
  }

  void previousMonth() {
    setState(() {
      currentMonth--;
      if (currentMonth < 0) {
        currentMonth = 11;
        currentYear--;
      }
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth++;
      if (currentMonth > 11) {
        currentMonth = 0;
        currentYear++;
      }
    });
  }

  bool isInRange(int date) {
    if (startDate != null && endDate != null) {
      return date > startDate! && date < endDate!;
    }
    return false;
  }

  String _displaySource(String source) {
    switch (source) {
      case 'google':
        return 'Google';
      case 'outlook':
        return 'Outlook';
      default:
        return 'Both';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final fs = FigmaScale.of(context);

    final desiredHeightFactor = (0.85 / fs.sy).clamp(0.82, 0.95);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: desiredHeightFactor,
            widthFactor: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF4A5C63),
                borderRadius: BorderRadius.circular(fs.r(20)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                    Container(
                      width: fs.w(100),
                      height: fs.h(4),
                      margin: EdgeInsets.only(top: fs.h(10)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(fs.r(2)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(fs.w(20)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: fs.w(20)),
                          const Text(
                            'Filters',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.6,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Calendar Source',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: -0.54,
                                    ),
                                  ),
                                  SizedBox(height: fs.h(12)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildSourceButton(
                                          'both',
                                          _displaySource('both'),
                                          true,
                                        ),
                                      ),
                                      SizedBox(width: fs.w(9)),
                                      Expanded(
                                        child: _buildSourceButton(
                                          'google',
                                          _displaySource('google'),
                                          false,
                                        ),
                                      ),
                                      SizedBox(width: fs.w(9)),
                                      Expanded(
                                        child: _buildSourceButton(
                                          'outlook',
                                          _displaySource('outlook'),
                                          false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: fs.h(24)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Period',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: -0.54,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildPeriodButton(
                                          'day',
                                          'Day',
                                          Icons.calendar_today,
                                        ),
                                      ),
                                      SizedBox(width: fs.w(9)),
                                      Expanded(
                                        child: _buildPeriodButton(
                                          'week',
                                          'Week',
                                          Icons.calendar_view_week,
                                        ),
                                      ),
                                      SizedBox(width: fs.w(9)),
                                      Expanded(
                                        child: _buildPeriodButton(
                                          'month',
                                          'Month',
                                          Icons.calendar_month,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: fs.h(24)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Pick custom date range',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: -0.54,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: fs.h(12)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: fs.w(20)),
                              padding: EdgeInsets.all(fs.w(20)),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(fs.r(16)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: previousMonth,
                                        child: const Icon(
                                          Icons.chevron_left,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                      Text(
                                        '${months[currentMonth]} $currentYear',
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: nextMonth,
                                        child: const Icon(
                                          Icons.chevron_right,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: fs.h(12)),
                                  Row(
                                    children: dayLabels
                                        .map(
                                          (label) => Expanded(
                                            child: Center(
                                              child: Text(
                                                label,
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFA3A3A3),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildCalendarGrid(),
                                ],
                              ),
                            ),
                            SizedBox(height: fs.h(20)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: fs.w(20),
                        vertical: fs.h(16),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: fs.h(60),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                              CalendarFiltersResult(
                                selectedSource: _displaySource(selectedSource),
                                selectedPeriod: selectedPeriod,
                                startDate: startDate,
                                endDate: endDate,
                                currentMonth: currentMonth,
                                currentYear: currentYear,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFB8624),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.6,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSourceButton(String source, String label, bool hasBothIcons) {
    final isActive = selectedSource == source;
    return GestureDetector(
      onTap: () => selectSource(source),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFB8624) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasBothIcons) ...[
              SvgPicture.asset(
                'assets/images/both.svg',
                height: 20,
                fit: BoxFit.contain,
              ),
            ] else if (source == 'google') ...[
              SvgPicture.asset(
                'assets/images/gooogle.svg',
                height: 20,
                fit: BoxFit.contain,
              ),
            ] else if (source == 'outlook') ...[
              SvgPicture.asset(
                'assets/images/outlooks.svg',
                height: 20,
                fit: BoxFit.contain,
              ),
            ],
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period, String label, IconData icon) {
    final isActive = selectedPeriod == period;
    return GestureDetector(
      onTap: () => selectPeriod(period),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFB8624) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(currentYear, currentMonth + 1, 1);
    final daysInMonth = DateTime(currentYear, currentMonth + 2, 0).day;
    final startIndex = firstDayOfMonth.weekday - 1;
    final prevMonthDays = DateTime(currentYear, currentMonth + 1, 0).day;

    final weeksInMonth = ((startIndex + daysInMonth) / 7).ceil().clamp(5, 6);
    final totalCells = weeksInMonth * 7;

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 8.0;
        final cellSize =
            (constraints.maxWidth - (spacing * 6)) / 7.0; // 7 columns
        final gridHeight = (cellSize * weeksInMonth) + (spacing * (weeksInMonth - 1));

        return SizedBox(
          height: gridHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              childAspectRatio: 1,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              final int dayNumber;
              final bool isCurrentMonth;

              if (index < startIndex) {
                dayNumber = prevMonthDays - (startIndex - 1 - index);
                isCurrentMonth = false;
              } else if (index < startIndex + daysInMonth) {
                dayNumber = index - startIndex + 1;
                isCurrentMonth = true;
              } else {
                dayNumber = index - (startIndex + daysInMonth) + 1;
                isCurrentMonth = false;
              }

              final isStart = isCurrentMonth && startDate == dayNumber;
              final isEnd = isCurrentMonth && endDate == dayNumber;
              final inRange = isCurrentMonth && isInRange(dayNumber);

              var backgroundColor = Colors.transparent;
              if (isStart || isEnd) {
                backgroundColor = const Color(0xFFFB8624);
              } else if (inRange) {
                backgroundColor = const Color(0xFFFFF5ED).withOpacity(0.1);
              }

              return GestureDetector(
                onTap: isCurrentMonth ? () => selectDate(dayNumber) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$dayNumber',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isCurrentMonth
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CalendarEventCard extends StatelessWidget {
  final CalendarEvent event;

  const CalendarEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    final isGoogle = event.source == 'Google';
    final borderColor =
        isGoogle ? const Color(0xFFC36135) : const Color(0xFF244CFB);

    return Container(
      margin: EdgeInsets.only(bottom: fs.h(12)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(fs.r(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: fs.r(12),
            offset: Offset(0, fs.h(6)),
          ),
        ],
      ),
      constraints: BoxConstraints(minHeight: fs.h(91)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: fs.w(4),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(fs.r(12)),
                  bottomLeft: Radius.circular(fs.r(12)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(fs.w(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fs.sp(16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          isGoogle
                              ? 'assets/images/google.svg'
                              : 'assets/images/outlook.svg',
                          height: fs.h(24),
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(height: fs.h(8)),
                    CustomPaint(
                      painter: GradientBorderPainter(borderRadius: fs.r(12)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: fs.w(8),
                          vertical: fs.h(4),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(fs.r(12)),
                        ),
                        child: Text(
                          event.getFormattedDate(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: fs.sp(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double borderRadius;

  const GradientBorderPainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final gradient = const LinearGradient(
      colors: [
        Color(0xFF2E363C),
        Color(0xFFFB8624),
      ],
      stops: [0.0, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WeekViewScreen extends StatefulWidget {
  const WeekViewScreen({super.key});

  @override
  State<WeekViewScreen> createState() => _WeekViewScreenState();
}

class _WeekViewScreenState extends State<WeekViewScreen> {
  String selectedView = 'Week';
  String _selectedSourceFilter = 'Both';

  final Map<String, List<CalendarEvent>> weeklyEvents = {
    'This Week (Dec 1 - Dec 7)': [
      CalendarEvent(
        title: 'Weekly meeting with PM',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 1),
        source: 'Google',
      ),
      CalendarEvent(
        title: 'Read a book for at least\n30 minutes.',
        startDate: DateTime(2025, 12, 1, 13, 0),
        endDate: DateTime(2025, 12, 1),
        source: 'Outlook',
      ),
      CalendarEvent(
        title: 'Watch Demon Slayer on\nNetflix',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 1),
        source: 'Google',
      ),
      CalendarEvent(
        title: 'Read a book for at least\n30 minutes.',
        startDate: DateTime(2025, 12, 1, 13, 0),
        endDate: DateTime(2025, 12, 1),
        source: 'Outlook',
      ),
    ],
    'Next Week (Dec 8 - Dec 14)': [
      CalendarEvent(
        title: 'Weekly meeting with PM',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 1),
        source: 'Google',
      ),
      CalendarEvent(
        title: 'Read a book for at least\n30 minutes.',
        startDate: DateTime(2025, 12, 1, 13, 0),
        endDate: DateTime(2025, 12, 1),
        source: 'Outlook',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF2E363C),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF2E363C),
          ),
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFB8624).withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(fs),
                SizedBox(height: fs.h(20)),
                _buildViewToggles(),
                SizedBox(height: fs.h(24)),
                Expanded(
                  child: _buildWeeklyEvents(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(FigmaScale fs) {
    return Container(
      height: fs.h(60),
      padding: EdgeInsets.symmetric(horizontal: fs.w(8)),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF484848),
            width: 1,
          ),
        ),
      ),
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
          SizedBox(
            width: fs.w(179),
            height: fs.h(28),
            child: SvgPicture.asset(
              'assets/images/cal.svg',
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          SourceDropdownButton(
            onSelected: (value) {
              setState(() {
                _selectedSourceFilter = value;
              });
            },
          ),
          SizedBox(width: fs.w(12)),
          GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<CalendarFiltersResult>(
                context: context,
                isScrollControlled: true,
                barrierColor: Colors.black.withOpacity(0.85),
                backgroundColor: Colors.transparent,
                builder: (ctx) {
                  return Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.20),
                        ),
                      ),
                      CalendarFiltersSheet(
                        initialSource: _selectedSourceFilter,
                      ),
                    ],
                  );
                },
              );
              if (!mounted || result == null) return;
              setState(() {
                _selectedSourceFilter = result.selectedSource;
              });
            },
            child: SvgPicture.asset(
              'assets/images/filter.svg',
              height: fs.h(28),
            ),
          ),
          SizedBox(width: fs.w(8)),
        ],
      ),
    );
  }

  Widget _buildViewToggles() {
    final fs = FigmaScale.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fs.w(20)),
      padding: EdgeInsets.all(fs.w(4)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(fs.r(28)),
      ),
      child: Row(
        children: [
          _buildViewToggle('Day'),
          SizedBox(width: fs.w(8)),
          _buildViewToggle('Week'),
          SizedBox(width: fs.w(8)),
          _buildViewToggle('Month'),
        ],
      ),
    );
  }

  Widget _buildViewToggle(String view) {
    final isSelected = selectedView == view;
    final fs = FigmaScale.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedView = view;
          });
        },
        child: Container(
          height: fs.h(48),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF8A3D) : Colors.transparent,
            borderRadius: BorderRadius.circular(fs.r(24)),
          ),
          child: Center(
            child: Text(
              view,
              style: TextStyle(
                color: Colors.white,
                fontSize: fs.sp(16),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyEvents() {
    final fs = FigmaScale.of(context);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
      children: weeklyEvents.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            SizedBox(height: fs.h(16)),
            ...entry.value.map((event) => CalendarEventCard(event: event)),
            SizedBox(height: fs.h(24)),
          ],
        );
      }).toList(),
    );
  }
}
