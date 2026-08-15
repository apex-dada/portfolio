import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class HeroProfileWidget extends StatelessWidget {
  const HeroProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    Widget buildSocialLink({
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: isDark ? Colors.white60 : Colors.black54),
              const SizedBox(width: 5),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;

        Widget leftContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main Title
            RichText(
              text: TextSpan(
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                  color: primaryTextColor,
                ),
                children: const [
                  TextSpan(text: "Hi, I'm\n"),
                  TextSpan(
                    text: "Kazi Woaej Mariz",
                    style: TextStyle(color: greenAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Bio Subtitle
            Text(
              "Mobile application developer crafting high-performance Android & iOS experiences with clean code and thoughtful design.",
              style: GoogleFonts.inter(
                color: secondaryTextColor,
                fontSize: 13.5,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 22),

            // Action Buttons
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children: [
                // Primary Green Button
                ElevatedButton.icon(
                  onPressed: () => context.go('/projects'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.black),
                  label: Text(
                    "View Projects",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // Outline Contact Me Button
                OutlinedButton.icon(
                  onPressed: () => context.go('/contact'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryTextColor,
                    side: BorderSide(
                      color: isDark ? const Color(0x33FFFFFF) : const Color(0x33000000),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.send_rounded, size: 14, color: primaryTextColor),
                  label: Text(
                    "Contact Me",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Social & Location Bar
            Wrap(
              spacing: 16,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                buildSocialLink(
                  icon: Icons.code_rounded,
                  label: "GitHub",
                  onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada'),
                ),
                buildSocialLink(
                  icon: Icons.work_rounded,
                  label: "LinkedIn",
                  onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://linkedin.com'),
                ),
                buildSocialLink(
                  icon: Icons.email_rounded,
                  label: "Email",
                  onTap: () => context.read<HomeViewModel>().launchURL(context, 'mailto:woaejmariz@gmail.com'),
                ),
                buildSocialLink(
                  icon: Icons.location_on_rounded,
                  label: "Bangladesh",
                  onTap: () {},
                ),
              ],
            ),
          ],
        );

        Widget rightPhoto = ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/IMG_0741 (1).jpg',
            fit: BoxFit.cover,
            cacheWidth: 800,
          ),
        );

        return BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: const EdgeInsets.all(28),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftContent,
                    const SizedBox(height: 24),
                    SizedBox(height: 320, child: rightPhoto),
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 6, child: leftContent),
                    const SizedBox(width: 24),
                    Expanded(flex: 5, child: rightPhoto),
                  ],
                ),
        );
      },
    );
  }
}
