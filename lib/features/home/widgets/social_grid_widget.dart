import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';

class SocialGridWidget extends StatelessWidget {
  const SocialGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final iconColor = isDark ? Colors.white.withValues(alpha: 0.85) : Colors.black87;

    final socialItems = [
      {
        'widget': Icon(Icons.flutter_dash_rounded, size: 20, color: iconColor),
        'url': 'https://twitter.com',
      },
      {
        'widget': Icon(Icons.language_rounded, size: 20, color: iconColor),
        'url': 'https://github.com/apex-dada',
      },
      {
        'widget': Icon(Icons.camera_alt_outlined, size: 20, color: iconColor),
        'url': 'https://instagram.com',
      },
      {
        'widget': Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: iconColor, width: 1.5),
          ),
          child: Text(
            "in",
            style: GoogleFonts.inter(
              color: iconColor,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
        'url': 'https://linkedin.com',
      },
      {
        'widget': Text(
          "Bē",
          style: GoogleFonts.outfit(
            color: iconColor,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        'url': 'https://behance.net',
      },
      {
        'widget': Icon(Icons.mail_outline_rounded, size: 20, color: iconColor),
        'url': 'mailto:woaejmariz@gmail.com',
      },
    ];

    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.15,
              ),
              itemCount: socialItems.length,
              itemBuilder: (context, index) {
                final item = socialItems[index];
                return GestureDetector(
                  onTap: () {
                    context.read<HomeViewModel>().launchURL(context, item['url'] as String);
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1B1E26) : const Color(0xFFE4E8F0),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1F000000),
                        ),
                      ),
                      child: Center(
                        child: item['widget'] as Widget,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
