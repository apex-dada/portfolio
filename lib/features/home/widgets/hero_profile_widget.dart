import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class HeroProfileWidget extends StatelessWidget {
  const HeroProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;

        Widget leftContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Title
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 26 : 32,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                      color: primaryTextColor,
                    ),
                    children: const [
                      TextSpan(text: "Hi, I'm "),
                      TextSpan(
                        text: "Kazi Woaej Mariz",
                        style: TextStyle(color: greenAccent),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Bio Subtitle
                Text(
                  "Mobile application developer crafting high-performance Android & iOS experiences with clean code and thoughtful design.",
                  style: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: 13,
                    height: 1.45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            if (!isMobile) const Spacer(),
            if (isMobile) const SizedBox(height: 16),

            // Bottom Section (Action Buttons + Social Links)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Action Buttons
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    // Primary Green Button
                    ElevatedButton.icon(
                      onPressed: () => context.go('/projects'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 15, color: Colors.black),
                      label: Text(
                        "View Projects",
                        style: GoogleFonts.inter(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    // Outline Contact Me Button
                    OutlinedButton.icon(
                      onPressed: () => context.go('/contact'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryTextColor,
                        side: BorderSide(
                          color: isDark ? const Color(0x33FFFFFF) : const Color(0x33000000),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.send_rounded, size: 13, color: primaryTextColor),
                      label: Text(
                        "Contact Me",
                        style: GoogleFonts.inter(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );

        Widget rightPhoto = Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 235, maxHeight: 270),
            child: AspectRatio(
              aspectRatio: 0.85,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/IMG_0741 (1).jpg',
                  fit: BoxFit.cover,
                  cacheWidth: 600,
                ),
              ),
            ),
          ),
        );

        return BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: const EdgeInsets.all(26),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftContent,
                    const SizedBox(height: 24),
                    SizedBox(height: 240, child: rightPhoto),
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 7, child: leftContent),
                    const SizedBox(width: 20),
                    Expanded(flex: 3, child: rightPhoto),
                  ],
                ),
        );
      },
    );
  }
}
