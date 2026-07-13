import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    Widget buildInfoRow(String title, String detail, IconData icon) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: accentColor, size: 18),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: homeViewModel.secondaryTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  detail,
                  style: GoogleFonts.inter(
                    color: homeViewModel.primaryTextColor,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "QUICK DETAILS",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          buildInfoRow("📬 PRIMARY MAIL", "kaziwoaej@gmail.com", Icons.mail_outline_rounded),
          Divider(color: homeViewModel.borderColor.withOpacity(0.5), height: 16),
          buildInfoRow("💬 DISCORD", "woaej#0000", Icons.chat_bubble_outline_rounded),
          Divider(color: homeViewModel.borderColor.withOpacity(0.5), height: 16),
          buildInfoRow("⚡ AVAILABILITY", "Open to Freelance & Full-time", Icons.check_circle_outline_rounded),
        ],
      ),
    );
  }
}
