import 'package:flutter/material.dart';
import 'package:portfolio/features/projects/widgets/project_carousel_card.dart';

class ProjectBanglaFilmPicksCard extends StatelessWidget {
  const ProjectBanglaFilmPicksCard({super.key});

  static const List<String> _screenshots = [
    'assets/images/bangla_film_picks/bangla_movie_pick_4.webp',
    'assets/images/bangla_film_picks/mov1.webp',
    'assets/images/bangla_film_picks/mov2.webp',
    'assets/images/bangla_film_picks/mov3.webp',
    'assets/images/bangla_film_picks/mov4.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return const ProjectCarouselCard(
      projectNumber: "01",
      title: "Flutter App: Bangla Film Picks",
      icon: Icons.movie_filter_rounded,
      screenshots: _screenshots,
    );
  }
}

