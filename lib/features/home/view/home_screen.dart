import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/shared/widgets/app_bar_widget.dart';
import 'package:portfolio/features/home/widgets/profile_info_widget.dart';
import 'package:portfolio/features/home/widgets/portfolio_mockup_one_widget.dart';
import 'package:portfolio/features/home/widgets/portfolio_mockup_two_widget.dart';
import 'package:portfolio/features/home/widgets/social_containers_widget.dart';
import 'package:portfolio/features/home/widgets/profile_image_widget.dart';
import 'package:portfolio/features/home/widgets/about_me_widget.dart';
import 'package:portfolio/features/home/widgets/toggle_widget.dart';
import 'package:portfolio/features/home/widgets/stack_i_use_widget.dart';
import 'package:portfolio/features/home/widgets/newsletter_widget.dart';
import 'package:portfolio/features/home/widgets/my_workflow_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
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
              image: AssetImage('assets/background/finalfr.jpg'),
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
              SizedBox(height: 240, child: ProfileInfoWidget()), // Hero Section
              SizedBox(height: 16),
              SizedBox(height: 240, child: ProfileImageWidget()), // Profile Image
              SizedBox(height: 16),
              SizedBox(height: 220, child: PortfolioMockupOneWidget()), // Featured Project 1
              SizedBox(height: 16),
              SizedBox(height: 220, child: PortfolioMockupTwoWidget()), // Featured Project 2
              SizedBox(height: 16),
              SizedBox(height: 200, child: AboutMeWidget()), // About
              SizedBox(height: 16),
              SizedBox(height: 200, child: StackIUseWidget()), // Tech Stack
              SizedBox(height: 16),
              SizedBox(height: 260, child: MyWorkflowWidget()), // Workflow
              SizedBox(height: 16),
              SizedBox(height: 180, child: NewsletterWidget()), // Contact
              SizedBox(height: 16),
              SizedBox(height: 160, child: SocialContainersWidget()), // Supplementary Socials
              SizedBox(height: 16),
              SizedBox(height: 80, child: ToggleWidget()), // Theme Switcher
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
                  Expanded(flex: 5, child: ProfileInfoWidget()),
                  SizedBox(width: 16),
                  Expanded(flex: 3, child: ProfileImageWidget()),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(child: SocialContainersWidget()),
                        SizedBox(height: 16),
                        Expanded(child: ToggleWidget()),
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
                              Expanded(flex: 3, child: PortfolioMockupOneWidget()),
                              SizedBox(width: 16),
                              Expanded(flex: 3, child: PortfolioMockupTwoWidget()),
                              SizedBox(width: 16),
                              Expanded(flex: 4, child: AboutMeWidget()),
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
                              Expanded(flex: 5, child: StackIUseWidget()),
                              SizedBox(width: 16),
                              Expanded(flex: 3, child: NewsletterWidget()),
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
                    child: MyWorkflowWidget(),
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
                  child: AppBarWidget(isMobile: isMobile),
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
  }
}
