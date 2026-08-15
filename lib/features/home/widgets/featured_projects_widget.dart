import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class FeaturedProjectsWidget extends StatelessWidget {
  const FeaturedProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    Widget buildProjectCard({
      required String title,
      required String description,
      required String imagePath,
      required List<String> tags,
      required VoidCallback onTap,
    }) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0x33FFFFFF) : const Color(0x1F000000),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1F000000),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Screenshot preview
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 1.3,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        cacheWidth: 600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: primaryTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Description
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: secondaryTextColor,
                      fontSize: 11.5,
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  const SizedBox(height: 8),

                  // Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0x44000000) : const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isDark ? Colors.white12 : Colors.black12,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.inter(
                            color: isDark ? Colors.white70 : Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.code_rounded, size: 16, color: greenAccent),
                  const SizedBox(width: 8),
                  Text(
                    "Featured Projects",
                    style: GoogleFonts.outfit(
                      color: primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => context.go('/projects'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: [
                      Text(
                        "View all projects",
                        style: GoogleFonts.inter(
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 13,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 3 Project Cards Layout
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 700;

                if (isSmall) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 250,
                        child: Row(
                          children: [
                            buildProjectCard(
                              title: "Bangla Film Picks",
                              description: "Bangla movie discovery platform with reviews, ratings & community lists.",
                              imagePath: 'assets/images/bangla_film_picks/bangla_movie_pick_4.jpg',
                              tags: const ["Flutter", "Supabase"],
                              onTap: () => context.go('/projects'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 250,
                        child: Row(
                          children: [
                            buildProjectCard(
                              title: "NestKeeper",
                              description: "Smart property & tenant management application.",
                              imagePath: 'assets/images/nestkeeper/nest_keeper_1.png',
                              tags: const ["Flutter", "Firebase"],
                              onTap: () => context.go('/projects'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 250,
                        child: Row(
                          children: [
                            buildProjectCard(
                              title: "Sudoku",
                              description: "Clean & minimal Sudoku puzzle game with multiple levels & languages.",
                              imagePath: 'assets/images/sudoku/1_.webp',
                              tags: const ["Flutter", "Offline"],
                              onTap: () => context.go('/projects'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildProjectCard(
                      title: "Bangla Film Picks",
                      description: "Bangla movie discovery platform with reviews, ratings & community lists.",
                      imagePath: 'assets/images/bangla_film_picks/bangla_movie_pick_4.jpg',
                      tags: const ["Flutter", "Supabase"],
                      onTap: () => context.go('/projects'),
                    ),
                    const SizedBox(width: 14),
                    buildProjectCard(
                      title: "NestKeeper",
                      description: "Smart property & tenant management application.",
                      imagePath: 'assets/images/nestkeeper/nest_keeper_1.png',
                      tags: const ["Flutter", "Firebase"],
                      onTap: () => context.go('/projects'),
                    ),
                    const SizedBox(width: 14),
                    buildProjectCard(
                      title: "Sudoku",
                      description: "Clean & minimal Sudoku puzzle game with multiple levels & languages.",
                      imagePath: 'assets/images/sudoku/1_.webp',
                      tags: const ["Flutter", "Offline"],
                      onTap: () => context.go('/projects'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
