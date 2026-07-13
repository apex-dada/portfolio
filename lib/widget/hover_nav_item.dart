import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/hover_nav_item_viewmodel.dart';

class HoverNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isDarkMode;

  const HoverNavItem({
    required this.label,
    required this.onTap,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode ? Colors.white : Colors.black;
    final hoveredColor = isDarkMode ? const Color(0x99FFFFFF) : const Color(0x99000000);

    return ChangeNotifierProvider(
      create: (_) => HoverNavItemViewModel(),
      child: Consumer<HoverNavItemViewModel>(
        builder: (context, viewModel, _) {
          final color = viewModel.isHovered ? baseColor : hoveredColor;

          return MouseRegion(
            onEnter: (_) => viewModel.setHovered(true),
            onExit: (_) => viewModel.setHovered(false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
                child: Text(label),
              ),
            ),
          );
        },
      ),
    );
  }
}
