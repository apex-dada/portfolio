import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class ContactFormCard extends StatelessWidget {
  const ContactFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CONTACT FORM",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Have a project in mind? Let's connect.",
            style: GoogleFonts.outfit(
              color: homeViewModel.primaryTextColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final useColumn = constraints.maxWidth < 320;
              if (useColumn) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 44,
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => homeViewModel.showSnackBar(context, "Project request sent successfully!"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: homeViewModel.primaryTextColor,
                        foregroundColor: isDark ? Colors.black : Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Send",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
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
                      height: 44,
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
                      minimumSize: const Size(100, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Send",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
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
