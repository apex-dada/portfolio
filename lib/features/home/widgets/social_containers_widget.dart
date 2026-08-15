import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class SocialContainersWidget extends StatelessWidget {
  const SocialContainersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);

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
                    backgroundColor: cardColor,
                    borderColor: borderColor,
                    hoverBorderColor: hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://www.facebook.com/kazi.woaej.mariz/'),
                    child: Center(
                      child: Icon(
                        Icons.facebook_rounded,
                        color: primaryTextColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Instagram
                Expanded(
                  child: BentoCard(
                    backgroundColor: cardColor,
                    borderColor: borderColor,
                    hoverBorderColor: hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://www.instagram.com/kazi_woaej/'),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: primaryTextColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // LinkedIn
                Expanded(
                  child: BentoCard(
                    backgroundColor: cardColor,
                    borderColor: borderColor,
                    hoverBorderColor: hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => context.read<HomeViewModel>().launchURL(
                      context,
                      'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/',
                    ),
                    child: Center(
                      child: Text(
                        "in",
                        style: TextStyle(
                          color: primaryTextColor,
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
                    backgroundColor: cardColor,
                    borderColor: borderColor,
                    hoverBorderColor: hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada'),
                    child: Center(
                      child: Icon(
                        Icons.code_rounded,
                        color: primaryTextColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Email
                Expanded(
                  child: BentoCard(
                    backgroundColor: cardColor,
                    borderColor: borderColor,
                    hoverBorderColor: hoverBorderColor,
                    padding: EdgeInsets.zero,
                    onTap: () => context.read<HomeViewModel>().sendEmail(context),
                    child: Center(
                      child: Icon(
                        Icons.mail_outline_rounded,
                        color: primaryTextColor,
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
