import 'package:flutter/material.dart';

class BreathingStatusDot extends StatefulWidget {
  const BreathingStatusDot({super.key});

  @override
  State<BreathingStatusDot> createState() => _BreathingStatusDotState();
}

class _BreathingStatusDotState extends State<BreathingStatusDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);

    _glowAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glowSize = 10.0 + (_glowAnimation.value * 6.0);
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: glowSize,
              height: glowSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF59F5A2).withOpacity(0.15 * (1.0 - _glowAnimation.value * 0.4)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF59F5A2).withOpacity(0.3 * (1.0 - _glowAnimation.value * 0.5)),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF59F5A2),
              ),
            ),
          ],
        );
      },
    );
  }
}
