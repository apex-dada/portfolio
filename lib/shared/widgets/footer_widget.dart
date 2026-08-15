import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: isDark ? Colors.white12 : Colors.black12,
            height: 1,
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 600;
              if (isSmall) {
                return Column(
                  children: [
                    Text(
                      "© ${DateTime.now().year} Kazi Woaej Mariz. All rights reserved.",
                      style: GoogleFonts.inter(
                        color: secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Built with ",
                          style: GoogleFonts.inter(
                            color: secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image.asset(
                          'assets/stack/flutter.png',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Flutter Web",
                          style: GoogleFonts.inter(
                            color: isDark ? Colors.white : Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Built with ",
                        style: GoogleFonts.inter(
                          color: secondaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image.asset(
                        'assets/stack/flutter.png',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Flutter Web",
                        style: GoogleFonts.inter(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
