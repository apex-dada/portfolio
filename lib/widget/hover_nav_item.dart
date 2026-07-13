import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/hover_nav_item_viewmodel.dart';

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
            cursor: SystemMouseCursors.click,
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
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isActive ? 1.0 : 0.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: isActive ? 5 : 0,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: resolvedActiveColor,
                        boxShadow: [
                          BoxShadow(
                            color: resolvedActiveColor.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
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
