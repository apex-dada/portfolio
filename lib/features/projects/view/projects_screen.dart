import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/features/projects/widgets/project_tech_stack_card.dart';
import 'package:portfolio/features/projects/widgets/project_overview_card.dart';
import 'package:portfolio/features/projects/widgets/project_sudoku_card.dart';
import 'package:portfolio/features/projects/widgets/project_nestkeeper_card.dart';
import 'package:portfolio/features/projects/widgets/project_bangla_film_picks_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  Widget buildBody(Size size, bool isMobile) {
    if (isMobile) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            SizedBox(height: 320, child: ProjectSudokuCard()),
            SizedBox(height: 16),
            SizedBox(height: 320, child: ProjectNestKeeperCard()),
            SizedBox(height: 16),
            SizedBox(height: 320, child: ProjectBanglaFilmPicksCard()),
            SizedBox(height: 16),
            ProjectOverviewCard(),
            SizedBox(height: 16),
            SizedBox(height: 220, child: ProjectTechStackCard()),
          ],
        ),
      );
    }

    // Desktop layout
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          // Row 1: Sudoku (flex 6), Overview (flex 4)
          SizedBox(
            height: 340,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 6, child: ProjectSudokuCard()),
                SizedBox(width: 16),
                Expanded(flex: 4, child: ProjectOverviewCard()),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Row 2: NestKeeper (flex 6), Bangla Film Picks (flex 4)
          SizedBox(
            height: 340,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 6, child: ProjectNestKeeperCard()),
                SizedBox(width: 16),
                Expanded(flex: 4, child: ProjectBanglaFilmPicksCard()),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Row 3: Tech stack full width
          SizedBox(
            height: 220,
            child: ProjectTechStackCard(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, bool>(
      selector: (_, vm) => vm.isDarkMode,
      builder: (context, isDark, _) {
        final backgroundDecoration = isDark
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background/background_2.jpg'),
                  fit: BoxFit.fill,
                ),
              )
            : const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background/finalfr.jpg'),
                  fit: BoxFit.fill,
                ),
              );

        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 900;

        return Scaffold(
          body: Container(
            decoration: backgroundDecoration,
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Column(
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: AppBarWidget(
                        isMobile: isMobile,
                        isProjectsPage: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: SingleChildScrollView(
                          child: buildBody(size, isMobile),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
