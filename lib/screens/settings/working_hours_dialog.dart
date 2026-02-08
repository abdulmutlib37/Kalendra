part of '../settings.dart';

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
      insetPadding: EdgeInsets.symmetric(horizontal: fs.w(16)),
      child: Container(
        width: fs.w(343),
        constraints: BoxConstraints(
          maxWidth: fs.w(343),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(fs.r(20)),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(fs.w(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Working Hours',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fs.sp(20),
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Inter',
                        height: 1.2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: fs.w(24),
                        height: fs.w(24),
                        child: Icon(
                          Icons.close,
                          size: fs.w(24),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fs.sp(14),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: fs.h(8)),
                    GestureDetector(
                      onTap: () => _selectTime(true),
                      child: Container(
                        width: fs.w(295),
                        constraints: BoxConstraints(
                          maxWidth: fs.w(295),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: fs.w(16),
                          vertical: fs.h(16),
                        ),
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
                                    ? Colors.black.withOpacity(0.55)
                                    : Colors.black,
                                fontSize: fs.sp(16),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black.withOpacity(0.6),
                              size: fs.w(24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: fs.h(16)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'End',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fs.sp(14),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: fs.h(8)),
                    GestureDetector(
                      onTap: () => _selectTime(false),
                      child: Container(
                        width: fs.w(295),
                        constraints: BoxConstraints(
                          maxWidth: fs.w(295),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: fs.w(16),
                          vertical: fs.h(16),
                        ),
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
                                    ? Colors.black.withOpacity(0.55)
                                    : Colors.black,
                                fontSize: fs.sp(16),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black.withOpacity(0.6),
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
                padding: EdgeInsets.all(fs.w(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: fs.h(16)),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(fs.r(12)),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: const Color(0xFFFB8624),
                                fontSize: fs.sp(15),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: fs.w(10)),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await _saveTimes();
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: fs.h(16)),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFB8624),
                            borderRadius: BorderRadius.circular(fs.r(12)),
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: fs.sp(15),
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
      ),
    );
  }
}
