import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class TechStackItem {
  final String name;
  final String? logoAsset;
  final IconData? fallbackIcon;

  const TechStackItem(this.name, {this.logoAsset, this.fallbackIcon});
}

class TechStackWidget extends StatelessWidget {
  const TechStackWidget({super.key});

  static const List<TechStackItem> _stackItems = [
    TechStackItem("Flutter", logoAsset: "assets/stack/flutter.png"),
    TechStackItem("Dart", logoAsset: "assets/stack/dart.png"),
    TechStackItem("Bloc", logoAsset: "assets/stack/block.png"),
    TechStackItem("Riverpod", logoAsset: "assets/stack/riverpod_logo.png"),
    TechStackItem("Firebase", logoAsset: "assets/stack/firebase.png"),
    TechStackItem("Supabase", logoAsset: "assets/stack/supabase.webp"),
    TechStackItem("SQLite", logoAsset: "assets/stack/sqlite.webp"),
    TechStackItem("Git", fallbackIcon: Icons.alt_route_rounded),
    TechStackItem("GitHub", logoAsset: "assets/stack/github-logo-png_seeklogo-304612.png"),
    TechStackItem("Android Studio", logoAsset: "assets/stack/android-studio.png"),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

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
            children: [
              const Icon(Icons.layers_rounded, size: 18, color: greenAccent),
              const SizedBox(width: 8),
              Text(
                "Tech Stack",
                style: GoogleFonts.outfit(
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stack Tags Wrap
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: _stackItems.map((item) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF22252F) : const Color(0xFFEBEFF5),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isDark ? const Color(0x22FFFFFF) : const Color(0x1F000000),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.logoAsset != null) ...[
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Image.asset(
                                item.logoAsset!,
                                width: 13,
                                height: 13,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 7),
                          ] else if (item.fallbackIcon != null) ...[
                            Icon(
                              item.fallbackIcon!,
                              size: 13,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            item.name,
                            style: GoogleFonts.inter(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
