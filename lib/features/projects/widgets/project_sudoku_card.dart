import 'package:flutter/material.dart';
import 'package:portfolio/features/projects/widgets/project_carousel_card.dart';

class ProjectSudokuCard extends StatelessWidget {
  const ProjectSudokuCard({super.key});

  static const List<String> _screenshots = [
    'assets/images/sudoku/1_.webp',
    'assets/images/sudoku/2_.webp',
    'assets/images/sudoku/3_.webp',
    'assets/images/sudoku/4_.webp',
    'assets/images/sudoku/5_.webp',
    'assets/images/sudoku/6_.webp',
    'assets/images/sudoku/7_.webp',
    'assets/images/sudoku/8_.webp',
    'assets/images/sudoku/9_.webp',
    'assets/images/sudoku/10_.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return const ProjectCarouselCard(
      projectNumber: "03",
      title: "Flutter Game: Sudoku",
      icon: Icons.grid_on_rounded,
      screenshots: _screenshots,
    );
  }
}

