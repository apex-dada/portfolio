import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_hobby_chip.dart';

class AboutHobbiesWidget extends StatelessWidget {
  const AboutHobbiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
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
              color: secondaryTextColor,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              AboutHobbyChip(label: "Gaming", icon: Icons.gamepad_outlined),
              AboutHobbyChip(label: "Music", icon: Icons.music_note_outlined),
              AboutHobbyChip(label: "Photography", icon: Icons.camera_alt_outlined),
              AboutHobbyChip(label: "Reading", icon: Icons.menu_book_outlined),
            ],
          ),
        ],
      ),
    );
  }
}
