import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';

class AboutSkillBadge extends StatelessWidget {
  final String name;

  const AboutSkillBadge({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2837) : const Color(0xFFECEFF4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Text(
        name,
        style: GoogleFonts.inter(
          color: primaryTextColor,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
