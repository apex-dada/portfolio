import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';

class AboutTimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final bool isLast;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? dateColor;
  final Color? dotColor;
  final Color? lineColor;

  const AboutTimelineItem({
    required this.title,
    required this.subtitle,
    required this.date,
    this.isLast = false,
    this.titleColor,
    this.subtitleColor,
    this.dateColor,
    this.dotColor,
    this.lineColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final fallbackBorderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final fallbackPrimaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final fallbackSecondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);
    final fallbackAccentColor = isDark ? HomeViewModel.periwinkleBlue : const Color(0xFF1E2837);

    final resolvedTitleColor = titleColor ?? fallbackPrimaryTextColor;
    final resolvedSubtitleColor = subtitleColor ?? fallbackSecondaryTextColor;
    final resolvedDateColor = dateColor ?? (dotColor ?? fallbackAccentColor).withValues(alpha: 0.8);
    final resolvedDotColor = dotColor ?? fallbackAccentColor;
    final resolvedLineColor = lineColor ?? fallbackBorderColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: resolvedDotColor,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 42,
                color: resolvedLineColor,
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
                style: GoogleFonts.plusJakartaSans(
                  color: resolvedTitleColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: resolvedSubtitleColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.inter(
                  color: resolvedDateColor,
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
