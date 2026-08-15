import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/shared/widgets/auto_hiding_header.dart';
import 'package:portfolio/features/home/widgets/hero_profile_widget.dart';
import 'package:portfolio/features/home/widgets/highlights_bar_widget.dart';
import 'package:portfolio/features/home/widgets/social_grid_widget.dart';
import 'package:portfolio/features/home/widgets/toggle_widget.dart';
import 'package:portfolio/features/home/widgets/what_i_do_widget.dart';
import 'package:portfolio/features/home/widgets/tech_stack_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildBody(bool isMobile) {
    if (isMobile) {
      // Mobile Layout (Single Column matching natural visual flow)
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            HeroProfileWidget(),
            SizedBox(height: 16),
            HighlightsBarWidget(),
            SizedBox(height: 16),
            SizedBox(height: 340, child: WhatIDoWidget()),
            SizedBox(height: 16),
            SizedBox(height: 220, child: TechStackWidget()),
            SizedBox(height: 16),
            SizedBox(height: 220, child: SocialGridWidget()),
            SizedBox(height: 16),
            SizedBox(height: 80, child: ToggleWidget()),
          ],
        ),
      );
    }

    // Desktop Layout (Structured 2-Column Bento Grid matching zero-scroll viewport height)
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          // Top Row: Profile & Highlights on Left, What I Do & Social Grid on Right
          SizedBox(
            height: 410,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Main Column (Flex 80)
                Expanded(
                  flex: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 330, child: HeroProfileWidget()),
                      SizedBox(height: 14),
                      SizedBox(height: 66, child: HighlightsBarWidget()),
                    ],
                  ),
                ),
                SizedBox(width: 14),
                // Right Sidebar Column (Flex 35)
                Expanded(
                  flex: 35,
                  child: Column(
                    children: [
                      Expanded(flex: 11, child: WhatIDoWidget()),
                      SizedBox(height: 14),
                      Expanded(flex: 10, child: SocialGridWidget()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          // Bottom Aligned Row: Tech Stack (Flex 80) and Theme Toggle (Flex 35)
          SizedBox(
            height: 260,
            child: Row(
              children: [
                Expanded(
                  flex: 80,
                  child: TechStackWidget(),
                ),
                SizedBox(width: 14),
                Expanded(
                  flex: 35,
                  child: ToggleWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainScrollController = context.read<HomeViewModel>().mainScrollController;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Selector<HomeViewModel, bool>(
      selector: (_, vm) => vm.isDarkMode,
      builder: (context, isDarkMode, _) {
        final backgroundDecoration = isDarkMode
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

        return Scaffold(
          body: Container(
            decoration: backgroundDecoration,
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: AutoHidingHeader(
                appBar: AppBarWidget(isMobile: isMobile),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: mainScrollController,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 76.0),
                          child: buildBody(isMobile),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
