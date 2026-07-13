import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/view/about_view.dart';
import 'package:portfolio/view/projects_view.dart';
import 'package:portfolio/view/experience_view.dart';
import 'package:portfolio/view/contact_view.dart';
import 'package:portfolio/widget/hover_nav_item.dart';

class AppBarSection extends StatelessWidget {
  final bool isMobile;
  final bool isAboutPage;
  final bool isProjectsPage;
  final bool isExperiencePage;
  final bool isContactPage;

  const AppBarSection({
    required this.isMobile,
    this.isAboutPage = false,
    this.isProjectsPage = false,
    this.isExperiencePage = false,
    this.isContactPage = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);
    
    final isSubPage = isAboutPage || isProjectsPage || isExperiencePage || isContactPage;

    void navigateToPage(BuildContext context, Widget page) {
      if (isSubPage) {
        Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      }
    }
    
    final appBarPadding = isMobile
        ? const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 4.0)
        : const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 4.0);

    Widget buildActions() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Theme Switch
          IconButton(
            onPressed: homeViewModel.toggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: homeViewModel.primaryTextColor,
              size: 20,
            ),
            splashRadius: 20,
            tooltip: "Toggle Theme",
          ),
          const SizedBox(width: 8),
          // Resume Button
          if (isMobile)
            IconButton(
              onPressed: () => homeViewModel.launchURL(context, 'https://github.com/apex-dada'),
              icon: Icon(
                Icons.file_download_outlined,
                color: accentColor,
                size: 20,
              ),
              tooltip: "Resume",
            )
          else
            ElevatedButton.icon(
              onPressed: () => homeViewModel.launchURL(context, 'https://github.com/apex-dada'),
              icon: const Icon(Icons.file_download_outlined, size: 16),
              label: const Text("Resume"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: accentColor,
                shadowColor: Colors.transparent,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: accentColor.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
              ),
            ),
        ],
      );
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
          height: 54, // Breathing room
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              GestureDetector(
                onTap: () {
                  if (isSubPage) {
                    Navigator.of(context).pop();
                  } else {
                    homeViewModel.scrollToTop();
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "Mariz.",
                    style: GoogleFonts.outfit(
                      color: homeViewModel.primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              // Nav Items (Desktop Only)
              if (!isMobile)
                Row(
                  children: [
                    HoverNavItem(
                      label: "Home",
                      isActive: !isSubPage && homeViewModel.activeSection == "Home",
                      activeColor: accentColor,
                      isDarkMode: isDark,
                      onTap: () {
                        if (isSubPage) {
                          Navigator.of(context).pop();
                        } else {
                          homeViewModel.scrollToTop();
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
                          navigateToPage(context, const ProjectsView());
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
                          navigateToPage(context, const ExperienceView());
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
                          navigateToPage(context, const AboutView());
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
                          navigateToPage(context, const ContactView());
                        }
                      },
                    ),
                  ],
                ),
              // Actions
              buildActions(),
            ],
          ),
        ),
      ),
    );
  }
}
