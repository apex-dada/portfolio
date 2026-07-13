import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/breathing_status_dot.dart';

class AvailableBadge extends StatefulWidget {
  const AvailableBadge({super.key});

  @override
  State<AvailableBadge> createState() => _AvailableBadgeState();
}

class _AvailableBadgeState extends State<AvailableBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(_isHovered ? 0.06 : 0.03) // Dark glass background
              : Colors.black.withOpacity(_isHovered ? 0.06 : 0.03),
          borderRadius: BorderRadius.circular(999), // 999px border radius
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(_isHovered ? 0.15 : 0.08) // 1px subtle border
                : Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
            width: 1.0,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: const Color(0xFF59F5A2).withOpacity(0.12),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Row(
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
        ),
      ),
    );
  }
}
