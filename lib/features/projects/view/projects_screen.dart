import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/features/projects/widgets/project_taskly_card.dart';
import 'package:portfolio/features/projects/widgets/project_dashboard_card.dart';
import 'package:portfolio/features/projects/widgets/project_tech_stack_card.dart';
import 'package:portfolio/features/projects/widgets/project_overview_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

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

    Widget buildBody(Size size, bool isMobile) {
      if (isMobile) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              ProjectTasklyCard(),
              SizedBox(height: 16),
              ProjectOverviewCard(),
              SizedBox(height: 16),
              SizedBox(height: 220, child: ProjectTechStackCard()), // Carousel needs bounded height even on mobile
              SizedBox(height: 16),
              ProjectDashboardCard(),
            ],
          ),
        );
      }

      // Desktop layout
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            // Row 1: Taskly iOS (flex 6), Overview (flex 4)
            SizedBox(
              height: 340,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 6, child: ProjectTasklyCard()),
                  SizedBox(width: 16),
                  Expanded(flex: 4, child: ProjectOverviewCard()),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Row 2: Tech stack (flex 5), Dashboard Web (flex 5)
            SizedBox(
              height: 270,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 5, child: ProjectTechStackCard()),
                  SizedBox(width: 16),
                  Expanded(flex: 5, child: ProjectDashboardCard()),
                ],
              ),
            ),
          ],
        ),
      );
    }

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
                    isMobile: MediaQuery.of(context).size.width < 900,
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
                      child: buildBody(MediaQuery.of(context).size, MediaQuery.of(context).size.width < 900),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
