import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ProjectOverviewCard extends StatelessWidget {
  const ProjectOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFECEFF4);
    const darkNavy = Color(0xFF1E2837);
    const periwinkle = Color(0xFF567C9E);

    return BentoCard(
      width: double.infinity,
      backgroundColor: offWhite,
      borderColor: const Color(0xFFD8DFE8),
      hoverBorderColor: HomeViewModel.periwinkleBlue,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "PROJECT PHILOSOPHY",
            style: GoogleFonts.plusJakartaSans(
              color: periwinkle,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Clean Architecture & UX Focus",
            style: GoogleFonts.plusJakartaSans(
              color: darkNavy,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Every application is built following strict state-management rules (Bloc/Provider), clear layout structures (MVVM), and tested optimization practices.\n\n"
            "By ensuring clean separations of layers, applications are scale-ready, modular, and easy to maintain for future modifications.",
            style: GoogleFonts.inter(
              color: const Color(0xFF4B5563),
              fontSize: 13.5,
              height: 1.55,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
