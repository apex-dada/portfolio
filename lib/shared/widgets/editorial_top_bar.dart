import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/shared/widgets/available_badge.dart';

class EditorialTopBar extends StatelessWidget {
  final bool isMobile;
  final bool isAboutPage;
  final bool isProjectsPage;
  final bool isExperiencePage;
  final bool isContactPage;

  const EditorialTopBar({
    required this.isMobile,
    this.isAboutPage = false,
    this.isProjectsPage = false,
    this.isExperiencePage = false,
    this.isContactPage = false,
    super.key,
  });

  void _showMobileMenu(BuildContext context) {
    const darkNavy = Color(0xFF0D0F14);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: darkNavy,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border.all(
                color: Colors.white12,
                width: 1,
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
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                    ),
                  ],
                ),
                const Divider(color: Colors.white10, height: 24),
                _buildMenuItem(context, "Home", Icons.home_rounded, !isAboutPage && !isProjectsPage && !isExperiencePage && !isContactPage, () => context.go('/')),
                _buildMenuItem(context, "Projects", Icons.work_rounded, isProjectsPage, () => context.go('/projects')),
                _buildMenuItem(context, "Experience", Icons.timeline_rounded, isExperiencePage, () => context.go('/experience')),
                _buildMenuItem(context, "About", Icons.person_rounded, isAboutPage, () => context.go('/about')),
                _buildMenuItem(context, "Contact", Icons.mail_rounded, isContactPage, () => context.go('/contact')),
                const Divider(color: Colors.white10, height: 28),
                const Center(child: AvailableBadge()),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, String label, IconData icon, bool isActive, VoidCallback onTap) {
    const periwinkle = Color(0xFF8EAFD1);

    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      tileColor: isActive ? periwinkle.withValues(alpha: 0.15) : Colors.transparent,
      leading: Icon(icon, color: isActive ? periwinkle : Colors.white70),
      title: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          color: isActive ? periwinkle : Colors.white,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const periwinkle = Color(0xFF8EAFD1);
    const subtitleColor = Color(0xFF7E8A9B);

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.go('/'),
              child: Text(
                "Mariz.",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            InkWell(
              onTap: () => _showMobileMenu(context),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Logo
          GestureDetector(
            onTap: () => context.go('/'),
            child: Text(
              "Mariz.",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
              ),
            ),
          ),

          // Center Editorial Spaced Labels (Matching "Brand Design", "Halo Lab Team" from reference)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTopLink(context, "Projects", isProjectsPage, () => context.go('/projects')),
              const SizedBox(width: 36),
              _buildTopLink(context, "Experience", isExperiencePage, () => context.go('/experience')),
              const SizedBox(width: 36),
              _buildTopLink(context, "About", isAboutPage, () => context.go('/about')),
              const SizedBox(width: 36),
              _buildTopLink(context, "Contact", isContactPage, () => context.go('/contact')),
            ],
          ),

          // Right Status & Quick Action
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: periwinkle,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Dhaka, BD",
                style: GoogleFonts.inter(
                  color: subtitleColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopLink(BuildContext context, String title, bool isActive, VoidCallback onTap) {
    const periwinkle = Color(0xFF8EAFD1);

    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          color: isActive ? periwinkle : const Color(0xFF8A97A8),
          fontSize: 13.5,
          fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
    );
  }
}
