import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ContactFormCard extends StatelessWidget {
  const ContactFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    const offWhite = Color(0xFFECEFF4);
    const darkNavy = Color(0xFF1E2837);
    const periwinkle = Color(0xFF567C9E);

    Widget buildTextField() {
      return Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFD8DFE8),
            width: 1.0,
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            style: GoogleFonts.inter(
              color: darkNavy,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: "Your email address",
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF8A96A6),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      );
    }

    return BentoCard(
      width: double.infinity,
      backgroundColor: offWhite,
      borderColor: const Color(0xFFD8DFE8),
      hoverBorderColor: HomeViewModel.periwinkleBlue,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CONTACT FORM",
            style: GoogleFonts.plusJakartaSans(
              color: periwinkle,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Have a project in mind? Let's connect.",
            style: GoogleFonts.plusJakartaSans(
              color: darkNavy,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final useColumn = constraints.maxWidth < 320;
              if (useColumn) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildTextField(),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context.read<HomeViewModel>().showSnackBar(context, "Project request sent successfully!"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkNavy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "Send",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: buildTextField(),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.read<HomeViewModel>().showSnackBar(context, "Project request sent successfully!"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkNavy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(100, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Send",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
