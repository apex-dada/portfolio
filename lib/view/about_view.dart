import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/app_bar_section.dart';
import 'package:portfolio/widget/about_bio_section.dart';
import 'package:portfolio/widget/about_facts_section.dart';
import 'package:portfolio/widget/about_education_section.dart';
import 'package:portfolio/widget/about_hobbies_section.dart';
import 'package:portfolio/widget/about_core_values_section.dart';
import 'package:portfolio/widget/about_soft_skills_section.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

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
              image: AssetImage('assets/background/background_3.jpg'),
              fit: BoxFit.fill,
            ),
          );

    Widget buildBody(Size size, bool isMobile) {
      if (isMobile) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              AboutBioSection(),
              SizedBox(height: 16),
              AboutFactsSection(),
              SizedBox(height: 16),
              AboutEducationSection(),
              SizedBox(height: 16),
              AboutHobbiesSection(),
              SizedBox(height: 16),
              AboutCoreValuesSection(),
              SizedBox(height: 16),
              AboutSoftSkillsSection(),
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
                  Expanded(flex: 6, child: AboutBioSection()),
                  SizedBox(width: 16),
                  Expanded(flex: 4, child: AboutFactsSection()),
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
                  Expanded(flex: 4, child: AboutEducationSection()),
                  SizedBox(width: 16),
                  Expanded(flex: 6, child: AboutHobbiesSection()),
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
                  Expanded(flex: 5, child: AboutCoreValuesSection()),
                  SizedBox(width: 16),
                  Expanded(flex: 5, child: AboutSoftSkillsSection()),
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
                  child: AppBarSection(isMobile: MediaQuery.of(context).size.width < 900, isAboutPage: true),
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
