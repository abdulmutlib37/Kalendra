part of '../settings.dart';

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
                    SizedBox(
                      width: fs.w(263),
                      child: Text(
                        'Default Calendar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fs.sp(20),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Inter',
                          height: 1.2,
                        ),
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
                child: _buildCalendarOption(
                  name: 'Outlook',
                  logoPath: 'assets/images/ologo.svg',
                  textPath: 'assets/images/Outlookk.svg',
                  isSelected: selectedCalendar == 'outlook',
                  onTap: () {
                    setState(() => selectedCalendar = 'outlook');
                    _saveSelectedCalendar('outlook');
                  },
                ),
              ),
              SizedBox(height: fs.h(16)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
                child: _buildCalendarOption(
                  name: 'Google',
                  logoPath: 'assets/images/ggoogle.svg',
                  textPath: null,
                  isSelected: selectedCalendar == 'google',
                  onTap: () {
                    setState(() => selectedCalendar = 'google');
                    _saveSelectedCalendar('google');
                  },
                ),
              ),
              SizedBox(height: fs.h(24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarOption({
    required String name,
    required String logoPath,
    String? textPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final fs = FigmaScale.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fs.w(295),
        constraints: BoxConstraints(
          maxWidth: fs.w(295),
        ),
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
          mainAxisSize: MainAxisSize.min,
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
            Container(
              width: fs.w(32),
              height: fs.w(32),
              decoration: BoxDecoration(
                color: name == 'Outlook'
                    ? const Color(0xFF0078D4)
                    : const Color(0xFF4285F4),
                borderRadius: BorderRadius.circular(fs.r(8)),
              ),
              child: Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: fs.w(18),
              ),
            ),
            SizedBox(width: fs.w(12)),
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: fs.sp(16),
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
