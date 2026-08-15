import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);

    return BentoCard(
      key: context.read<HomeViewModel>().aboutKey,
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      onTap: () => context.read<HomeViewModel>().launchURL(
        context,
        'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/',
      ),
      trailing: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.04),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_outward_rounded,
            color: primaryTextColor,
            size: 16,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ABOUT ME",
            style: GoogleFonts.outfit(
              color: isDark ? Colors.white38 : Colors.black38,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Curious about the person behind the code? Discover my background, values, and journey.",
            style: GoogleFonts.inter(
              color: primaryTextColor,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
