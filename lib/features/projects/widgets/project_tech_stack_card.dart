import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/home/widgets/logo_carousel.dart';

class ProjectTechStackCard extends StatelessWidget {
  const ProjectTechStackCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
            child: Text(
              "TECHNOLOGIES USED",
              style: GoogleFonts.outfit(
                color: accentColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: Center(
              child: LogoCarousel(),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
