import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class TechStackWidget extends StatelessWidget {
  const TechStackWidget({super.key});

  static const List<String> _stackItems = [
    "Flutter",
    "Dart",
    "Android",
    "iOS",
    "Bloc",
    "Riverpod",
    "Firebase",
    "Supabase",
    "SQLite",
    "Drift",
    "Git",
    "GitHub",
    "Play Store",
    "App Store",
    "Android Studio",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);

    final greenAccent = isDark ? const Color(0xFF3DDC84) : const Color(0xFF16A34A);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Text(
            "Tech Stack",
            style: GoogleFonts.outfit(
              color: greenAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Stack Tags Wrap
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _stackItems.map((name) {
                      return BentoCard(
                        backgroundColor: isDark ? const Color(0xFF1E2129) : const Color(0xFFF1F5F9),
                        borderColor: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                        hoverBorderColor: isDark ? const Color(0x33FFFFFF) : const Color(0xFFCBD5E1),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text(
                          name,
                          style: GoogleFonts.inter(
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
