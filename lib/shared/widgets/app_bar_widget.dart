import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/hover_nav_item.dart';
import 'package:portfolio/shared/widgets/available_badge.dart';

class AppBarWidget extends StatelessWidget {
  final bool isMobile;
  final bool isAboutPage;
  final bool isProjectsPage;
  final bool isExperiencePage;
  final bool isContactPage;

  const AppBarWidget({
    required this.isMobile,
    this.isAboutPage = false,
    this.isProjectsPage = false,
    this.isExperiencePage = false,
    this.isContactPage = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final activeSection = context.select<HomeViewModel, String>((vm) => vm.activeSection);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);
    
    final isSubPage = isAboutPage || isProjectsPage || isExperiencePage || isContactPage;

    final width = MediaQuery.of(context).size.width;
    final isMobileView = width < 600;
    final isTabletView = width >= 600 && width < 900;
    
    final appBarPadding = isMobileView
        ? const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 4.0)
        : (isTabletView
            ? const EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 4.0)
            : const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 4.0));

    Widget buildActions() {
      if (isMobileView) {
        return const SizedBox.shrink();
      }
      return const AvailableBadge();
    }

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
          height: 54.0, // Standard height since there is no stacked CTA button
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Logo (Align Left)
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (isSubPage) {
                      context.go('/');
                    } else {
                      context.read<HomeViewModel>().scrollToTop();
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "Mariz.",
                      style: GoogleFonts.outfit(
                        color: primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
              // Nav Items (Absolute Center - Desktop Only)
              if (!isMobile)
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HoverNavItem(
                        label: "Home",
                        isActive: !isSubPage && activeSection == "Home",
                        activeColor: accentColor,
                        isDarkMode: isDark,
                        onTap: () {
                          if (isSubPage) {
                            context.go('/');
                          } else {
                            context.read<HomeViewModel>().scrollToTop();
                          }
                        },
                      ),
                      const SizedBox(width: 28), // Improved spacing
                      HoverNavItem(
                        label: "Projects",
                        isActive: isProjectsPage,
                        activeColor: accentColor,
                        isDarkMode: isDark,
                        onTap: () {
                          if (!isProjectsPage) {
                            context.go('/projects');
                          }
                        },
                      ),
                      const SizedBox(width: 28),
                      HoverNavItem(
                        label: "Experience",
                        isActive: isExperiencePage,
                        activeColor: accentColor,
                        isDarkMode: isDark,
                        onTap: () {
                          if (!isExperiencePage) {
                            context.go('/experience');
                          }
                        },
                      ),
                      const SizedBox(width: 28),
                      HoverNavItem(
                        label: "About",
                        isActive: isAboutPage,
                        activeColor: accentColor,
                        isDarkMode: isDark,
                        onTap: () {
                          if (!isAboutPage) {
                            context.go('/about');
                          }
                        },
                      ),
                      const SizedBox(width: 28),
                      HoverNavItem(
                        label: "Contact",
                        isActive: isContactPage,
                        activeColor: accentColor,
                        isDarkMode: isDark,
                        onTap: () {
                          if (!isContactPage) {
                            context.go('/contact');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              // Actions (Align Right)
              Align(
                alignment: Alignment.centerRight,
                child: buildActions(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
