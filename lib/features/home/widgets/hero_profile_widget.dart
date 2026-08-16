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

    final greenAccent = isDark ? const Color(0xFF3DDC84) : const Color(0xFF16A34A);
    final buttonTextColor = isDark ? Colors.black : Colors.white;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;
        final isSmallMobile = constraints.maxWidth < 420;

        Widget leftContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Main Title
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: isSmallMobile ? 18 : (isMobile ? 22 : 32),
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                      color: primaryTextColor,
                    ),
                    children: [
                      const TextSpan(text: "Hi, I'm "),
                      TextSpan(
                        text: "Kazi Woaej Mariz",
                        style: TextStyle(color: greenAccent),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 6 : 10),

                // Bio Subtitle
                Text(
                  "Mobile application developer crafting high-performance Android & iOS experiences with clean code and thoughtful design.",
                  style: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: isSmallMobile ? 11 : (isMobile ? 12 : 13),
                    height: 1.35,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: isMobile ? 3 : null,
                  overflow: isMobile ? TextOverflow.ellipsis : null,
                ),
              ],
            ),
            if (!isMobile) const Spacer(),
            SizedBox(height: isMobile ? 12 : 16),

            // Bottom Section (Action Buttons)
            Wrap(
              spacing: isSmallMobile ? 6 : 10,
              runSpacing: 8,
              children: [
                // Primary Green Button
                ElevatedButton.icon(
                  onPressed: () => context.go('/projects'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenAccent,
                    foregroundColor: buttonTextColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallMobile ? 10 : (isMobile ? 12 : 18),
                      vertical: isMobile ? 9 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    size: isMobile ? 13 : 15,
                    color: buttonTextColor,
                  ),
                  label: Text(
                    "View Projects",
                    style: GoogleFonts.inter(
                      fontSize: isSmallMobile ? 11 : (isMobile ? 11.5 : 12.5),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallMobile ? 10 : (isMobile ? 12 : 16),
                      vertical: isMobile ? 9 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(
                    Icons.send_rounded,
                    size: isMobile ? 12 : 13,
                    color: primaryTextColor,
                  ),
                  label: Text(
                    "Contact Me",
                    style: GoogleFonts.inter(
                      fontSize: isSmallMobile ? 11 : (isMobile ? 11.5 : 12.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );

        Widget rightPhoto = ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isSmallMobile ? 100 : (isMobile ? 125 : 235),
            maxHeight: isSmallMobile ? 145 : (isMobile ? 175 : 270),
          ),
          child: AspectRatio(
            aspectRatio: 0.85,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
              child: Image.asset(
                'assets/images/IMG_0741 (1).jpg',
                fit: BoxFit.cover,
                cacheWidth: 600,
              ),
            ),
          ),
        );

        return BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: EdgeInsets.all(isSmallMobile ? 14 : (isMobile ? 18 : 26)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isMobile ? 6 : 7,
                child: leftContent,
              ),
              SizedBox(width: isMobile ? 12 : 20),
              Flexible(
                flex: isMobile ? 4 : 3,
                child: Center(child: rightPhoto),
              ),
            ],
          ),
        );
      },
    );
  }
}
