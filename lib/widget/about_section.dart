import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      onTap: () => homeViewModel.launchURL(
        context,
        'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/',
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0F0F2),
          border: Border.all(color: homeViewModel.borderColor),
        ),
        child: Icon(
          Icons.arrow_outward_rounded,
          color: homeViewModel.primaryTextColor,
          size: 16,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ABOUT ME",
            style: GoogleFonts.outfit(
              color: isDark ? Colors.white38 : Colors.black38,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16), // Increased spacing
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450), // Constrain paragraph width
            child: Text(
              "Passionate about mobile application development and enjoy solving complex user-experience problems.",
              style: GoogleFonts.inter(
                color: homeViewModel.primaryTextColor,
                fontSize: 17.5, // Body size
                height: 1.55, // Increased line height for legibility
                fontWeight: FontWeight.w400, // Body weight (400-500)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
