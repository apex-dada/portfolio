import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    const periwinkle = Color(0xFF8EAFD1);
    const darkNavy = Color(0xFF1E2837);

    Widget buildInfoRow(String title, String detail) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: darkNavy.withValues(alpha: 0.7),
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              detail,
              style: GoogleFonts.inter(
                color: darkNavy,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return BentoCard(
      width: double.infinity,
      backgroundColor: periwinkle,
      borderColor: Colors.transparent,
      hoverBorderColor: Colors.white70,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "QUICK DETAILS",
            style: GoogleFonts.plusJakartaSans(
              color: darkNavy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          buildInfoRow("PRIMARY MAIL", "kaziwoaej@gmail.com"),
          Divider(color: darkNavy.withValues(alpha: 0.15), height: 16),
          buildInfoRow("DISCORD", "woaej#0000"),
          Divider(color: darkNavy.withValues(alpha: 0.15), height: 16),
          buildInfoRow("AVAILABILITY", "Open to Freelance & Full-time"),
        ],
      ),
    );
  }
}
