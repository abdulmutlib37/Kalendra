import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/figma_scale.dart';

class TextChatScreen extends StatefulWidget {
  const TextChatScreen({super.key});

  @override
  State<TextChatScreen> createState() => _TextChatScreenState();
}

class _TextChatScreenState extends State<TextChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isKeyboardVisible = false;
  List<ChatMessage> _messages = [];
  late AnimationController _suggestionAnimationController;
  late AnimationController _keyboardAnimationController;

  @override
  void initState() {
    super.initState();
    _suggestionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _keyboardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
        if (_isKeyboardVisible) {
          _keyboardAnimationController.forward();
        } else {
          _keyboardAnimationController.reverse();
        }
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _suggestionAnimationController.dispose();
    _keyboardAnimationController.dispose();
    super.dispose();
  }

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _messages.add(ChatMessage(text: text, isUser: false));
    });

    _textController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearConversation() {
    setState(() {
      _messages.clear();
    });
  }

  void _showMeetingDetailsDrawer(FigmaScale fs) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: const Color(0xFF2E363C).withValues(alpha: 0.7),
      builder: (context) => _buildMeetingDetailsDrawer(fs),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fs = FigmaScale.of(context);
    final screenWidth = fs.screenW;
    final screenHeight = fs.screenH;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      child: _messages.isEmpty
                          ? (_isKeyboardVisible
                              ? _buildKeyboardVisibleContent(fs)
                              : _buildDefaultContent(fs))
                          : _buildChatList(fs),
                    ),
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

  Widget _buildMeetingDetailsDrawer(FigmaScale fs) {
    return Container(
      width: fs.w(430),
      height: fs.h(472),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFD9D9D9),
            Color(0xFFF2F2F2),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(fs.r(20)),
          topRight: Radius.circular(fs.r(20)),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: fs.h(8)),
          Container(
            width: fs.w(40),
            height: fs.h(4),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(fs.r(2)),
            ),
          ),
          SizedBox(height: fs.h(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: fs.w(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: fs.w(141),
                      height: fs.h(24),
                      child: Text(
                        'Confirm Action',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fs.sp(20),
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: fs.w(24),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: fs.h(8)),
                SizedBox(
                  width: fs.w(292),
                  height: fs.h(17),
                  child: Text(
                    'Create "testing" on Mon, Dec 1, 2025, 3:00 PM?',
                    style: TextStyle(
                      color: const Color(0xFFC36135),
                      fontSize: fs.sp(14),
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.42,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                SizedBox(height: fs.h(20)),
                Container(
                  width: fs.w(390),
                  height: fs.h(246),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(fs.r(12)),
                  ),
                  padding: EdgeInsets.all(fs.w(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: fs.w(151),
                            height: fs.h(24),
                            child: Text(
                              'Meeting Details:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fs.sp(20),
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.6,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          Icon(
                            Icons.copy,
                            size: fs.w(24),
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: fs.h(12)),
                      Container(
                        width: fs.w(370),
                        height: fs.h(187),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFB2B2B2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(fs.r(8)),
                        ),
                        padding: EdgeInsets.all(fs.w(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title:',
                              style: TextStyle(
                                color: const Color(0xFFB2B2B2),
                                fontSize: fs.sp(13),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(height: fs.h(4)),
                            Text(
                              'Testing',
                              style: TextStyle(
                                color: const Color(0xFF2E363C),
                                fontSize: fs.sp(16),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(height: fs.h(16)),
                            Text(
                              'Date & Time:',
                              style: TextStyle(
                                color: const Color(0xFFB2B2B2),
                                fontSize: fs.sp(13),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(height: fs.h(4)),
                            Text(
                              'Dec 1, 2025, 3:00 PM',
                              style: TextStyle(
                                color: const Color(0xFF2E363C),
                                fontSize: fs.sp(16),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(height: fs.h(16)),
                            Text(
                              'Attendees:',
                              style: TextStyle(
                                color: const Color(0xFFB2B2B2),
                                fontSize: fs.sp(13),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(height: fs.h(4)),
                            Text(
                              'hasan@example.com',
                              style: TextStyle(
                                color: const Color(0xFF2E363C),
                                fontSize: fs.sp(16),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: fs.h(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: fs.w(190),
                      height: fs.h(60),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(fs.r(30)),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: const Color(0xFFFB8624),
                            fontSize: fs.sp(16),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: fs.w(181),
                      height: fs.h(60),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFB8624),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(fs.r(30)),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: fs.sp(16),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
            opacity: _messages.isEmpty ? 0.2 : 1.0,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/delete.svg',
                width: fs.w(42),
                height: fs.w(42),
              ),
              onPressed: _messages.isEmpty ? null : _clearConversation,
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

  Widget _buildChatList(FigmaScale fs) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: fs.w(16),
        vertical: fs.h(16),
      ),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildChatBubble(message, fs, index);
      },
    );
  }

  Widget _buildChatBubble(ChatMessage message, FigmaScale fs, int index) {
    return Column(
      crossAxisAlignment:
          message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (message.isUser)
          Padding(
            padding: EdgeInsets.only(bottom: fs.h(8), right: fs.w(8)),
            child: SvgPicture.asset(
              'assets/images/fourstar.svg',
              width: fs.w(22),
              height: fs.w(22),
            ),
          ),
        if (!message.isUser)
          Padding(
            padding: EdgeInsets.only(left: fs.w(8), bottom: fs.h(8)),
            child: SvgPicture.asset(
              'assets/images/chatball.svg',
              width: fs.w(34),
              height: fs.w(34),
            ),
          ),
        Row(
          mainAxisAlignment:
              message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: fs.h(12),
                  left: message.isUser ? 0 : fs.w(8),
                  right: message.isUser ? fs.w(8) : 0,
                ),
                constraints: BoxConstraints(maxWidth: fs.w(280)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(fs.r(16)),
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
                    color: message.isUser
                        ? const Color(0xFFFB8624).withValues(alpha: 0.3)
                        : const Color(0xFF3A4248),
                    borderRadius: BorderRadius.circular(fs.r(15)),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fs.sp(14),
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!message.isUser)
          Padding(
            padding: EdgeInsets.only(left: fs.w(8), bottom: fs.h(16)),
            child: _buildViewDetailsButton(fs),
          ),
      ],
    );
  }

  Widget _buildViewDetailsButton(FigmaScale fs) {
    return GestureDetector(
      onTap: () => _showMeetingDetailsDrawer(fs),
      child: Container(
        width: fs.w(124),
        height: fs.h(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(fs.r(15)),
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
            borderRadius: BorderRadius.circular(fs.r(14)),
            color: const Color(0xFFFB8624).withValues(alpha: 0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'View Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fs.sp(12),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(width: fs.w(6)),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: fs.w(14),
              ),
            ],
          ),
        ),
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
        physics: const BouncingScrollPhysics(),
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
        _handleSendMessage(text);
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
              fontFamily: 'Inter',
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: inputWidth,
      height: inputHeight,
      margin: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        bottom: verticalMargin,
        top: fs.h(8),
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
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
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
                  fontFamily: 'Inter',
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
                onSubmitted: (text) => _handleSendMessage(text),
              ),
            ),
            SizedBox(width: fs.w(12)),
            GestureDetector(
              onTap: () => _handleSendMessage(_textController.text),
              child: SvgPicture.asset(
                'assets/images/gchat.svg',
                width: fs.w(24),
                height: fs.w(24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}
