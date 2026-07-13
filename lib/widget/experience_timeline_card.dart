import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';
import 'package:portfolio/widget/about_timeline_item.dart';

class ExperienceTimelineCard extends StatelessWidget {
  const ExperienceTimelineCard({super.key});

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
            "CAREER TIMELINE",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 24),
          const AboutTimelineItem(
            title: "Senior Flutter Developer",
            subtitle: "Building enterprise mobile applications globally",
            date: "2024 - Present",
            isLast: false,
          ),
          const AboutTimelineItem(
            title: "Associate Software Engineer",
            subtitle: "Created robust and scalable SDK components",
            date: "2022 - 2024",
            isLast: true,
          ),
        ],
      ),
    );
  }
}
