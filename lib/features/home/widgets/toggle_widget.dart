import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ToggleWidget extends StatelessWidget {
  const ToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              homeViewModel.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: homeViewModel.primaryTextColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: homeViewModel.toggleTheme,
              child: SizedBox(
                width: 50,
                height: 28,
                child: LiquidGlass.withOwnLayer(
                  shape: LiquidRoundedRectangle(
                    borderRadius: 15,
                    side: BorderSide(
                      color: homeViewModel.borderColor,
                      width: 1.0,
                    ),
                  ),
                  settings: LiquidGlassSettings(
                    blur: 8.0,
                    glassColor: homeViewModel.isDarkMode ? const Color(0x1AFFFFFF) : const Color(0x1A000000),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      alignment: homeViewModel.isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: homeViewModel.primaryTextColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
