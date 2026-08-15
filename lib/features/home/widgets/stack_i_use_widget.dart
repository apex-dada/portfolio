import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/home/widgets/logo_carousel.dart';

class StackIUseWidget extends StatelessWidget {
  const StackIUseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
            child: Text(
              "Stack I use",
              style: TextStyle(
                color: homeViewModel.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: Center(
              child: LogoCarousel(),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
