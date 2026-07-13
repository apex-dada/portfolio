import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';
import 'package:portfolio/widget/about_hobby_chip.dart';

class AboutHobbiesSection extends StatelessWidget {
  const AboutHobbiesSection({super.key});

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
            "BEYOND CODING",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "When I'm not writing code or tweaking UI designs, I spend my time exploring other creative and relaxing fields:",
            style: GoogleFonts.inter(
              color: homeViewModel.secondaryTextColor,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              AboutHobbyChip(label: "Gaming 🎮", icon: Icons.gamepad_outlined),
              AboutHobbyChip(label: "Music 🎵", icon: Icons.music_note_outlined),
              AboutHobbyChip(label: "Traveling ✈️", icon: Icons.explore_outlined),
              AboutHobbyChip(label: "Photography 📷", icon: Icons.camera_alt_outlined),
            ],
          ),
        ],
      ),
    );
  }
}
