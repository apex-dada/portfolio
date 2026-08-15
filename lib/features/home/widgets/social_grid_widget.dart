import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class SocialGridWidget extends StatelessWidget {
  const SocialGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);

    final iconColor = isDark ? Colors.white.withValues(alpha: 0.85) : Colors.black87;

    final socialItems = [
      {
        'name': 'Facebook',
        'widget': Icon(Icons.facebook_rounded, size: 20, color: iconColor),
        'url': 'https://www.facebook.com/kazi.woaej.mariz/',
      },
      {
        'name': 'Instagram',
        'widget': Icon(Icons.camera_alt_outlined, size: 20, color: iconColor),
        'url': 'https://www.instagram.com/kazi_woaej/',
      },
      {
        'name': 'LinkedIn',
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
        'url': 'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/',
      },
      {
        'name': 'GitHub',
        'widget': Icon(Icons.code_rounded, size: 20, color: iconColor),
        'url': 'https://github.com/apex-dada',
      },
      {
        'name': 'Email',
        'widget': Icon(Icons.mail_outline_rounded, size: 20, color: iconColor),
        'url': 'mailto:woaejmariz@gmail.com',
      },
      {
        'name': 'Discord',
        'widget': Icon(Icons.discord, size: 20, color: iconColor),
        'url': 'https://discord.gg',
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
                return Tooltip(
                  message: item['name'] as String,
                  child: BentoCard(
                    onTap: () {
                      context.read<HomeViewModel>().launchURL(context, item['url'] as String);
                    },
                    backgroundColor: cardColor,
                    borderColor: borderColor,
                    hoverBorderColor: hoverBorderColor,
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: item['widget'] as Widget,
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
