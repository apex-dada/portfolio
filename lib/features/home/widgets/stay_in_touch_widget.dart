import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class StayInTouchWidget extends StatefulWidget {
  const StayInTouchWidget({super.key});

  @override
  State<StayInTouchWidget> createState() => _StayInTouchWidgetState();
}

class _StayInTouchWidgetState extends State<StayInTouchWidget> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Header Bar
          Row(
            children: [
              const Icon(Icons.mail_outline_rounded, size: 16, color: greenAccent),
              const SizedBox(width: 8),
              Text(
                "Let's stay in touch",
                style: GoogleFonts.outfit(
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            "Get updates on my projects and latest articles.",
            style: GoogleFonts.inter(
              color: secondaryTextColor,
              fontSize: 11.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Email Input Field
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: isDark ? const Color(0x44000000) : const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black12,
              ),
            ),
            child: TextField(
              controller: _emailController,
              style: GoogleFonts.inter(
                color: primaryTextColor,
                fontSize: 12.5,
              ),
              decoration: InputDecoration(
                hintText: "Your email address",
                hintStyle: GoogleFonts.inter(
                  color: isDark ? Colors.white38 : Colors.black38,
                  fontSize: 12,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Full-width Subscribe Button
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_emailController.text.trim().isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thank you for subscribing!')),
                  );
                  _emailController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward_rounded, size: 15, color: Colors.black),
              label: Text(
                "Subscribe",
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
