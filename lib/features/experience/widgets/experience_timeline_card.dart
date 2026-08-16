import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_timeline_item.dart';

class ExperienceTimelineCard extends StatelessWidget {
  const ExperienceTimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFECEFF4);
    const categoryHeaderColor = Color(0xFF567C9E);
    const titleColor = Color(0xFF11141A);
    const subtitleColor = Color(0xFF4B5563);
    const dateColor = Color(0xFF3B536B);
    const dotColor = Color(0xFF1E2837);
    const lineColor = Color(0xFFCAD3DF);

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
            "CAREER TIMELINE",
            style: GoogleFonts.plusJakartaSans(
              color: categoryHeaderColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 24),
          const AboutTimelineItem(
            title: "Junior Software Engineer | App",
            subtitle: "Leading development of cross-platform mobile apps and core integrations",
            date: "2025 - Ongoing",
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            dateColor: dateColor,
            dotColor: dotColor,
            lineColor: lineColor,
            isLast: false,
          ),
          const AboutTimelineItem(
            title: "Intern Software Engineer | App",
            subtitle: "Assisted in UI styling, debugging, and feature development workflows",
            date: "2025 - 2025",
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            dateColor: dateColor,
            dotColor: dotColor,
            lineColor: lineColor,
            isLast: true,
          ),
        ],
      ),
    );
  }
}
