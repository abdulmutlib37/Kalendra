import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final horizontalPadding = (maxWidth * 0.05).clamp(16.0, 24.0);
        final viewAllWidth = (maxWidth * 0.26).clamp(88.0, 110.0);
        final viewAllHeight = (viewAllWidth * 0.4).clamp(34.0, 44.0);
        final eventCardWidth = (maxWidth * 0.78).clamp(260.0, 360.0);
        final actionCardWidth = (maxWidth * 0.68).clamp(220.0, 340.0);

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
                              16,
                              horizontalPadding,
                              8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                    'assets/images/Hello.svg',
                                    height: 58,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.settings,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/settings.svg',
                                    width: 56,
                                    height: 56,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
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
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
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
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      letterSpacing: -0.42,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    height: 1,
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
                          const SizedBox(height: 32),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Upcoming Events',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 20),
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
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 250,
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
                                  margin: const EdgeInsets.only(right: 16),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4A5661),
                                    borderRadius: BorderRadius.circular(16),
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
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        titles[index],
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          height: 1.3,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        dates[index],
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 13,
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
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFB8624),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'View details',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 16,
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
                          const SizedBox(height: 40),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Tasks',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 20),
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
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 56,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                              ),
                              children: [
                                _buildFilterChip('Teams', onPressed: () {}),
                                const SizedBox(width: 12),
                                _buildFilterChip('Urgent', onPressed: () {}),
                                const SizedBox(width: 12),
                                _buildFilterChip('Upcoming', onPressed: () {}),
                                const SizedBox(width: 12),
                                _buildFilterChip('Completed', onPressed: () {}),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                              ),
                              children: [
                                _buildActionCard(
                                  width: actionCardWidth,
                                  iconAsset: 'plus.svg',
                                  title: 'Add Task',
                                  subtitle: 'Added task shows here',
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 16),
                                _buildActionCard(
                                  width: actionCardWidth,
                                  iconAsset: 'list.svg',
                                  title: 'Complete',
                                  subtitle: 'Sprint 1 tasks',
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 16),
                                _buildActionCard(
                                  width: actionCardWidth,
                                  iconAsset: 'list.svg',
                                  title: 'Complete',
                                  subtitle: 'Sprint 2 tasks',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomNavigationBar(
                    horizontalPadding: horizontalPadding,
                    onCalendarPressed: () {},
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
      },
    );
  }

  Widget _buildFilterChip(String label, {required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required double width,
    required String iconAsset,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF4A5661),
          borderRadius: BorderRadius.circular(16),
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
              width: 72,
              height: 72,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar({
    required double horizontalPadding,
    required VoidCallback onCalendarPressed,
    required VoidCallback onVoicePressed,
    required VoidCallback onChatPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20,
        left: (horizontalPadding * 2).clamp(28.0, 44.0),
        right: (horizontalPadding * 2).clamp(28.0, 44.0),
      ),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: const Color(0xFF4A5661),
          borderRadius: BorderRadius.circular(50),
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
                width: 32,
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
            GestureDetector(
              onTap: onVoicePressed,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFFB8624),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/voice.svg',
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onChatPressed,
              child: SvgPicture.asset(
                'assets/images/chat.svg',
                width: 32,
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
