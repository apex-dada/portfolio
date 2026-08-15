import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class PortfolioMockupOneWidget extends StatelessWidget {
  const PortfolioMockupOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: EdgeInsets.zero,
      onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada'),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/phone_mockup.png',
              fit: BoxFit.cover,
              cacheWidth: 800,
            ),
          ),
          // Clean frosted title tag overlay
          Positioned(
            left: 16,
            bottom: 16,
            child: LiquidGlass.withOwnLayer(
              shape: const LiquidRoundedRectangle(
                borderRadius: 12,
                side: BorderSide(
                  color: Color(0x1F000000),
                  width: 1,
                ),
              ),
              settings: const LiquidGlassSettings(
                blur: 16.0,
                glassColor: Colors.transparent,
              ),
              child: Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0x55000000) : const Color(0x77FFFFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.phone_iphone_rounded,
                      color: primaryTextColor,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "01 / iOS App: Taskly",
                      style: TextStyle(
                        color: primaryTextColor,
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
        ],
      ),
    );
  }
}
