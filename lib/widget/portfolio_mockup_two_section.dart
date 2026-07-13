import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class PortfolioMockupTwoSection extends StatelessWidget {
  const PortfolioMockupTwoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: EdgeInsets.zero,
      onTap: () => homeViewModel.launchURL(context, 'https://github.com/apex-dada'),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/laptop_mockup.png',
              fit: BoxFit.cover,
            ),
          ),
          // Glassmorphic title tag overlay
          Positioned(
            left: 16,
            bottom: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0x66000000) : const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1F000000),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.laptop_chromebook_rounded,
                        color: homeViewModel.primaryTextColor,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "02 / Web App: Dashboard",
                        style: TextStyle(
                          color: homeViewModel.primaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
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
