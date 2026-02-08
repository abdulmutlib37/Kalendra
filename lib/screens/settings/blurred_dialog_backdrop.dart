part of '../settings.dart';

class _BlurredDialogBackdrop extends StatelessWidget {
  final Widget child;

  const _BlurredDialogBackdrop({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.20),
          ),
        ),
        Center(child: child),
      ],
    );
  }
}
