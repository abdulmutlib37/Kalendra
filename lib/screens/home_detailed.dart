import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../routes/app_routes.dart';
import '../utils/figma_scale.dart';

part 'home_detailed/home_detailed_screen_mixin.dart';

class HomeDetailedScreen extends StatefulWidget {
  const HomeDetailedScreen({super.key});

  @override
  State<HomeDetailedScreen> createState() => _HomeDetailedScreenState();
}

class _HomeDetailedScreenState extends State<HomeDetailedScreen>
    with _HomeDetailedScreenMixin {}