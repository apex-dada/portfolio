import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    Widget buildInfoRow(String title, String detail) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.outfit(
                color: secondaryTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              detail,
              style: GoogleFonts.inter(
                color: primaryTextColor,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return BentoCard(
      width: double.infinity,
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
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
          buildInfoRow("PRIMARY MAIL", "kaziwoaej@gmail.com"),
          Divider(color: borderColor.withValues(alpha: 0.5), height: 16),
          buildInfoRow("DISCORD", "woaej#0000"),
          Divider(color: borderColor.withValues(alpha: 0.5), height: 16),
          buildInfoRow("AVAILABILITY", "Open to Freelance & Full-time"),
        ],
      ),
    );
  }
}
