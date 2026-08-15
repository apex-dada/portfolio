import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class AboutBioWidget extends StatelessWidget {
  const AboutBioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "MY STORY",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "My Journey & Vision",
            style: GoogleFonts.outfit(
              color: homeViewModel.primaryTextColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "I'm Kazi Woaej Mariz, a software engineer specializing in cross-platform mobile development. From my early days tinkering with layouts, I fell in love with Dart and Flutter.\n\n"
            "I believe writing software is not just about making machines do things, but about creating intuitive, smooth, and breathtaking experiences for people. When I build apps, I design them to feel responsive, fast, and alive.",
            style: GoogleFonts.inter(
              color: homeViewModel.secondaryTextColor,
              fontSize: 14.5,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
