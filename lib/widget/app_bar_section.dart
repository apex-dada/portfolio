import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/hover_nav_item.dart';

class AppBarSection extends StatelessWidget {
  final bool isMobile;

  const AppBarSection({required this.isMobile, super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    
    final appBarPadding = isMobile
        ? const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 4.0)
        : const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 4.0);

    return Padding(
      padding: appBarPadding,
      child: LiquidGlass.withOwnLayer(
        shape: const LiquidRoundedRectangle(
          borderRadius: 16,
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
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Text(
                "Mariz.",
                style: GoogleFonts.outfit(
                  color: homeViewModel.primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              // Nav Items
              Row(
                children: [
                  HoverNavItem(
                    label: "Home",
                    isDarkMode: homeViewModel.isDarkMode,
                    onTap: homeViewModel.scrollToTop,
                  ),
                  const SizedBox(width: 24),
                  HoverNavItem(
                    label: "Portfolio",
                    isDarkMode: homeViewModel.isDarkMode,
                    onTap: () => homeViewModel.scrollToKey(homeViewModel.portfolioKey),
                  ),
                  const SizedBox(width: 24),
                  HoverNavItem(
                    label: "Contact",
                    isDarkMode: homeViewModel.isDarkMode,
                    onTap: () => homeViewModel.scrollToKey(homeViewModel.contactKey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
