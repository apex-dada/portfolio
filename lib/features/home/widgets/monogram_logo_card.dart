import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonogramLogoCard extends StatefulWidget {
  const MonogramLogoCard({super.key});

  @override
  State<MonogramLogoCard> createState() => _MonogramLogoCardState();
}

class _MonogramLogoCardState extends State<MonogramLogoCard> {
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bold Editorial Name + Registered Trademark
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mariz",
                  style: GoogleFonts.plusJakartaSans(
                    color: darkNavy,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 2.0),
                  child: Text(
                    "®",
                    style: GoogleFonts.inter(
                      color: darkNavy,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Geometric Brand Monogram Symbol (4-square grid / dynamic block)
            _buildGeometricSymbol(darkNavy),
          ],
        ),
      ),
    );
  }

  Widget _buildGeometricSymbol(Color color) {
    return SizedBox(
      width: 32,
      height: 32,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(3)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(3)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: color, width: 2),
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(3)),
            ),
          ),
        ],
      ),
    );
  }
}
