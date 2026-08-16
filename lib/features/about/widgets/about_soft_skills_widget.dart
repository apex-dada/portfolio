import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_skill_badge.dart';

class AboutSoftSkillsWidget extends StatelessWidget {
  const AboutSoftSkillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      backgroundColor: const Color(0xFF15181E),
      borderColor: const Color(0xFF242C38),
      hoverBorderColor: HomeViewModel.periwinkleBlue,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SOFT SKILLS",
            style: GoogleFonts.plusJakartaSans(
              color: HomeViewModel.periwinkleBlue,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Technical mastery is amplified by structural values. These are the soft skills I bring to engineering projects:",
            style: GoogleFonts.inter(
              color: const Color(0xFF8A96A6),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AboutSkillBadge(name: "Team Collaboration"),
              AboutSkillBadge(name: "Critical Thinker"),
              AboutSkillBadge(name: "Self-Educator"),
              AboutSkillBadge(name: "Adaptable"),
              AboutSkillBadge(name: "Photoshop"),
              AboutSkillBadge(name: "Graphics Design"),
              AboutSkillBadge(name: "Photography"),
            ],
          ),
        ],
      ),
    );
  }
}
