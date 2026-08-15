import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/shared/widgets/breathing_status_dot.dart';

class AvailableBadge extends StatelessWidget {
  const AvailableBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BreathingStatusDot(),
        const SizedBox(width: 8),
        Text(
          "Available for Work",
          style: GoogleFonts.inter(
            color: const Color(0xFF59F5A2), // Green text (#59F5A2)
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
