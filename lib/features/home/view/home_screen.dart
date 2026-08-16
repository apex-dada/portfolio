import 'package:flutter/material.dart';
import 'package:portfolio/shared/widgets/editorial_top_bar.dart';
import 'package:portfolio/features/home/widgets/hero_image_pill_card.dart';
import 'package:portfolio/features/home/widgets/typography_brand_card.dart';
import 'package:portfolio/features/home/widgets/monogram_logo_card.dart';
import 'package:portfolio/features/home/widgets/portrait_periwinkle_card.dart';
import 'package:portfolio/features/home/widgets/industrial_showcase_card.dart';
import 'package:portfolio/features/home/widgets/iphone_live_activity_card.dart';
import 'package:portfolio/shared/widgets/footer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildBody(bool isMobile) {
    if (isMobile) {
      // Mobile Single-Column Flow
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            SizedBox(height: 260, child: HeroImagePillCard()),
            SizedBox(height: 14),
            TypographyBrandCard(),
            SizedBox(height: 14),
            MonogramLogoCard(),
            SizedBox(height: 14),
            SizedBox(height: 280, child: PortraitPeriwinkleCard()),
            SizedBox(height: 14),
            SizedBox(height: 380, child: IndustrialShowcaseCard()),
            SizedBox(height: 14),
            SizedBox(height: 480, child: IphoneLiveActivityCard()),
          ],
        ),
      );
    }

    // Desktop Bento Grid Matching Reference Image Exactly
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        children: [
          // Row 1: Perspective Image (flex 36), Typography+Brand (flex 32), Portrait (flex 32)
          SizedBox(
            height: 260,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 36,
                  child: HeroImagePillCard(),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 32,
                  child: Column(
                    children: [
                      Expanded(child: TypographyBrandCard()),
                      SizedBox(height: 14),
                      Expanded(child: MonogramLogoCard()),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 32,
                  child: PortraitPeriwinkleCard(),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Row 2: Industrial Showcase Container (flex 62), iPhone Live Activity (flex 38)
          SizedBox(
            height: 420,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 62,
                  child: IndustrialShowcaseCard(),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 38,
                  child: IphoneLiveActivityCard(),
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
                    EditorialTopBar(isMobile: isMobile),
                    _buildBody(isMobile),
                    const SizedBox(height: 32),
                    const FooterWidget(),
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
