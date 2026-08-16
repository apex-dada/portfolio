import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutValueItem extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;

  const AboutValueItem({
    required this.title,
    required this.desc,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const darkNavy = Color(0xFF1E2837);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: darkNavy, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: darkNavy,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: GoogleFonts.inter(
                    color: darkNavy.withValues(alpha: 0.8),
                    fontSize: 12.5,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
