import 'package:flutter/material.dart';
import 'package:portfolio/features/projects/widgets/project_carousel_card.dart';

class ProjectNestKeeperCard extends StatelessWidget {
  const ProjectNestKeeperCard({super.key});

  static const List<String> _screenshots = [
    'assets/images/nestkeeper/nest_keeper_1.webp',
    'assets/images/nestkeeper/nest_keeper_2.webp',
    'assets/images/nestkeeper/nest_keeper_3.webp',
    'assets/images/nestkeeper/nest_keeper_4.webp',
    'assets/images/nestkeeper/nest_keeper_5.webp',
    'assets/images/nestkeeper/nest_keeper_6.webp',
    'assets/images/nestkeeper/nest_keeper_7.webp',
    'assets/images/nestkeeper/nest_keeper_8.webp',
    'assets/images/nestkeeper/nest_keeper_9.webp',
    'assets/images/nestkeeper/nest_keeper_10.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return const ProjectCarouselCard(
      projectNumber: "02",
      title: "Flutter App: NestKeeper",
      icon: Icons.flutter_dash,
      screenshots: _screenshots,
    );
  }
}

