import 'package:flutter/material.dart';

class BreathingStatusDot extends StatefulWidget {
  const BreathingStatusDot({super.key});

  @override
  State<BreathingStatusDot> createState() => _BreathingStatusDotState();
}

class _BreathingStatusDotState extends State<BreathingStatusDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1750),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeInOutSine.transform(_controller.value);
        final glowSize = 10.0 + (t * 6.0);
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: glowSize,
              height: glowSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF59F5A2).withValues(alpha: 0.15 * (1.0 - t * 0.4)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF59F5A2).withValues(alpha: 0.3 * (1.0 - t * 0.5)),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            child!,
          ],
        );
      },
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF59F5A2),
        ),
      ),
    );
  }
}
