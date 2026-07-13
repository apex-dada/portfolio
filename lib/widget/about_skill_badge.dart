import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';

class AboutSkillBadge extends StatelessWidget {
  final String name;

  const AboutSkillBadge({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: homeViewModel.borderColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(
        name,
        style: GoogleFonts.inter(
          color: homeViewModel.primaryTextColor,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
