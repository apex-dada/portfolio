import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/shared/widgets/auto_hiding_header.dart';
import 'package:portfolio/shared/widgets/video_background.dart';
import 'package:portfolio/features/projects/widgets/project_tech_stack_card.dart';
import 'package:portfolio/features/projects/widgets/project_overview_card.dart';
import 'package:portfolio/features/projects/widgets/project_carousel_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  static const List<String> _banglaFilmPicksScreenshots = [
    'assets/images/bangla_film_picks/bangla_movie_pick_4.jpg',
    'assets/images/bangla_film_picks/mov1.jpg',
    'assets/images/bangla_film_picks/mov2.jpg',
    'assets/images/bangla_film_picks/mov3.jpg',
    'assets/images/bangla_film_picks/mov4.jpg',
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
    'assets/images/nestkeeper/nest_keeper_1.png',
    'assets/images/nestkeeper/nest_keeper_2.png',
    'assets/images/nestkeeper/nest_keeper_3.png',
    'assets/images/nestkeeper/nest_keeper_4.png',
    'assets/images/nestkeeper/nest_keeper_5.png',
    'assets/images/nestkeeper/nest_keeper_6.png',
    'assets/images/nestkeeper/nest_keeper_7.png',
    'assets/images/nestkeeper/nest_keeper_8.png',
    'assets/images/nestkeeper/nest_keeper_9.png',
    'assets/images/nestkeeper/nest_keeper_10.png',
  ];

  Widget buildBody(Size size, bool isMobile) {
    final projectCardHeight = isMobile ? 500.0 : 480.0;
    final paddingHorizontal = isMobile ? 16.0 : 32.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 32),
      child: Column(
        children: [
          // Project 1: Bangla Film Picks
          SizedBox(
            height: projectCardHeight,
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
            child: const ProjectCarouselCard(
              projectNumber: "03",
              title: "Flutter Game: Sudoku",
              icon: Icons.grid_on_rounded,
              screenshots: _sudokuScreenshots,
            ),
          ),
          const SizedBox(height: 24),

          // Project Philosophy Overview
          const ProjectOverviewCard(),
          const SizedBox(height: 24),

          // Tech Stack
          const SizedBox(
            height: 240,
            child: ProjectTechStackCard(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ProjectsScreen build called");
    return Selector<HomeViewModel, bool>(
      selector: (_, vm) => vm.isDarkMode,
      builder: (context, isDark, _) {
        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 900;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              const Positioned.fill(
                child: VideoBackground(),
              ),
              Container(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: AutoHidingHeader(
                appBar: AppBarWidget(
                  isMobile: isMobile,
                  isProjectsPage: true,
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 76.0),
                          child: buildBody(size, isMobile),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
              ),
            ],
          ),
        );
      },
    );
  }
}
