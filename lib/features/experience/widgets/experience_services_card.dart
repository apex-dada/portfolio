import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ExperienceServicesCard extends StatelessWidget {
  const ExperienceServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    Widget buildServiceItem(String title, String desc, IconData icon) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accentColor, size: 16),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: primaryTextColor,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    desc,
                    style: GoogleFonts.inter(
                      color: secondaryTextColor,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return BentoCard(
      width: double.infinity,
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SERVICES",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildServiceItem(
                      "Mobile App Dev",
                      "High performance native Android & iOS applications using Flutter.",
                      Icons.phone_iphone_rounded,
                    ),
                    buildServiceItem(
                      "Backend & Cloud Services",
                      "Firebase & Supabase — Authentication, Database, Storage, Cloud Functions, Push Notifications, and Real-Time Data Synchronization.",
                      Icons.cloud_done_rounded,
                    ),
                    buildServiceItem(
                      "Offline-First Architecture",
                      "Local data persistence, background synchronization, conflict resolution, and seamless online/offline experiences.",
                      Icons.cloud_sync_rounded,
                    ),
                    buildServiceItem(
                      "API Integration",
                      "Connecting secure backend REST APIs and Realtime WebSockets.",
                      Icons.sync_alt_rounded,
                    ),
                    buildServiceItem(
                      "Local Database",
                      "Setting up SQLite / Drift / Hive databases for robust offline workflows.",
                      Icons.storage_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
