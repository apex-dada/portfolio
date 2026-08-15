import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class PortfolioMockupTwoWidget extends StatelessWidget {
  const PortfolioMockupTwoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: EdgeInsets.zero,
      onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'assets/images/nestkeeper/nest_keeper_1.png',
          fit: BoxFit.cover,
          cacheWidth: 800,
        ),
      ),
    );
  }
}
