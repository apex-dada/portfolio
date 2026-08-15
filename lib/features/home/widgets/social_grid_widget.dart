import 'package:flutter/material.dart';
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

    final socialItems = [
      {
        'icon': Icons.alternate_email_rounded,
        'url': 'https://twitter.com',
        'tooltip': 'Twitter / X',
      },
      {
        'icon': Icons.language_rounded,
        'url': 'https://github.com/apex-dada',
        'tooltip': 'Website',
      },
      {
        'icon': Icons.camera_alt_rounded,
        'url': 'https://instagram.com',
        'tooltip': 'Instagram',
      },
      {
        'icon': Icons.work_rounded,
        'url': 'https://linkedin.com',
        'tooltip': 'LinkedIn',
      },
      {
        'icon': Icons.code_rounded,
        'url': 'https://github.com/apex-dada',
        'tooltip': 'GitHub',
      },
      {
        'icon': Icons.email_rounded,
        'url': 'mailto:woaejmariz@gmail.com',
        'tooltip': 'Email',
      },
    ];

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.25,
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
                        color: isDark ? const Color(0xFF22252F) : const Color(0xFFEBEFF5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? const Color(0x22FFFFFF) : const Color(0x1F000000),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          item['icon'] as IconData,
                          size: 18,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
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
