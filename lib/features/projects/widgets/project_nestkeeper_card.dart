import 'package:flutter/material.dart';
import 'package:portfolio/features/projects/widgets/project_carousel_card.dart';

class ProjectNestKeeperCard extends StatelessWidget {
  const ProjectNestKeeperCard({super.key});

  static const List<String> _screenshots = [
    'assets/images/nestkeeper/nest_keeper_1.png',
    'assets/images/nestkeeper/nest_keeper_2.png',
    'assets/images/nestkeeper/nest_keeper_3.png',
    'assets/images/nestkeeper/nest_keeper_4.png',
    'assets/images/nestkeeper/nest_keeper_5.png',
    'assets/images/nestkeeper/nest_keeper_6.png',
    'assets/images/nestkeeper/nest_keeper_7.png',
    'assets/images/nestkeeper/nest_keeper_8.png',
    'assets/images/nestkeeper/nest_keeper_9.png',
    'assets/images/nestkeeper/nest_keeper_10.png',
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

