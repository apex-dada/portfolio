import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class HomeGithubCard extends StatelessWidget {
  const HomeGithubCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    Widget buildStatChip(String label, String value) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0x33FFFFFF) : const Color(0x1F000000),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1F000000),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: isDark ? Colors.white54 : Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              value,
              style: GoogleFonts.inter(
                color: accentColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.all(20),
      onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.code_rounded, size: 16, color: accentColor),
                  const SizedBox(width: 6),
                  Text(
                    "OPEN SOURCE & GITHUB",
                    style: GoogleFonts.outfit(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.north_east_rounded,
                size: 14,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Building & contributing to open-source Flutter projects.",
            style: GoogleFonts.inter(
              color: primaryTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              buildStatChip("GitHub", "@apex-dada"),
              buildStatChip("Repositories", "Public"),
              buildStatChip("Focus", "Flutter / Dart"),
            ],
          ),
        ],
      ),
    );
  }
}
