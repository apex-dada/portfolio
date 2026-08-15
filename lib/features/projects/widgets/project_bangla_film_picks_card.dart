import 'package:flutter/material.dart';
import 'package:portfolio/features/projects/widgets/project_carousel_card.dart';

class ProjectBanglaFilmPicksCard extends StatelessWidget {
  const ProjectBanglaFilmPicksCard({super.key});

  static const List<String> _screenshots = [
    'assets/images/bangla_film_picks/bangla_movie_pick_4.jpg',
    'assets/images/bangla_film_picks/mov1.jpg',
    'assets/images/bangla_film_picks/mov2.jpg',
    'assets/images/bangla_film_picks/mov3.jpg',
    'assets/images/bangla_film_picks/mov4.jpg',
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

