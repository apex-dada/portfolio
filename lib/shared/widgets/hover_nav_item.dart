import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/shared/widgets/hover_nav_item_viewmodel.dart';

class HoverNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isDarkMode;
  final bool isActive;
  final Color? activeColor;

  const HoverNavItem({
    required this.label,
    required this.onTap,
    required this.isDarkMode,
    this.isActive = false,
    this.activeColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode ? Colors.white : Colors.black;
    final hoveredColor = isDarkMode ? const Color(0x99FFFFFF) : const Color(0x99000000);
    final resolvedActiveColor = activeColor ?? (isDarkMode ? const Color(0xFF3DDC84) : const Color(0xFF007AFF));

    return ChangeNotifierProvider(
      create: (_) => HoverNavItemViewModel(),
      child: Consumer<HoverNavItemViewModel>(
        builder: (context, viewModel, _) {
          final textColor = (isActive || viewModel.isHovered) ? baseColor : hoveredColor;

          return MouseRegion(
            onEnter: (_) => viewModel.setHovered(true),
            onExit: (_) => viewModel.setHovered(false),
            cursor: SystemMouseCursors.none,
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: GoogleFonts.outfit(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    child: Text(label),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 6, // Stable height to prevent vertical shifting
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                        width: isActive
                            ? 6.0
                            : (viewModel.isHovered ? 24.0 : 0.0),
                        height: isActive ? 6.0 : 2.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(isActive ? 99 : 1),
                          color: resolvedActiveColor,
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: resolvedActiveColor.withValues(alpha: 0.6),
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
