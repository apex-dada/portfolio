import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    return BentoCard(
      key: homeViewModel.aboutKey,
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      onTap: () => homeViewModel.launchURL(
        context,
        'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/',
      ),
      trailing: SizedBox(
        width: 34,
        height: 34,
        child: LiquidGlass.withOwnLayer(
          shape: LiquidRoundedRectangle(
            borderRadius: 17, // Circle shape via border radius
            side: BorderSide(
              color: homeViewModel.borderColor,
              width: 1.0,
            ),
          ),
          settings: LiquidGlassSettings(
            blur: 8.0,
            glassColor: isDark ? const Color(0x1AFFFFFF) : const Color(0x1A000000),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_outward_rounded,
              color: homeViewModel.primaryTextColor,
              size: 16,
            ),
          ),
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
