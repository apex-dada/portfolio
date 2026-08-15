import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class HighlightsBarWidget extends StatelessWidget {
  const HighlightsBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    Widget buildItem({
      required IconData icon,
      required String value,
      required String label,
    }) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: greenAccent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 14, color: greenAccent),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    color: primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: 10,
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
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 600;

          if (isSmall) {
            return Column(
              children: [
                Row(
                  children: [
                    buildItem(icon: Icons.code_rounded, value: "3+", label: "Years Experience"),
                    buildItem(icon: Icons.inventory_2_rounded, value: "10+", label: "Projects Completed"),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    buildItem(icon: Icons.groups_rounded, value: "10+", label: "Happy Clients"),
                    buildItem(icon: Icons.bolt_rounded, value: "60+ FPS", label: "Smooth UI Performance"),
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              buildItem(icon: Icons.code_rounded, value: "3+", label: "Years Experience"),
              Container(width: 1, height: 32, color: isDark ? Colors.white10 : Colors.black12),
              buildItem(icon: Icons.inventory_2_rounded, value: "10+", label: "Projects Completed"),
              Container(width: 1, height: 32, color: isDark ? Colors.white10 : Colors.black12),
              buildItem(icon: Icons.groups_rounded, value: "10+", label: "Happy Clients"),
              Container(width: 1, height: 32, color: isDark ? Colors.white10 : Colors.black12),
              buildItem(icon: Icons.bolt_rounded, value: "60+ FPS", label: "Smooth UI Performance"),
            ],
          );
        },
      ),
    );
  }
}
