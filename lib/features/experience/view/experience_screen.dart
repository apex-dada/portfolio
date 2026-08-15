import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/features/experience/widgets/experience_timeline_card.dart';
import 'package:portfolio/features/experience/widgets/experience_services_card.dart';
import 'package:portfolio/features/experience/widgets/experience_workflow_card.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

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
              ExperienceTimelineCard(),
              SizedBox(height: 16),
              ExperienceServicesCard(),
              SizedBox(height: 16),
              SizedBox(height: 340, child: ExperienceWorkflowCard()), // Workflow list needs bounds on mobile
            ],
          ),
        );
      }

      // Desktop layout
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            // Row 1: Timeline (flex 6), Services (flex 4)
            SizedBox(
              height: 340,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 6, child: ExperienceTimelineCard()),
                  SizedBox(width: 16),
                  Expanded(flex: 4, child: ExperienceServicesCard()),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Row 2: Workflow timeline scroll list (flex 10)
            SizedBox(
              height: 340,
              child: ExperienceWorkflowCard(),
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
                    isExperiencePage: true,
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
