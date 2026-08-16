import 'package:flutter/material.dart';
import 'package:portfolio/shared/widgets/editorial_top_bar.dart';
import 'package:portfolio/features/projects/widgets/project_tech_stack_card.dart';
import 'package:portfolio/features/projects/widgets/project_overview_card.dart';
import 'package:portfolio/features/projects/widgets/project_carousel_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  static const List<String> _banglaFilmPicksScreenshots = [
    'assets/images/bangla_film_picks/bangla_movie_pick_4.webp',
    'assets/images/bangla_film_picks/mov1.webp',
    'assets/images/bangla_film_picks/mov2.webp',
    'assets/images/bangla_film_picks/mov3.webp',
    'assets/images/bangla_film_picks/mov4.webp',
  ];

  static const List<String> _sudokuScreenshots = [
    'assets/images/sudoku/1_.webp',
    'assets/images/sudoku/2_.webp',
    'assets/images/sudoku/3_.webp',
    'assets/images/sudoku/4_.webp',
    'assets/images/sudoku/5_.webp',
    'assets/images/sudoku/6_.webp',
    'assets/images/sudoku/7_.webp',
    'assets/images/sudoku/8_.webp',
    'assets/images/sudoku/9_.webp',
    'assets/images/sudoku/10_.webp',
  ];

  static const List<String> _nestkeeperScreenshots = [
    'assets/images/nestkeeper/nest_keeper_1.webp',
    'assets/images/nestkeeper/nest_keeper_2.webp',
    'assets/images/nestkeeper/nest_keeper_3.webp',
    'assets/images/nestkeeper/nest_keeper_4.webp',
    'assets/images/nestkeeper/nest_keeper_5.webp',
    'assets/images/nestkeeper/nest_keeper_6.webp',
    'assets/images/nestkeeper/nest_keeper_7.webp',
    'assets/images/nestkeeper/nest_keeper_8.webp',
    'assets/images/nestkeeper/nest_keeper_9.webp',
    'assets/images/nestkeeper/nest_keeper_10.webp',
  ];

  Widget buildBody(Size size, bool isMobile) {
    final projectCardHeight = isMobile ? 500.0 : 480.0;
    final paddingHorizontal = isMobile ? 16.0 : 32.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Project 1: Bangla Film Picks
          SizedBox(
            height: projectCardHeight,
            width: double.infinity,
            child: const ProjectCarouselCard(
              projectNumber: "01",
              title: "Flutter App: Bangla Film Picks",
              icon: Icons.movie_filter_rounded,
              screenshots: _banglaFilmPicksScreenshots,
            ),
          ),
          const SizedBox(height: 24),

          // Project 2: NestKeeper
          SizedBox(
            height: projectCardHeight,
            width: double.infinity,
            child: const ProjectCarouselCard(
              projectNumber: "02",
              title: "Flutter App: NestKeeper",
              icon: Icons.flutter_dash,
              screenshots: _nestkeeperScreenshots,
            ),
          ),
          const SizedBox(height: 24),

          // Project 3: Sudoku
          SizedBox(
            height: projectCardHeight,
            width: double.infinity,
            child: const ProjectCarouselCard(
              projectNumber: "03",
              title: "Flutter Game: Sudoku",
              icon: Icons.grid_on_rounded,
              screenshots: _sudokuScreenshots,
            ),
          ),
          const SizedBox(height: 24),

          // Project Philosophy Overview
          const SizedBox(
            width: double.infinity,
            child: ProjectOverviewCard(),
          ),
          const SizedBox(height: 24),

          // Tech Stack
          const SizedBox(
            height: 240,
            width: double.infinity,
            child: ProjectTechStackCard(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0E),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  children: [
                    EditorialTopBar(
                      isMobile: isMobile,
                      isProjectsPage: true,
                    ),
                    buildBody(size, isMobile),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
