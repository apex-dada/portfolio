import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    final flutterSkyColor = isDark ? const Color(0xFF54C5F8) : const Color(0xFF02569B);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 600;
          if (isSmall) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "© ${DateTime.now().year} Kazi Woaej Mariz. All rights reserved.",
                  style: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      color: secondaryTextColor,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: "Built with "),
                      TextSpan(
                        text: "Flutter Web",
                        style: TextStyle(
                          color: flutterSkyColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "© ${DateTime.now().year} Kazi Woaej Mariz. All rights reserved.",
                style: GoogleFonts.inter(
                  color: secondaryTextColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    const TextSpan(text: "Built with "),
                    TextSpan(
                      text: "Flutter Web",
                      style: TextStyle(
                        color: flutterSkyColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
