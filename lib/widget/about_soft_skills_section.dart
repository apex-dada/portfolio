import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';
import 'package:portfolio/widget/about_skill_badge.dart';

class AboutSoftSkillsSection extends StatelessWidget {
  const AboutSoftSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SOFT SKILLS",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Technical mastery is amplified by structural values. These are the soft skills I bring to engineering projects:",
            style: GoogleFonts.inter(
              color: homeViewModel.secondaryTextColor,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AboutSkillBadge(name: "🤝 Team Collaboration"),
              AboutSkillBadge(name: "🧩 Critical Thinker"),
              AboutSkillBadge(name: "📚 Self-Educator"),
              AboutSkillBadge(name: "⏳ Adaptable"),
              AboutSkillBadge(name: "🎨 Photoshop"),
              AboutSkillBadge(name: "📐 Graphics Design"),
              AboutSkillBadge(name: "📷 Photography"),
            ],
          ),
        ],
      ),
    );
  }
}
