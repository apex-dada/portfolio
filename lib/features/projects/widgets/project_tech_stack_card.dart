import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/home/widgets/logo_carousel.dart';

class ProjectTechStackCard extends StatelessWidget {
  const ProjectTechStackCard({super.key});

  @override
  Widget build(BuildContext context) {
    const periwinkle = Color(0xFF8EAFD1);
    const darkNavy = Color(0xFF1E2837);

    return BentoCard(
      width: double.infinity,
      backgroundColor: periwinkle,
      borderColor: Colors.transparent,
      hoverBorderColor: Colors.white70,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
            child: Text(
              "TECHNOLOGIES USED",
              style: GoogleFonts.plusJakartaSans(
                color: darkNavy,
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
