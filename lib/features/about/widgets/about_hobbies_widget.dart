import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_hobby_chip.dart';

class AboutHobbiesWidget extends StatelessWidget {
  const AboutHobbiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFECEFF4);
    const periwinkle = Color(0xFF567C9E);

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
            "BEYOND CODING",
            style: GoogleFonts.plusJakartaSans(
              color: periwinkle,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "When I'm not writing code or tweaking UI designs, I spend my time exploring other creative and relaxing fields:",
            style: GoogleFonts.inter(
              color: const Color(0xFF4B5563),
              fontSize: 13.5,
              height: 1.5,
              fontWeight: FontWeight.w500,
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
