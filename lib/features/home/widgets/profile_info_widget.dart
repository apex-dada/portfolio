import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('refresh');
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    // Subtle lighting glow effect (spotlight) using low-opacity accent color
    // Dark mode: very soft cyan/blue glow (6% opacity)
    // Light mode: very soft amber/gold glow (6% opacity)
    final accentGlowColor = isDark 
        ? const Color(0x0F40C4FF) 
        : const Color(0x0FDF9F00);
        
    final baseGradient = isDark
        ? const RadialGradient(
            center: Alignment(-0.6, -0.6),
            radius: 1.3,
            colors: [
              Color(0xFF1E1E1E),
              Color(0xFF101010),
            ],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF5F5F7),
            ],
          );

    return BentoCard(
      backgroundGradient: baseGradient,
      borderWidth: 2.2, // Thicker border for hero visual weight
      borderColor: isDark ? const Color(0xFF333333) : const Color(0xFFCCCCCC),
      hoverBorderColor: isDark ? const Color(0xFF555555) : const Color(0xFF999999),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      shadows: [
        BoxShadow(
          color: isDark ? const Color(0x66000000) : const Color(0x1F7F7F7F),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
      child: Stack(
        children: [
          // Subtle lighting spotlight layer
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.8, -0.8),
                  radius: 1.1,
                  colors: [
                    accentGlowColor,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Hero Content
          Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "FLUTTER DEVELOPER",
                    style: GoogleFonts.outfit(
                      color: isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 16), // Increased spacing
                  Text(
                    "Hi, I'm Kazi Woaej Mariz",
                    style: GoogleFonts.outfit(
                      color: primaryTextColor,
                      fontSize: 34, // Large Display size
                      fontWeight: FontWeight.w800, // Display weight (700-800)
                      letterSpacing: -1.0,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 18), // Increased spacing
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480), // Reduced paragraph width for readability
                    child: Text(
                      "Mobile application developer, building high-quality Android & iOS experiences based in Bangladesh.",
                      style: GoogleFonts.inter(
                        color: secondaryTextColor,
                        fontSize: 15, // Body size
                        height: 1.5, // Line height for readability
                        fontWeight: FontWeight.w400, // Body weight
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
