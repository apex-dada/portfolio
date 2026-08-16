import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/shared/widgets/auto_hiding_header.dart';
import 'package:portfolio/features/experience/widgets/experience_timeline_card.dart';
import 'package:portfolio/features/experience/widgets/experience_services_card.dart';
import 'package:portfolio/features/experience/widgets/experience_workflow_card.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  Widget buildBody(Size size, bool isMobile) {
    if (isMobile) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: double.infinity, child: ExperienceTimelineCard()),
            SizedBox(height: 16),
            SizedBox(height: 400, width: double.infinity, child: ExperienceServicesCard()),
            SizedBox(height: 16),
            SizedBox(height: 340, width: double.infinity, child: ExperienceWorkflowCard()),
          ],
        ),
      );
    }

    // Desktop layout
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row 1: Timeline (flex 6), Services (flex 4)
          SizedBox(
            height: 400,
            width: double.infinity,
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
            width: double.infinity,
            child: ExperienceWorkflowCard(),
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
        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 900;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isDark
                      ? 'assets/background/background_2.jpg'
                      : 'assets/background/finalfr.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: double.infinity,
                width: double.infinity,
            child: SafeArea(
              child: AutoHidingHeader(
                appBar: AppBarWidget(
                  isMobile: isMobile,
                  isExperiencePage: true,
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
