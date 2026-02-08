part of '../settings.dart';

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
