import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_fact_item.dart';

class AboutFactsWidget extends StatelessWidget {
  const AboutFactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const periwinkle = Color(0xFF8EAFD1);
    const darkNavy = Color(0xFF1E2837);

    return BentoCard(
      backgroundColor: periwinkle,
      borderColor: Colors.transparent,
      hoverBorderColor: Colors.white70,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "QUICK INFO",
            style: GoogleFonts.plusJakartaSans(
              color: darkNavy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          const AboutFactItem(
            label: "LOCATION",
            value: "Dhaka, Bangladesh",
            icon: Icons.location_on_outlined,
          ),
          Divider(color: darkNavy.withValues(alpha: 0.15), height: 16),
          const AboutFactItem(
            label: "LANGUAGES",
            value: "English, Bengali",
            icon: Icons.translate_rounded,
          ),
          Divider(color: darkNavy.withValues(alpha: 0.15), height: 16),
          const AboutFactItem(
            label: "MAIN FOCUS",
            value: "Flutter (Android, iOS, Web)",
            icon: Icons.code_rounded,
          ),
          Divider(color: darkNavy.withValues(alpha: 0.15), height: 16),
          const AboutFactItem(
            label: "EDUCATION",
            value: "B.Sc. in CSE",
            icon: Icons.school_outlined,
          ),
        ],
      ),
    );
  }
}
