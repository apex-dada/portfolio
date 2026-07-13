import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      onTap: () => homeViewModel.launchURL(
        context,
        'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/',
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0F0F2),
          border: Border.all(color: homeViewModel.borderColor),
        ),
        child: Icon(
          Icons.arrow_outward_rounded,
          color: homeViewModel.primaryTextColor,
          size: 16,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ABOUT ME",
            style: TextStyle(
              color: isDark ? Colors.white38 : Colors.black38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Passionate about mobile application development and enjoy solving complex user-experience problems.",
            style: TextStyle(
              color: homeViewModel.primaryTextColor,
              fontSize: 18.5,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
