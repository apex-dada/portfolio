import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class IndustrialShowcaseCard extends StatefulWidget {
  const IndustrialShowcaseCard({super.key});

  @override
  State<IndustrialShowcaseCard> createState() => _IndustrialShowcaseCardState();
}

class _IndustrialShowcaseCardState extends State<IndustrialShowcaseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFECEFF4);
    const darkNavy = Color(0xFF1E2837);
    const periwinkle = Color(0xFF8EAFD1);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: offWhite,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? const Color(0x338EAFD1)
                  : Colors.black.withValues(alpha: 0.15),
              blurRadius: _isHovered ? 24 : 12,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Action Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Circular Dark Action Button
                InkWell(
                  onTap: () => context.go('/projects'),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFF11141A),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),

                // Floating Periwinkle Pill Badge with Avatar
                Container(
                  padding: const EdgeInsets.only(left: 14, right: 6, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: periwinkle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Delivering Your Success",
                        style: GoogleFonts.plusJakartaSans(
                          color: darkNavy,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/IMG_0741 (1).jpg',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Industrial Container Visual Frame
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFD4DAE2),
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Corrugated Container Background (Two-tone vertical split)
                      Row(
                        children: [
                          // Left half: Off-White / Steel
                          Expanded(
                            flex: 48,
                            child: Container(
                              color: const Color(0xFFF7F9FC),
                              child: _buildCorrugationLines(const Color(0xFFE2E7EE)),
                            ),
                          ),
                          // Right half: Deep Marine Slate Navy
                          Expanded(
                            flex: 52,
                            child: Container(
                              color: const Color(0xFF223043),
                              child: _buildCorrugationLines(const Color(0xFF1B2737)),
                            ),
                          ),
                        ],
                      ),

                      // Overlay Content & Typography
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Big Brand Title Across Container
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mariz",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF1E2837),
                                    letterSpacing: -1.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4, left: 4),
                                  child: Text(
                                    "®",
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E2837),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // Geometric Symbol on Dark Half
                                _buildWhiteGeometricMonogram(),
                              ],
                            ),

                            // Subtitle and Year Info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "Navigating the World of\nMobile Apps with Confidence",
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF4B5563),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Since",
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "2023",
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorrugationLines(Color lineColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = (constraints.maxWidth / 14).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(count, (index) {
            return Container(
              width: 2,
              height: double.infinity,
              color: lineColor,
            );
          }),
        );
      },
    );
  }

  Widget _buildWhiteGeometricMonogram() {
    return SizedBox(
      width: 44,
      height: 44,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 2.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
