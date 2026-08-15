import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class PortfolioMockupOneWidget extends StatelessWidget {
  const PortfolioMockupOneWidget({super.key});

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
          'assets/images/bangla_film_picks/bangla_movie_pick_4.jpg',
          fit: BoxFit.cover,
          cacheWidth: 800,
        ),
      ),
    );
  }
}
