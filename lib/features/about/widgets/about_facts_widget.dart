import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_fact_item.dart';

class AboutFactsWidget extends StatelessWidget {
  const AboutFactsWidget({super.key});

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
            "QUICK INFO",
            style: GoogleFonts.outfit(
              color: accentColor,
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
          Divider(color: borderColor.withValues(alpha: 0.5), height: 16),
          const AboutFactItem(
            label: "LANGUAGES",
            value: "English, Bengali",
            icon: Icons.translate_rounded,
          ),
          Divider(color: borderColor.withValues(alpha: 0.5), height: 16),
          const AboutFactItem(
            label: "MAIN FOCUS",
            value: "Flutter (Android, iOS, Web)",
            icon: Icons.code_rounded,
          ),
          Divider(color: borderColor.withValues(alpha: 0.5), height: 16),
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
