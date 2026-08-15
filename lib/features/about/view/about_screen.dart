import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/features/about/widgets/about_bio_widget.dart';
import 'package:portfolio/features/about/widgets/about_facts_widget.dart';
import 'package:portfolio/features/about/widgets/about_education_widget.dart';
import 'package:portfolio/features/about/widgets/about_hobbies_widget.dart';
import 'package:portfolio/features/about/widgets/about_core_values_widget.dart';
import 'package:portfolio/features/about/widgets/about_soft_skills_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
              AboutBioWidget(),
              SizedBox(height: 16),
              AboutFactsWidget(),
              SizedBox(height: 16),
              AboutEducationWidget(),
              SizedBox(height: 16),
              AboutHobbiesWidget(),
              SizedBox(height: 16),
              AboutCoreValuesWidget(),
              SizedBox(height: 16),
              AboutSoftSkillsWidget(),
            ],
          ),
        );
      }

      // Desktop bento layout
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            // Row 1: Bio (flex 6), Facts (flex 4)
            SizedBox(
              height: 340,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 6, child: AboutBioWidget()),
                  SizedBox(width: 16),
                  Expanded(flex: 4, child: AboutFactsWidget()),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Row 2: Education (flex 4), Hobbies (flex 6)
            SizedBox(
              height: 310,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 4, child: AboutEducationWidget()),
                  SizedBox(width: 16),
                  Expanded(flex: 6, child: AboutHobbiesWidget()),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Row 3: Core Values (flex 5), Soft Skills (flex 5)
            SizedBox(
              height: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 5, child: AboutCoreValuesWidget()),
                  SizedBox(width: 16),
                  Expanded(flex: 5, child: AboutSoftSkillsWidget()),
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
                  child: AppBarWidget(isMobile: MediaQuery.of(context).size.width < 900, isAboutPage: true),
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
