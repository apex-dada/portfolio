import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ContactSocialsCard extends StatelessWidget {
  const ContactSocialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);

    Widget buildSocialButton(IconData icon, String tooltip, VoidCallback onTap) {
      return Tooltip(
        message: tooltip,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1E2837),
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
            color: const Color(0xFF1E2837),
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
                  style: GoogleFonts.plusJakartaSans(
                    color: primaryTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return BentoCard(
      width: double.infinity,
      backgroundColor: const Color(0xFF15181E),
      borderColor: const Color(0xFF242C38),
      hoverBorderColor: HomeViewModel.periwinkleBlue,
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CONNECT WITH ME",
            style: GoogleFonts.plusJakartaSans(
              color: HomeViewModel.periwinkleBlue,
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
