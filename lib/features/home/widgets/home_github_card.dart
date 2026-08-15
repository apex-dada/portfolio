import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class HomeGithubCard extends StatelessWidget {
  const HomeGithubCard({super.key});

  Widget _buildLegendBox(Color accentColor, bool isDark, int level) {
    Color boxColor;
    if (level == 0) {
      boxColor = isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08);
    } else if (level == 1) {
      boxColor = accentColor.withValues(alpha: 0.30);
    } else if (level == 2) {
      boxColor = accentColor.withValues(alpha: 0.55);
    } else if (level == 3) {
      boxColor = accentColor.withValues(alpha: 0.80);
    } else {
      boxColor = accentColor;
    }

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.grid_on_rounded, size: 14, color: accentColor),
                  const SizedBox(width: 6),
                  Text(
                    "GITHUB ACTIVITY",
                    style: GoogleFonts.outfit(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "@apex-dada",
                    style: GoogleFonts.inter(
                      color: accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.north_east_rounded,
                    size: 11,
                    color: accentColor,
                  ),
                ],
              ),
            ],
          ),

          // GitHub Contribution Heatmap Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: GithubContributionHeatmap(
                  accentColor: accentColor,
                  isDark: isDark,
                ),
              ),
            ),
          ),

          // Legend / Footer stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "500+ commits past year",
                style: GoogleFonts.inter(
                  color: isDark ? Colors.white54 : Colors.black54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Less ",
                    style: GoogleFonts.inter(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 9,
                    ),
                  ),
                  _buildLegendBox(accentColor, isDark, 0),
                  const SizedBox(width: 2),
                  _buildLegendBox(accentColor, isDark, 1),
                  const SizedBox(width: 2),
                  _buildLegendBox(accentColor, isDark, 2),
                  const SizedBox(width: 2),
                  _buildLegendBox(accentColor, isDark, 3),
                  const SizedBox(width: 2),
                  _buildLegendBox(accentColor, isDark, 4),
                  const SizedBox(width: 2),
                  Text(
                    " More",
                    style: GoogleFonts.inter(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GithubContributionHeatmap extends StatelessWidget {
  final Color accentColor;
  final bool isDark;

  const GithubContributionHeatmap({
    super.key,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // Deterministic commit activity levels for a realistic 7x22 contribution matrix
    const numCols = 21;
    const numRows = 7;
    final random = Random(42);

    return FittedBox(
      fit: BoxFit.contain,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(numRows, (row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 2.5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(numCols, (col) {
                // Generate realistic commit density (higher on weekdays, sprint peaks)
                int intensity;
                final val = (random.nextDouble() * 100).toInt();
                if (row == 0 || row == 6) {
                  // Weekends
                  intensity = val > 75 ? 2 : (val > 50 ? 1 : 0);
                } else {
                  // Weekdays
                  intensity = val > 80 ? 4 : (val > 55 ? 3 : (val > 30 ? 2 : (val > 15 ? 1 : 0)));
                }

                Color boxColor;
                if (intensity == 0) {
                  boxColor = isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.08);
                } else if (intensity == 1) {
                  boxColor = accentColor.withValues(alpha: 0.30);
                } else if (intensity == 2) {
                  boxColor = accentColor.withValues(alpha: 0.55);
                } else if (intensity == 3) {
                  boxColor = accentColor.withValues(alpha: 0.80);
                } else {
                  boxColor = accentColor;
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 2.5),
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

