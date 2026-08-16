import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class AboutBioWidget extends StatelessWidget {
  const AboutBioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFECEFF4);
    const darkNavy = Color(0xFF1E2837);
    const periwinkle = Color(0xFF567C9E);

    return BentoCard(
      backgroundColor: offWhite,
      borderColor: const Color(0xFFD8DFE8),
      hoverBorderColor: HomeViewModel.periwinkleBlue,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "MY STORY",
            style: GoogleFonts.plusJakartaSans(
              color: periwinkle,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "My Journey & Vision",
            style: GoogleFonts.plusJakartaSans(
              color: darkNavy,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "I'm Kazi Woaej Mariz, a software engineer specializing in cross-platform mobile development. From my early days tinkering with layouts, I fell in love with Dart and Flutter.\n\n"
            "I believe writing software is not just about making machines do things, but about creating intuitive, smooth, and breathtaking experiences for people. When I build apps, I design them to feel responsive, fast, and alive.",
            style: GoogleFonts.inter(
              color: const Color(0xFF4B5563),
              fontSize: 14.5,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
