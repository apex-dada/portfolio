import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_timeline_item.dart';

class AboutEducationWidget extends StatelessWidget {
  const AboutEducationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
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
            subtitle: "American International University - Bangladesh",
            date: "2022 - Present",
            isLast: false,
          ),
          const AboutTimelineItem(
            title: "Higher Secondary Certificate (HSC)",
            subtitle: "Agricultural University College",
            date: "Class of 2021",
            isLast: false,
          ),
          const AboutTimelineItem(
            title: "Secondary School Certificate (SSC)",
            subtitle: "Premier Ideal High School",
            date: "Class of 2019",
            isLast: true,
          ),
        ],
      ),
    );
  }
}
