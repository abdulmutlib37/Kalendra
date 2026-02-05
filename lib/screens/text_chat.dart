import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    final scaleX = screenWidth / 430;
    final scaleY = screenHeight / 932;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF1A1A1A),
          ),
          Positioned(
            right: -50 * scaleX,
            top: -50 * scaleY,
            child: Container(
              width: 300 * scaleX,
              height: 300 * scaleY,
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
                  const Color(0xFF2A2A2A).withValues(alpha: 0.3),
                  const Color(0xFF1A1A1A),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: safeAreaTop),
              _buildHeader(screenWidth, scaleX),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _isKeyboardVisible
                          ? _buildKeyboardVisibleContent(
                              screenWidth,
                              screenHeight,
                              scaleX,
                              scaleY,
                            )
                          : _buildDefaultContent(
                              screenWidth,
                              screenHeight,
                              scaleX,
                              scaleY,
                            ),
                    ),
                    if (!_isKeyboardVisible)
                      _buildChatSuggestions(screenWidth, screenHeight, scaleX),
                    _buildInputField(screenWidth, screenHeight, scaleX, scaleY),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double scaleX) {
    final headerHeight = 60.0 * scaleX;

    return Container(
      height: headerHeight,
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 8 * scaleX),
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
              width: 24 * scaleX,
              height: 24 * scaleX,
            ),
            onPressed: () => Navigator.maybePop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: 8 * scaleX),
          SvgPicture.asset(
            'assets/images/textchat.svg',
            height: 28 * scaleX,
          ),
          const Spacer(),
          Opacity(
            opacity: 0.2,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/delete.svg',
                width: 42 * scaleX,
                height: 42 * scaleX,
              ),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          SizedBox(width: 8 * scaleX),
        ],
      ),
    );
  }

  Widget _buildDefaultContent(
    double screenWidth,
    double screenHeight,
    double scaleX,
    double scaleY,
  ) {
    final ballWidth = 176.99 * scaleX;
    final ballHeight = 124.77 * scaleY;
    final ballLeftMargin = 127.0 * scaleX;
    final ballTopMargin = 251.32 * scaleY;

    final title1Left = 122.0 * scaleX;
    final title1Top = 397.0 * scaleY;
    final title2Left = 114.0 * scaleX;
    final title2Top = 426.0 * scaleY;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: ballLeftMargin,
          top: ballTopMargin,
          child: SizedBox(
            width: ballWidth,
            height: ballHeight,
            child: Transform.scale(
              scale: 2.5,
              child: SvgPicture.asset(
                'assets/images/ball.svg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          left: title1Left,
          top: title1Top,
          child: const Text(
            'Start a conversation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.72,
              fontFamily: 'Inter',
            ),
          ),
        ),
        Positioned(
          left: title2Left,
          top: title2Top,
          child: const Text(
            'Ask me anything about your calendar',
            style: TextStyle(
              color: Color(0xFF7B7B7B),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.42,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyboardVisibleContent(
    double screenWidth,
    double screenHeight,
    double scaleX,
    double scaleY,
  ) {
    final ballWidth = 100.0 * scaleX;
    final ballHeight = 70.5 * scaleY;

    return Container(
      padding: EdgeInsets.only(top: 40 * scaleY),
      child: Column(
        children: [
          SizedBox(
            width: ballWidth,
            height: ballHeight,
            child: Transform.scale(
              scale: 2.0,
              child: SvgPicture.asset(
                'assets/images/ball.svg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 20 * scaleY),
          const Text(
            'Start a conversation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 6 * scaleY),
          const Text(
            'Ask me anything about your calendar',
            style: TextStyle(
              color: Color(0xFF7B7B7B),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.36,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSuggestions(
    double screenWidth,
    double screenHeight,
    double scaleX,
  ) {
    final suggestions = [
      'You have a gap at 3 PM',
      'Remind me to check progress in 2 days',
      'Schedule a team meeting',
      'What\'s on my calendar tomorrow?',
      'Find time for lunch this week?',
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scaleX,
        vertical: 12 * scaleX,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: suggestions.map((suggestion) {
            return Padding(
              padding: EdgeInsets.only(right: 8 * scaleX),
              child: _buildSuggestionChip(suggestion, scaleX),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String text, double scaleX) {
    return GestureDetector(
      onTap: () {
        _textController.text = text;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25 * scaleX),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E363C),
              Color(0xFFFB8624),
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(1),
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scaleX,
            vertical: 12 * scaleX,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24 * scaleX),
            color: const Color(0xFFFB8624).withValues(alpha: 0.2),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFCCCCCC),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    double screenWidth,
    double screenHeight,
    double scaleX,
    double scaleY,
  ) {
    final inputWidth = 374.0 * scaleX;
    final inputHeight = 50.0 * scaleY;
    final horizontalMargin = 28.0 * scaleX;
    final verticalMargin = 16.0 * scaleY;

    return Container(
      width: inputWidth,
      height: inputHeight,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25 * scaleX),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E363C),
            Color(0xFFFB8624),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(24 * scaleX),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleX),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
            SizedBox(width: 12 * scaleX),
            SvgPicture.asset(
              'assets/images/gchat.svg',
              width: 24 * scaleX,
              height: 24 * scaleX,
            ),
          ],
        ),
      ),
    );
  }
}
