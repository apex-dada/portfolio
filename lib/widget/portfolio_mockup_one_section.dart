import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class PortfolioMockupOneSection extends StatelessWidget {
  const PortfolioMockupOneSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();

    return BentoCard(
      key: homeViewModel.portfolioKey,
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: EdgeInsets.zero,
      onTap: () => homeViewModel.launchURL(context, 'https://github.com/apex-dada'),
      backgroundImage: Image.asset(
        'assets/images/phone_mockup.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
