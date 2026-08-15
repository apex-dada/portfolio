import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class TechStackWidget extends StatelessWidget {
  const TechStackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    final stackItems = [
      "Flutter", "Dart", "Bloc", "Riverpod",
      "Firebase", "Supabase", "REST API",
      "Git", "GitHub", "VS Code", "Linux"
    ];

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Row(
            children: [
              const Icon(Icons.terminal_rounded, size: 16, color: greenAccent),
              const SizedBox(width: 8),
              Text(
                "Tech Stack",
                style: GoogleFonts.outfit(
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stack Tags Wrap
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: stackItems.map((tech) {
                  final isFlutter = tech == "Flutter";
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isFlutter
                          ? greenAccent.withValues(alpha: 0.15)
                          : (isDark ? const Color(0x33FFFFFF) : const Color(0x1F000000)),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isFlutter
                            ? greenAccent.withValues(alpha: 0.4)
                            : (isDark ? Colors.white12 : Colors.black12),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: GoogleFonts.inter(
                        color: isFlutter ? greenAccent : (isDark ? Colors.white70 : Colors.black87),
                        fontSize: 11,
                        fontWeight: isFlutter ? FontWeight.bold : FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
