import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/app_bar_section.dart';
import 'package:portfolio/widget/profile_info_section.dart';
import 'package:portfolio/widget/portfolio_mockup_one_section.dart';
import 'package:portfolio/widget/portfolio_mockup_two_section.dart';
import 'package:portfolio/widget/social_containers.dart';
import 'package:portfolio/widget/profile_image_section.dart';
import 'package:portfolio/widget/about_section.dart';
import 'package:portfolio/widget/toggle_section.dart';
import 'package:portfolio/widget/stack_section.dart';
import 'package:portfolio/widget/newsletter_section.dart';
import 'package:portfolio/widget/workflow_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) {
          final size = MediaQuery.of(context).size;
          final isMobile = size.width < 900;

          final backgroundDecoration = homeViewModel.isDarkMode
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

          Widget buildBody() {
            if (isMobile) {
              // Mobile Layout (Single Column following natural eye flow)
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    SizedBox(height: 240, child: ProfileInfoSection()), // Hero Section
                    SizedBox(height: 16),
                    SizedBox(height: 240, child: ProfileImageSection()), // Profile Image
                    SizedBox(height: 16),
                    SizedBox(height: 220, child: PortfolioMockupOneSection()), // Featured Project 1
                    SizedBox(height: 16),
                    SizedBox(height: 220, child: PortfolioMockupTwoSection()), // Featured Project 2
                    SizedBox(height: 16),
                    SizedBox(height: 200, child: AboutSection()), // About
                    SizedBox(height: 16),
                    SizedBox(height: 200, child: StackSection()), // Tech Stack
                    SizedBox(height: 16),
                    SizedBox(height: 260, child: WorkflowSection()), // Workflow
                    SizedBox(height: 16),
                    SizedBox(height: 180, child: NewsletterSection()), // Contact
                    SizedBox(height: 16),
                    SizedBox(height: 160, child: SocialContainers()), // Supplementary Socials
                    SizedBox(height: 16),
                    SizedBox(height: 80, child: ToggleSection()), // Theme Switcher
                  ],
                ),
              );
            }

            // Desktop Layout (Grid structure optimized for visual hierarchy and flow)
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                children: [
                  // Row 1: Hero (flex 5), Profile Image (flex 3), Social/Toggle Column (flex 2)
                  SizedBox(
                    height: 220,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 5, child: ProfileInfoSection()),
                        SizedBox(width: 16),
                        Expanded(flex: 3, child: ProfileImageSection()),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(child: SocialContainers()),
                              SizedBox(height: 16),
                              Expanded(child: ToggleSection()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Rows 2 & 3 (Combined grid for vertical alignment of workflow)
                  SizedBox(
                    height: 386,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Left side grid column (Featured Projects, About, Stack, Contact)
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              // Row 2 Left (Featured Projects & About)
                              SizedBox(
                                height: 200,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(flex: 3, child: PortfolioMockupOneSection()),
                                    SizedBox(width: 16),
                                    Expanded(flex: 3, child: PortfolioMockupTwoSection()),
                                    SizedBox(width: 16),
                                    Expanded(flex: 4, child: AboutSection()),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              // Row 3 Left (Tech Stack & Contact)
                              SizedBox(
                                height: 170,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(flex: 5, child: StackSection()),
                                    SizedBox(width: 16),
                                    Expanded(flex: 3, child: NewsletterSection()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        // Right side grid column (Workflow Timeline - spans Row 2 & 3 height)
                        Expanded(
                          flex: 2,
                          child: WorkflowSection(),
                        ),
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
                        child: AppBarSection(isMobile: isMobile),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: SingleChildScrollView(
                            controller: homeViewModel.mainScrollController,
                            child: Skeletonizer(
                              enabled: homeViewModel.isChangingTheme,
                              child: buildBody(),
                            ),
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
      ),
    );
  }
}
