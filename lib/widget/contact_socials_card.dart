import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class ContactSocialsCard extends StatelessWidget {
  const ContactSocialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    Widget buildSocialButton(IconData icon, String tooltip, VoidCallback onTap) {
      return Tooltip(
        message: tooltip,
        child: SizedBox(
          width: 50,
          height: 50,
          child: LiquidGlass.withOwnLayer(
            shape: const LiquidRoundedRectangle(
              borderRadius: 25, // Circle
              side: BorderSide(
                color: Color(0x1F000000),
                width: 1.0,
              ),
            ),
            settings: LiquidGlassSettings(
              blur: 8.0,
              glassColor: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(25),
              child: Center(
                child: Icon(
                  icon,
                  color: homeViewModel.primaryTextColor,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget buildTextSocialButton(String label, String tooltip, VoidCallback onTap) {
      return Tooltip(
        message: tooltip,
        child: SizedBox(
          width: 50,
          height: 50,
          child: LiquidGlass.withOwnLayer(
            shape: const LiquidRoundedRectangle(
              borderRadius: 25, // Circle
              side: BorderSide(
                color: Color(0x1F000000),
                width: 1.0,
              ),
            ),
            settings: LiquidGlassSettings(
              blur: 8.0,
              glassColor: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(25),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.outfit(
                    color: homeViewModel.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CONNECT WITH ME",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSocialButton(Icons.facebook_rounded, "Facebook", () {
                homeViewModel.launchURL(context, 'https://www.facebook.com/kazi.woaej.mariz/');
              }),
              const SizedBox(width: 16),
              buildSocialButton(Icons.camera_alt_outlined, "Instagram", () {
                homeViewModel.launchURL(context, 'https://www.instagram.com/kazi_woaej/');
              }),
              const SizedBox(width: 16),
              buildTextSocialButton("in", "LinkedIn", () {
                homeViewModel.launchURL(context, 'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/');
              }),
              const SizedBox(width: 16),
              buildSocialButton(Icons.code_rounded, "GitHub", () {
                homeViewModel.launchURL(context, 'https://github.com/apex-dada');
              }),
              const SizedBox(width: 16),
              buildSocialButton(Icons.mail_outline_rounded, "Email", () {
                homeViewModel.sendEmail(context);
              }),
            ],
          ),
        ],
      ),
    );
  }
}
