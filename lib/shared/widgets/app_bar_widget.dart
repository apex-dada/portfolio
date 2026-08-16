import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/hover_nav_item.dart';
import 'package:portfolio/shared/widgets/available_badge.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

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

  void _showMobileMenu(BuildContext context) {
    final isDark = context.read<HomeViewModel>().isDarkMode;
    final primaryTextColor = context.read<HomeViewModel>().primaryTextColor;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);
    final activeSection = context.read<HomeViewModel>().activeSection;
    final isSubPage = isAboutPage || isProjectsPage || isExperiencePage || isContactPage;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFA12141A) : const Color(0xFAF8F9FA),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.black12,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Navigation",
                        style: GoogleFonts.outfit(
                          color: primaryTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close_rounded, color: primaryTextColor),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  _buildMobileMenuItem(
                    context,
                    label: "Home",
                    icon: Icons.home_rounded,
                    isActive: activeSection == 'Home' && !isSubPage,
                    activeColor: accentColor,
                    primaryTextColor: primaryTextColor,
                    onTap: () {
                      Navigator.pop(context);
                      if (isSubPage) {
                        context.go('/');
                      } else {
                        context.read<HomeViewModel>().scrollToTop();
                      }
                    },
                  ),
                  _buildMobileMenuItem(
                    context,
                    label: "Projects",
                    icon: Icons.work_rounded,
                    isActive: isProjectsPage || activeSection == 'Projects',
                    activeColor: accentColor,
                    primaryTextColor: primaryTextColor,
                    onTap: () {
                      Navigator.pop(context);
                      if (!isProjectsPage) context.go('/projects');
                    },
                  ),
                  _buildMobileMenuItem(
                    context,
                    label: "Experience",
                    icon: Icons.timeline_rounded,
                    isActive: isExperiencePage || activeSection == 'Experience',
                    activeColor: accentColor,
                    primaryTextColor: primaryTextColor,
                    onTap: () {
                      Navigator.pop(context);
                      if (!isExperiencePage) context.go('/experience');
                    },
                  ),
                  _buildMobileMenuItem(
                    context,
                    label: "About",
                    icon: Icons.person_rounded,
                    isActive: isAboutPage || activeSection == 'About',
                    activeColor: accentColor,
                    primaryTextColor: primaryTextColor,
                    onTap: () {
                      Navigator.pop(context);
                      if (!isAboutPage) context.go('/about');
                    },
                  ),
                  _buildMobileMenuItem(
                    context,
                    label: "Contact",
                    icon: Icons.mail_rounded,
                    isActive: isContactPage || activeSection == 'Contact',
                    activeColor: accentColor,
                    primaryTextColor: primaryTextColor,
                    onTap: () {
                      Navigator.pop(context);
                      if (!isContactPage) context.go('/contact');
                    },
                  ),
                  const Divider(height: 24),
                  const Center(
                    child: AvailableBadge(),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isActive,
    required Color activeColor,
    required Color primaryTextColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: isActive ? activeColor.withValues(alpha: 0.15) : Colors.transparent,
        leading: Icon(
          icon,
          color: isActive ? activeColor : primaryTextColor,
          size: 22,
        ),
        title: Text(
          label,
          style: GoogleFonts.outfit(
            color: isActive ? activeColor : primaryTextColor,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          ),
        ),
        trailing: isActive
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeColor,
                ),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final activeSection = context.select<HomeViewModel, String>((vm) => vm.activeSection);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);
    
    final isSubPage = isAboutPage || isProjectsPage || isExperiencePage || isContactPage;

    final width = MediaQuery.of(context).size.width;
    final isMobileView = width < 900;
    
    final appBarPadding = isMobileView
        ? const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 4.0)
        : const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 4.0);

    Widget buildActions() {
      if (isMobileView) {
        return Builder(
          builder: (context) {
            return InkWell(
              onTap: () => _showMobileMenu(context),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0x26FFFFFF) : const Color(0x1F000000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.menu_rounded,
                  color: primaryTextColor,
                  size: 20,
                ),
              ),
            );
          },
        );
      }
      final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
      final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
      final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);

      return BentoCard(
        backgroundColor: cardColor,
        borderColor: borderColor,
        hoverBorderColor: hoverBorderColor,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: const AvailableBadge(),
      );
    }

    final appBarContent = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Container(
          height: 54.0,
          padding: EdgeInsets.symmetric(horizontal: isMobileView ? 16.0 : 24.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0x26FFFFFF) : const Color(0x1F000000),
              width: 1,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
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
                    cursor: SystemMouseCursors.none,
                    child: Text(
                      "Mariz.",
                      style: GoogleFonts.outfit(
                        color: primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
              if (!isMobileView)
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HoverNavItem(
                        label: 'Home',
                        isActive: activeSection == 'Home' && !isSubPage,
                        isDarkMode: isDark,
                        activeColor: accentColor,
                        onTap: () {
                          if (isSubPage) {
                            context.go('/');
                          } else {
                            context.read<HomeViewModel>().scrollToTop();
                          }
                        },
                      ),
                      const SizedBox(width: 28),
                      HoverNavItem(
                        label: 'Projects',
                        isActive: isProjectsPage || activeSection == 'Projects',
                        isDarkMode: isDark,
                        activeColor: accentColor,
                        onTap: () {
                          if (!isProjectsPage) {
                            context.go('/projects');
                          }
                        },
                      ),
                      const SizedBox(width: 28),
                      HoverNavItem(
                        label: 'Experience',
                        isActive: isExperiencePage || activeSection == 'Experience',
                        isDarkMode: isDark,
                        activeColor: accentColor,
                        onTap: () {
                          if (!isExperiencePage) {
                            context.go('/experience');
                          }
                        },
                      ),
                      const SizedBox(width: 28),
                      HoverNavItem(
                        label: 'About',
                        isActive: isAboutPage || activeSection == 'About',
                        isDarkMode: isDark,
                        activeColor: accentColor,
                        onTap: () {
                          if (!isAboutPage) {
                            context.go('/about');
                          }
                        },
                      ),
                      const SizedBox(width: 28),
                      HoverNavItem(
                        label: 'Contact',
                        isActive: isContactPage || activeSection == 'Contact',
                        isDarkMode: isDark,
                        activeColor: accentColor,
                        onTap: () {
                          if (!isContactPage) {
                            context.go('/contact');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: buildActions(),
              ),
            ],
          ),
        ),
      ),
    );

    return Padding(
      padding: appBarPadding,
      child: kIsWeb
          ? appBarContent
          : LiquidGlass.withOwnLayer(
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
              child: appBarContent,
            ),
    );
  }
}
