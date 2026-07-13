import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class SocialContainers extends StatelessWidget {
  const SocialContainers({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();

    return SizedBox(
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Facebook
                Expanded(
                  child: BentoCard(
                    backgroundColor: homeViewModel.cardColor,
                    borderColor: homeViewModel.borderColor,
                    hoverBorderColor: homeViewModel.hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => homeViewModel.launchURL(context, 'https://www.facebook.com/kazi.woaej.mariz/'),
                    child: Center(
                      child: Icon(
                        Icons.facebook_rounded,
                        color: homeViewModel.primaryTextColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Instagram
                Expanded(
                  child: BentoCard(
                    backgroundColor: homeViewModel.cardColor,
                    borderColor: homeViewModel.borderColor,
                    hoverBorderColor: homeViewModel.hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => homeViewModel.launchURL(context, 'https://www.instagram.com/kazi_woaej/'),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: homeViewModel.primaryTextColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // LinkedIn
                Expanded(
                  child: BentoCard(
                    backgroundColor: homeViewModel.cardColor,
                    borderColor: homeViewModel.borderColor,
                    hoverBorderColor: homeViewModel.hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => homeViewModel.launchURL(
                      context,
                      'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/',
                    ),
                    child: Center(
                      child: Text(
                        "in",
                        style: TextStyle(
                          color: homeViewModel.primaryTextColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // GitHub
                Expanded(
                  child: BentoCard(
                    backgroundColor: homeViewModel.cardColor,
                    borderColor: homeViewModel.borderColor,
                    hoverBorderColor: homeViewModel.hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => homeViewModel.launchURL(context, 'https://github.com/apex-dada'),
                    child: Center(
                      child: Icon(
                        Icons.code_rounded,
                        color: homeViewModel.primaryTextColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Email
                Expanded(
                  child: BentoCard(
                    backgroundColor: homeViewModel.cardColor,
                    borderColor: homeViewModel.borderColor,
                    hoverBorderColor: homeViewModel.hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => homeViewModel.sendEmail(context),
                    child: Center(
                      child: Icon(
                        Icons.mail_outline_rounded,
                        color: homeViewModel.primaryTextColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
