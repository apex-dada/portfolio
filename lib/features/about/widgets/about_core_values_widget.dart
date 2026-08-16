import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_value_item.dart';

class AboutCoreValuesWidget extends StatelessWidget {
  const AboutCoreValuesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const periwinkle = Color(0xFF8EAFD1);
    const darkNavy = Color(0xFF1E2837);

    return BentoCard(
      backgroundColor: periwinkle,
      borderColor: Colors.transparent,
      hoverBorderColor: Colors.white70,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CORE VALUES",
            style: GoogleFonts.plusJakartaSans(
              color: darkNavy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 20),
          const AboutValueItem(
            title: "Quality Over Speed",
            desc: "I believe in doing things right the first time, ensuring reliability.",
            icon: Icons.stars_rounded,
          ),
          const AboutValueItem(
            title: "UX-Centric Engineering",
            desc: "Good user experience is invisible; everything is built with intent.",
            icon: Icons.gesture_rounded,
          ),
          const AboutValueItem(
            title: "Performance First",
            desc: "Ensuring memory management, smooth rendering, and rapid loading times.",
            icon: Icons.bolt_rounded,
          ),
        ],
      ),
    );
  }
}
