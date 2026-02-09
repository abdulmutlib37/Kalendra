import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/figma_scale.dart';

class TextChatScreen extends StatefulWidget {
  const TextChatScreen({super.key});

  @override
  State<TextChatScreen> createState() => _TextChatScreenState();
}

class _TextChatScreenState extends State<TextChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    final screenWidth = fs.screenW;
    final screenHeight = fs.screenH;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    return Scaffold(
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
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2E363C).withValues(alpha: 0.3),
                  const Color(0xFF2E363C),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: safeAreaTop),
              _buildHeader(fs),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _isKeyboardVisible
                          ? _buildKeyboardVisibleContent(
                              fs,
                            )
                          : _buildDefaultContent(
                              fs,
                            ),
                    ),
                    if (!_isKeyboardVisible)
                      _buildChatSuggestions(fs),
                    _buildInputField(fs),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(FigmaScale fs) {
    return Container(
      height: fs.h(60),
      width: fs.screenW,
      padding: EdgeInsets.symmetric(horizontal: fs.w(8)),
      decoration: const BoxDecoration(
        color: Colors.transparent,
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
          SvgPicture.asset(
            'assets/images/textchat.svg',
            height: fs.h(28),
          ),
          const Spacer(),
          Opacity(
            opacity: 0.2,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/delete.svg',
                width: fs.w(42),
                height: fs.w(42),
              ),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          SizedBox(width: fs.w(8)),
        ],
      ),
    );
  }

  Widget _buildDefaultContent(FigmaScale fs) {
    final ballWidth = fs.w(176.99);
    final ballHeight = fs.h(124.77);
    final ballLeftMargin = fs.w(127.0);
    final ballTopMargin = fs.h(251.32);

    final title1Left = fs.w(122.0);
    final title1Top = fs.h(397.0);
    final title2Left = fs.w(114.0);
    final title2Top = fs.h(426.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: ballLeftMargin,
          top: ballTopMargin,
          child: SizedBox(
            width: ballWidth,
            height: ballHeight,
            child: ClipRect(
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: SizedBox(
                  width: fs.w(430),
                  height: fs.h(507),
                  child: SvgPicture.asset(
                    'assets/images/ball1.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: title1Left,
          top: title1Top,
          child: Text(
            'Start a conversation',
            style: TextStyle(
              color: Colors.white,
              fontSize: fs.sp(24),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.72,
              fontFamily: 'Inter',
            ),
          ),
        ),
        Positioned(
          left: title2Left,
          top: title2Top,
          child: Text(
            'Ask me anything about your calendar',
            style: TextStyle(
              color: Color(0xFF7B7B7B),
              fontSize: fs.sp(14),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.42,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyboardVisibleContent(FigmaScale fs) {
    final ballWidth = fs.w(100.0);
    final ballHeight = fs.h(70.5);

    return Container(
      padding: EdgeInsets.only(top: fs.h(40)),
      child: Column(
        children: [
          SizedBox(
            width: ballWidth,
            height: ballHeight,
            child: ClipRect(
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: SizedBox(
                  width: fs.w(430),
                  height: fs.h(507),
                  child: SvgPicture.asset(
                    'assets/images/ball1.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: fs.h(20)),
          Text(
            'Start a conversation',
            style: TextStyle(
              color: Colors.white,
              fontSize: fs.sp(20),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: fs.h(6)),
          Text(
            'Ask me anything about your calendar',
            style: TextStyle(
              color: Color(0xFF7B7B7B),
              fontSize: fs.sp(12),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.36,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSuggestions(FigmaScale fs) {
    final suggestions = [
      'You have a gap at 3 PM',
      'Remind me to check progress in 2 days',
      'Schedule a team meeting',
      'What\'s on my calendar tomorrow?',
      'Find time for lunch this week?',
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fs.w(16),
        vertical: fs.h(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: suggestions.map((suggestion) {
            return Padding(
              padding: EdgeInsets.only(right: fs.w(8)),
              child: _buildSuggestionChip(suggestion, fs),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String text, FigmaScale fs) {
    return GestureDetector(
      onTap: () {
        _textController.text = text;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(fs.r(25)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2E363C).withValues(alpha: 0.2),
              const Color(0xFFFB8624).withValues(alpha: 0.2),
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(fs.w(1)),
          padding: EdgeInsets.symmetric(
            horizontal: fs.w(16),
            vertical: fs.h(12),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(fs.r(24)),
            color: const Color(0xFFFB8624).withValues(alpha: 0.2),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFFCCCCCC),
              fontSize: fs.sp(14),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(FigmaScale fs) {
    final inputWidth = fs.w(374.0);
    final inputHeight = fs.h(50.0);
    final horizontalMargin = fs.w(28.0);
    final verticalMargin = fs.h(16.0);

    return Container(
      width: inputWidth,
      height: inputHeight,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(fs.r(25)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2E363C).withValues(alpha: 0.2),
            const Color(0xFFFB8624).withValues(alpha: 0.2),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(fs.w(1)),
        decoration: BoxDecoration(
          color: const Color(0xFFFB8624).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(fs.r(24)),
        ),
        padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fs.sp(16),
                ),
                decoration: const InputDecoration(
                  hintText: 'Tap to chat...',
                  hintStyle: TextStyle(
                    color: Color(0xFF8A8A8A),
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            SizedBox(width: fs.w(12)),
            SvgPicture.asset(
              'assets/images/gchat.svg',
              width: fs.w(24),
              height: fs.w(24),
            ),
          ],
        ),
      ),
    );
  }
}

// dummy commitgitcommit -m "dummy"
