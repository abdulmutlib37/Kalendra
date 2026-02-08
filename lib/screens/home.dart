import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../routes/app_routes.dart';
import '../utils/figma_scale.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    final now = DateTime.now();
    final dateFormatter = DateFormat('EEEE, d');
    final dayOfMonth = now.day;
    String suffix = 'th';
    if (dayOfMonth == 1 || dayOfMonth == 21 || dayOfMonth == 31) {
      suffix = 'st';
    } else if (dayOfMonth == 2 || dayOfMonth == 22) {
      suffix = 'nd';
    } else if (dayOfMonth == 3 || dayOfMonth == 23) {
      suffix = 'rd';
    }
    final formattedDate =
        '${dateFormatter.format(now)}$suffix ${DateFormat('MMM yyyy').format(now)}';

    final horizontalPadding = fs.w(20);

    final viewAllWidth = fs.w(90);
    final viewAllHeight = fs.h(30);

    final eventCardWidth = fs.w(190.84);
    final eventCardHeight = fs.h(199.43);
    final eventCardSpacing = fs.w(200.39 - 190.84);

    final eventIconSize = fs.w(30.53);
    final eventTitleWidth = fs.w(160.31);
    final eventDateWidth = fs.w(160.31);
    final eventDateHeight = fs.h(14);
    final viewDetailsWidth = fs.w(160.31);
    final viewDetailsHeight = fs.h(31.49);

    final taskCardWidth = fs.w(166);
    final taskCardHeight = fs.h(145);
    final taskIconSize = fs.w(50);
    final taskTitleWidth = fs.w(134);
    final taskTitleHeight = fs.h(22);
    final taskSubtitleWidth = fs.w(134);
    final taskSubtitleHeight = fs.h(15);

    final bottomNavWidth = fs.w(240);
    final bottomNavHeight = fs.h(66);
    final calendarIconSize = fs.w(28.8);
    final voiceIconSize = fs.w(46);
    final chatIconSize = fs.w(28.8);

    return Scaffold(
      backgroundColor: const Color(0xFF2E363C),
      body: Container(
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
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          fs.h(16),
                          horizontalPadding,
                          fs.h(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                'assets/images/Hello.svg',
                                height: fs.h(48),
                                fit: BoxFit.contain,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            SizedBox(width: fs.w(12)),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.settings,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/settings.svg',
                                width: fs.w(40),
                                height: fs.h(40),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: fs.h(8)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
                        child: Text(
                          'What can i do for you today?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: fs.sp(16),
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      SizedBox(height: fs.h(20)),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: fs.h(1),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withValues(alpha: 0.2),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: fs.w(12)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: fs.w(20),
                                vertical: fs.h(10),
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.2),
                                    Colors.white.withValues(alpha: 0.0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(fs.r(50)),
                              ),
                              child: Text(
                                formattedDate,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: fs.sp(14),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: -0.42,
                                ),
                              ),
                            ),
                            SizedBox(width: fs.w(12)),
                            Expanded(
                              child: Container(
                                height: fs.h(1),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.2),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: fs.h(32)),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming Events',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: fs.sp(20),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/images/viewall.svg',
                                width: viewAllWidth,
                                height: viewAllHeight,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: fs.h(16)),
                      SizedBox(
                        height: eventCardHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                            left: horizontalPadding,
                            right: horizontalPadding,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            const titles = [
                              'Morning Standup\nwith team.',
                              'EOD check-in &\nDocumentation Sync',
                              'Client Review\nMeeting',
                              'Sprint Planning\nSession'
                            ];
                            const dates = [
                              'Dec 1, 2025 - Dec 1,2025',
                              'Dec 1, 2025 - Dec 1,2025',
                              'Dec 2, 2025 - Dec 2,2025',
                              'Dec 3, 2025 - Dec 3,2025'
                            ];
                            return Container(
                              width: eventCardWidth,
                              height: eventCardHeight,
                              margin: EdgeInsets.only(right: eventCardSpacing),
                              padding: EdgeInsets.all(fs.w(15)),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A5661),
                                borderRadius: BorderRadius.circular(fs.r(16)),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/calendar.svg',
                                    width: eventIconSize,
                                    height: eventIconSize,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: fs.h(10)),
                                  SizedBox(
                                    width: eventTitleWidth,
                                    child: Text(
                                      titles[index],
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: fs.sp(16),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: fs.h(8)),
                                  SizedBox(
                                    width: eventDateWidth,
                                    height: eventDateHeight,
                                    child: Text(
                                      dates[index],
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: fs.sp(11),
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: viewDetailsWidth,
                                      height: viewDetailsHeight,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFB8624),
                                        borderRadius:
                                            BorderRadius.circular(fs.r(8)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'View details',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: fs.sp(13),
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: fs.h(40)),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tasks',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: fs.sp(20),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/images/viewall.svg',
                                width: viewAllWidth,
                                height: viewAllHeight,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: fs.h(16)),
                      SizedBox(
                        height: fs.h(42),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          children: [
                            _buildFilterChip(context, 'Teams', onPressed: () {}),
                            SizedBox(width: fs.w(12)),
                            _buildFilterChip(context, 'Urgent', onPressed: () {}),
                            SizedBox(width: fs.w(12)),
                            _buildFilterChip(context, 'Upcoming', onPressed: () {}),
                            SizedBox(width: fs.w(12)),
                            _buildFilterChip(context, 'Completed', onPressed: () {}),
                          ],
                        ),
                      ),
                      SizedBox(height: fs.h(20)),
                      SizedBox(
                        height: taskCardHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          children: [
                            _buildActionCard(
                              context: context,
                              width: taskCardWidth,
                              height: taskCardHeight,
                              iconSize: taskIconSize,
                              titleWidth: taskTitleWidth,
                              titleHeight: taskTitleHeight,
                              subtitleWidth: taskSubtitleWidth,
                              subtitleHeight: taskSubtitleHeight,
                              iconAsset: 'plus.svg',
                              title: 'Add Task',
                              subtitle: 'Added task shows here',
                              onPressed: () {},
                            ),
                            SizedBox(width: fs.w(16)),
                            _buildActionCard(
                              context: context,
                              width: taskCardWidth,
                              height: taskCardHeight,
                              iconSize: taskIconSize,
                              titleWidth: taskTitleWidth,
                              titleHeight: taskTitleHeight,
                              subtitleWidth: taskSubtitleWidth,
                              subtitleHeight: taskSubtitleHeight,
                              iconAsset: 'list.svg',
                              title: 'Complete',
                              subtitle: 'Sprint 1 tasks',
                              onPressed: () {},
                            ),
                            SizedBox(width: fs.w(16)),
                            _buildActionCard(
                              context: context,
                              width: taskCardWidth,
                              height: taskCardHeight,
                              iconSize: taskIconSize,
                              titleWidth: taskTitleWidth,
                              titleHeight: taskTitleHeight,
                              subtitleWidth: taskSubtitleWidth,
                              subtitleHeight: taskSubtitleHeight,
                              iconAsset: 'list.svg',
                              title: 'Complete',
                              subtitle: 'Sprint 2 tasks',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: fs.h(20)),
                    ],
                  ),
                ),
              ),
              _buildBottomNavigationBar(
                context: context,
                width: bottomNavWidth,
                height: bottomNavHeight,
                calendarSize: calendarIconSize,
                voiceSize: voiceIconSize,
                chatSize: chatIconSize,
                onCalendarPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.unifiedCalendar,
                ),
                onVoicePressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.homeDetailed,
                ),
                onChatPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.textChat,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label, {
    required VoidCallback onPressed,
  }) {
    final fs = FigmaScale.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: fs.w(24),
          vertical: fs.h(10),
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(fs.r(12)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fs.sp(15),
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required double width,
    required double height,
    required double iconSize,
    required double titleWidth,
    required double titleHeight,
    required double subtitleWidth,
    required double subtitleHeight,
    required String iconAsset,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    final fs = FigmaScale.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(fs.w(16)),
        decoration: BoxDecoration(
          color: const Color(0xFF4A5661),
          borderRadius: BorderRadius.circular(fs.r(16)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/$iconAsset',
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            SizedBox(
              width: titleWidth,
              height: titleHeight,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fs.sp(16),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ),
            SizedBox(height: fs.h(4)),
            SizedBox(
              width: subtitleWidth,
              height: subtitleHeight,
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fs.sp(12),
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar({
    required BuildContext context,
    required double width,
    required double height,
    required double calendarSize,
    required double voiceSize,
    required double chatSize,
    required VoidCallback onCalendarPressed,
    required VoidCallback onVoicePressed,
    required VoidCallback onChatPressed,
  }) {
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
