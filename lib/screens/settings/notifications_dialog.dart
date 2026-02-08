part of '../settings.dart';

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
                      'Notifications',
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
                    SizedBox(
                      width: fs.w(72),
                      height: fs.h(24),
                      child: Text(
                        'Common',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fs.sp(16),
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
                    SizedBox(height: fs.h(12)),
                    _buildToggleItem(
                      title: 'Sound',
                      value: sound,
                      onChanged: (value) {
                        setState(() => sound = value);
                        _saveSetting('notif_sound', value);
                      },
                    ),
                    SizedBox(height: fs.h(12)),
                    _buildToggleItem(
                      title: 'Vibrate',
                      value: vibrate,
                      onChanged: (value) {
                        setState(() => vibrate = value);
                        _saveSetting('notif_vibrate', value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: fs.h(24)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: fs.w(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: fs.w(55),
                      height: fs.h(24),
                      child: Text(
                        'Others',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fs.sp(16),
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
                    SizedBox(height: fs.h(12)),
                    _buildToggleItem(
                      title: 'Meeting Reminders',
                      value: meetingReminders,
                      onChanged: (value) {
                        setState(() => meetingReminders = value);
                        _saveSetting('notif_meeting', value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: fs.h(24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final fs = FigmaScale.of(context);
    return SizedBox(
      width: fs.w(295),
      height: fs.h(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: fs.w(207.2),
            height: fs.h(24),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: fs.sp(16),
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: fs.w(34.5),
              height: fs.h(20),
              decoration: BoxDecoration(
                color:
                    value ? const Color(0xFFFB8624) : const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(fs.r(20)),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: value ? fs.w(16.5) : fs.w(2),
                    top: fs.h(2),
                    child: Container(
                      width: fs.w(16),
                      height: fs.w(16),
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
