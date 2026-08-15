import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class WhatIDoWidget extends StatelessWidget {
  const WhatIDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    Widget buildItem({
      required IconData icon,
      required String title,
      required String description,
    }) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFF1E2129)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: 11.5,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Row(
            children: [
              const Icon(Icons.work_outline_rounded, size: 16, color: greenAccent),
              const SizedBox(width: 8),
              Text(
                "What I Do",
                style: GoogleFonts.outfit(
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Items List
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildItem(
                  icon: Icons.phone_iphone_rounded,
                  title: "Mobile Development",
                  description: "Building cross-platform mobile apps with Flutter.",
                ),
                buildItem(
                  icon: Icons.brush_rounded,
                  title: "UI/UX Implementation",
                  description: "Turning ideas into beautiful, responsive interfaces.",
                ),
                buildItem(
                  icon: Icons.layers_rounded,
                  title: "State Management",
                  description: "Expert in Bloc, Provider & Riverpod.",
                ),
                buildItem(
                  icon: Icons.code_rounded,
                  title: "API Integration",
                  description: "Connecting apps with robust backends & third-party APIs.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
