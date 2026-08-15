import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class NewsletterWidget extends StatelessWidget {
  const NewsletterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    return BentoCard(
      key: homeViewModel.contactKey,
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CONTACT",
            style: GoogleFonts.outfit(
              color: isDark ? Colors.white38 : Colors.black38,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Have a project in mind?",
            style: GoogleFonts.outfit(
              color: homeViewModel.primaryTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w700, // Section title weight (600-700)
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final useColumn = constraints.maxWidth < 280;
              if (useColumn) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 40,
                      child: LiquidGlass.withOwnLayer(
                        shape: LiquidRoundedRectangle(
                          borderRadius: 12,
                          side: BorderSide(
                            color: homeViewModel.borderColor,
                            width: 1.0,
                          ),
                        ),
                        settings: LiquidGlassSettings(
                          blur: 8.0,
                          glassColor: isDark ? const Color(0x1F000000) : const Color(0x0FFFFFFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              style: GoogleFonts.inter(
                                color: homeViewModel.primaryTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: "Your email address",
                                hintStyle: GoogleFonts.inter(
                                  color: homeViewModel.secondaryTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => homeViewModel.showSnackBar(context, "Project request sent successfully!"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: homeViewModel.primaryTextColor,
                        foregroundColor: isDark ? Colors.black : Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Send",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, // Button label weight
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: LiquidGlass.withOwnLayer(
                        shape: LiquidRoundedRectangle(
                          borderRadius: 12,
                          side: BorderSide(
                            color: homeViewModel.borderColor,
                            width: 1.0,
                          ),
                        ),
                        settings: LiquidGlassSettings(
                          blur: 8.0,
                          glassColor: isDark ? const Color(0x1F000000) : const Color(0x0FFFFFFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              style: GoogleFonts.inter(
                                color: homeViewModel.primaryTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: "Your email address",
                                hintStyle: GoogleFonts.inter(
                                  color: homeViewModel.secondaryTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => homeViewModel.showSnackBar(context, "Project request sent successfully!"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: homeViewModel.primaryTextColor,
                      foregroundColor: isDark ? Colors.black : Colors.white,
                      elevation: 0,
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Send",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, // Button label weight
                        fontSize: 14,
                      ),
                    ),
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
