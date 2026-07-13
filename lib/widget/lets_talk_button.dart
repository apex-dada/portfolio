import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';

class LetsTalkButton extends StatefulWidget {
  final VoidCallback onTap;

  const LetsTalkButton({required this.onTap, super.key});

  @override
  State<LetsTalkButton> createState() => _LetsTalkButtonState();
}

class _LetsTalkButtonState extends State<LetsTalkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: GoogleFonts.inter(
                color: _isHovered ? accentColor : homeViewModel.primaryTextColor,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
              child: const Text("Let's Talk"),
            ),
            const SizedBox(width: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.only(left: _isHovered ? 4.0 : 0.0),
              child: Icon(
                Icons.arrow_right_alt_rounded,
                color: _isHovered ? accentColor : homeViewModel.primaryTextColor,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
