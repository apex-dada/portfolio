import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/about/widgets/about_value_item.dart';

class AboutCoreValuesWidget extends StatelessWidget {
  const AboutCoreValuesWidget({super.key});

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
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CORE VALUES",
            style: GoogleFonts.outfit(
              color: accentColor,
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
