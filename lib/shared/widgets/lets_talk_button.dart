import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/provider/hover_provider.dart';

class LetsTalkButton extends StatelessWidget {
  final VoidCallback onTap;

  const LetsTalkButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HoverProvider(),
      child: Consumer<HoverProvider>(
        builder: (context, hoverProvider, _) {
          final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
          final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
          final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);
          final isHovered = hoverProvider.isHovered;

          return MouseRegion(
            onEnter: (_) => hoverProvider.setHovered(true),
            onExit: (_) => hoverProvider.setHovered(false),
            cursor: SystemMouseCursors.none,
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: GoogleFonts.inter(
                      color: isHovered ? accentColor : primaryTextColor,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                    child: const Text("Let's Talk"),
                  ),
                  const SizedBox(width: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.only(left: isHovered ? 4.0 : 0.0),
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                      color: isHovered ? accentColor : primaryTextColor,
                      size: 18,
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
