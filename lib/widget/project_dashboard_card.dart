import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class ProjectDashboardCard extends StatelessWidget {
  const ProjectDashboardCard({super.key});

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
          Positioned(
            left: 16,
            bottom: 16,
            child: SizedBox(
              height: 34,
              child: LiquidGlass.withOwnLayer(
                shape: LiquidRoundedRectangle(
                  borderRadius: 12,
                  side: BorderSide(
                    color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1F000000),
                    width: 1,
                  ),
                ),
                settings: LiquidGlassSettings(
                  blur: 12.0,
                  glassColor: isDark ? const Color(0x4D000000) : const Color(0x1AFFFFFF),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
