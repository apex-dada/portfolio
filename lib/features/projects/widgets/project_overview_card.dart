import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ProjectOverviewCard extends StatelessWidget {
  const ProjectOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      width: double.infinity,
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "PROJECT PHILOSOPHY",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Clean Architecture & UX Focus",
            style: GoogleFonts.outfit(
              color: primaryTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Every application is built following strict state-management rules (Bloc/Provider), clear layout structures (MVVM), and tested optimization practices.\n\n"
            "By ensuring clean separations of layers, applications are scale-ready, modular, and easy to maintain for future modifications.",
            style: GoogleFonts.inter(
              color: secondaryTextColor,
              fontSize: 13.5,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
