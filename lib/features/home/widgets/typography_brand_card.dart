import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographyBrandCard extends StatefulWidget {
  const TypographyBrandCard({super.key});

  @override
  State<TypographyBrandCard> createState() => _TypographyBrandCardState();
}

class _TypographyBrandCardState extends State<TypographyBrandCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const periwinkle = Color(0xFF8EAFD1);
    const darkNavy = Color(0xFF1E2738);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -3.0 : 0.0, 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: periwinkle,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? periwinkle.withValues(alpha: 0.4) : Colors.black.withValues(alpha: 0.2),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 6 : 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Giant "Aa" Glyph
            Text(
              "Aa",
              style: GoogleFonts.plusJakartaSans(
                color: darkNavy,
                fontSize: 64,
                fontWeight: FontWeight.w800,
                letterSpacing: -2.5,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 16),

            // Typography & Stack Label
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Flutter & Dart",
                    style: GoogleFonts.plusJakartaSans(
                      color: darkNavy,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Clean MVVM",
                    style: GoogleFonts.inter(
                      color: darkNavy.withValues(alpha: 0.75),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Dual Swatch Color Pillars (White and Dark Slate)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: darkNavy,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
