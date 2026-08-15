import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';

class AboutTimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final bool isLast;

  const AboutTimelineItem({
    required this.title,
    required this.subtitle,
    required this.date,
    this.isLast = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 42,
                color: homeViewModel.borderColor,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  color: homeViewModel.primaryTextColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: homeViewModel.secondaryTextColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.inter(
                  color: accentColor.withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
