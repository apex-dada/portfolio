import 'package:flutter/material.dart';
import 'package:portfolio/shared/widgets/editorial_top_bar.dart';
import 'package:portfolio/features/about/widgets/about_bio_widget.dart';
import 'package:portfolio/features/about/widgets/about_facts_widget.dart';
import 'package:portfolio/features/about/widgets/about_education_widget.dart';
import 'package:portfolio/features/about/widgets/about_hobbies_widget.dart';
import 'package:portfolio/features/about/widgets/about_core_values_widget.dart';
import 'package:portfolio/features/about/widgets/about_soft_skills_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                      isAboutPage: true,
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
