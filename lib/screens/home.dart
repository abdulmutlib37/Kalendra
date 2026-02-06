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
    final availableW = fs.screenW;

    final viewAllWidth = fs.w(110).clamp(fs.w(88), fs.w(120)).toDouble();
    final viewAllHeight = fs.h(44).clamp(fs.h(34), fs.h(48)).toDouble();

    final eventCardWidth = fs
        .u(360)
        .clamp(
          fs.u(260),
          (availableW - (horizontalPadding * 2)).clamp(0.0, double.infinity),
        )
        .toDouble();
    final actionCardWidth = fs
        .u(340)
        .clamp(
          fs.u(220),
          (availableW - (horizontalPadding * 2)).clamp(0.0, double.infinity),
        )
        .toDouble();

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
                                width: fs.u(40),
                                height: fs.u(40),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
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
                            SizedBox(width: fs.w(20)),
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
                        height: fs.h(210),
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
                              margin: EdgeInsets.only(right: fs.w(16)),
                              padding: EdgeInsets.all(fs.w(20)),
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
                                    width: fs.u(36),
                                    height: fs.u(36),
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: fs.h(14)),
                                  Text(
                                    titles[index],
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: fs.sp(18),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(height: fs.h(8)),
                                  Text(
                                    dates[index],
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: fs.sp(12),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: fs.h(12),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFB8624),
                                        borderRadius:
                                            BorderRadius.circular(fs.r(12)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'View details',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: fs.sp(14),
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
                            SizedBox(width: fs.w(20)),
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
                        height: fs.h(48),
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
                        height: fs.h(145),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          children: [
                            _buildActionCard(
                              context: context,
                              width: actionCardWidth,
                              iconAsset: 'plus.svg',
                              title: 'Add Task',
                              subtitle: 'Added task shows here',
                              onPressed: () {},
                            ),
                            SizedBox(width: fs.w(16)),
                            _buildActionCard(
                              context: context,
                              width: actionCardWidth,
                              iconAsset: 'list.svg',
                              title: 'Complete',
                              subtitle: 'Sprint 1 tasks',
                              onPressed: () {},
                            ),
                            SizedBox(width: fs.w(16)),
                            _buildActionCard(
                              context: context,
                              width: actionCardWidth,
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
              _buildBottomNavigationBar(
                context: context,
                horizontalPadding: horizontalPadding,
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
          horizontal: fs.w(28),
          vertical: fs.h(14),
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
              fontSize: fs.sp(17),
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required double width,
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
        padding: EdgeInsets.all(fs.w(12)),
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
              width: fs.u(40),
              height: fs.u(40),
              fit: BoxFit.contain,
            ),
            SizedBox(height: fs.h(6)),
            Flexible(
              fit: FlexFit.loose,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: fs.sp(15),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: fs.h(2)),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: fs.sp(11),
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.7),
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

  Widget _buildBottomNavigationBar({
    required BuildContext context,
    required double horizontalPadding,
    required VoidCallback onCalendarPressed,
    required VoidCallback onVoicePressed,
    required VoidCallback onChatPressed,
  }) {
    final fs = FigmaScale.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: fs.h(20),
        left: fs.w(40),
        right: fs.w(40),
      ),
      child: Container(
        height: fs.h(72),
        decoration: BoxDecoration(
          color: const Color(0xFF4A5661),
          borderRadius: BorderRadius.circular(fs.r(50)),
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.2),
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
                width: fs.u(24),
                height: fs.u(24),
                fit: BoxFit.contain,
              ),
            ),
            GestureDetector(
              onTap: onVoicePressed,
              child: Container(
                width: fs.u(52),
                height: fs.u(52),
                decoration: const BoxDecoration(
                  color: Color(0xFFFB8624),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/voice.svg',
                    width: fs.u(24),
                    height: fs.u(24),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onChatPressed,
              child: SvgPicture.asset(
                'assets/images/chat.svg',
                width: fs.u(24),
                height: fs.u(24),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
