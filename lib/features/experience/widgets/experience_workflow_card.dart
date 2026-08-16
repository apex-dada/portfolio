import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/home/widgets/workflow_list.dart';

class ExperienceWorkflowCard extends StatelessWidget {
  const ExperienceWorkflowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      backgroundColor: const Color(0xFF15181E),
      borderColor: const Color(0xFF242C38),
      hoverBorderColor: HomeViewModel.periwinkleBlue,
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "MY WORKFLOW TIMELINE",
              style: GoogleFonts.plusJakartaSans(
                color: HomeViewModel.periwinkleBlue,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: WorkflowList(),
          ),
        ],
      ),
    );
  }
}
