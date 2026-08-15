import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ContactSocialsCard extends StatelessWidget {
  const ContactSocialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    Widget buildSocialButton(IconData icon, String tooltip, VoidCallback onTap) {
      return Tooltip(
        message: tooltip,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: Center(
                child: Icon(
                  icon,
                  color: primaryTextColor,
                  size: 20,
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
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.outfit(
                    color: primaryTextColor,
                    fontSize: 18,
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
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildSocialButton(Icons.facebook_rounded, "Facebook", () {
                  context.read<HomeViewModel>().launchURL(context, 'https://www.facebook.com/kazi.woaej.mariz/');
                }),
                const SizedBox(width: 12),
                buildSocialButton(Icons.camera_alt_outlined, "Instagram", () {
                  context.read<HomeViewModel>().launchURL(context, 'https://www.instagram.com/kazi_woaej/');
                }),
                const SizedBox(width: 12),
                buildTextSocialButton("in", "LinkedIn", () {
                  context.read<HomeViewModel>().launchURL(context, 'https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/');
                }),
                const SizedBox(width: 12),
                buildSocialButton(Icons.code_rounded, "GitHub", () {
                  context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada');
                }),
                const SizedBox(width: 12),
                buildSocialButton(Icons.mail_outline_rounded, "Email", () {
                  context.read<HomeViewModel>().sendEmail(context);
                }),
                const SizedBox(width: 12),
                buildSocialButton(Icons.discord, "Discord", () {
                  context.read<HomeViewModel>().launchURL(context, 'https://discord.gg');
                }),
                const SizedBox(width: 12),
                buildTextSocialButton("wa", "WhatsApp", () {
                  context.read<HomeViewModel>().launchURL(context, 'https://wa.me/');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
