import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_routes.dart';
import 'screens/home.dart';
import 'screens/home_detailed.dart';
import 'screens/onboarding.dart';
import 'screens/settings.dart';
import 'screens/task_creation.dart';
import 'screens/text_chat.dart';

class NewFrontendApp extends StatelessWidget {
  const NewFrontendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New Frontend',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      initialRoute: AppRoutes.onboarding,
      routes: {
        AppRoutes.onboarding: (_) => const OnboardingScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.homeDetailed: (_) => const HomeDetailedScreen(),
        AppRoutes.textChat: (_) => const TextChatScreen(),
        AppRoutes.taskCreation: (_) => const TaskCreationScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
      },
    );
  }
}
