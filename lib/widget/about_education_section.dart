import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';
import 'package:portfolio/widget/about_timeline_item.dart';

class AboutEducationSection extends StatelessWidget {
  const AboutEducationSection({super.key});

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
            "EDUCATION",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 24),
          const AboutTimelineItem(
            title: "B.Sc. in Computer Science & Engineering",
            subtitle: "University of Asia Pacific, Dhaka",
            date: "2020 - 2024",
            isLast: false,
          ),
          const AboutTimelineItem(
            title: "Higher Secondary School Certificate",
            subtitle: "Cantonment College, Jessore",
            date: "2017 - 2019",
            isLast: true,
          ),
        ],
      ),
    );
  }
}
