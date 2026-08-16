import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutFactItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const AboutFactItem({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const darkNavy = Color(0xFF1E2837);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: darkNavy, size: 18),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: darkNavy.withValues(alpha: 0.7),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  color: darkNavy,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
