import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/bento_card.dart';

class NewsletterSection extends StatelessWidget {
  const NewsletterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();

    return BentoCard(
      backgroundColor: homeViewModel.cardColor,
      borderColor: homeViewModel.borderColor,
      hoverBorderColor: homeViewModel.hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Have a project in mind?",
            style: TextStyle(
              color: homeViewModel.primaryTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final useColumn = constraints.maxWidth < 280;
              if (useColumn) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: homeViewModel.isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF2F2F7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: homeViewModel.borderColor),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        style: TextStyle(color: homeViewModel.primaryTextColor, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Your email address",
                          hintStyle: TextStyle(color: homeViewModel.secondaryTextColor, fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => homeViewModel.showSnackBar(context, "Project request sent successfully!"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: homeViewModel.primaryTextColor,
                        foregroundColor: homeViewModel.isDarkMode ? Colors.black : Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Sent",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: homeViewModel.isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF2F2F7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: homeViewModel.borderColor),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        style: TextStyle(color: homeViewModel.primaryTextColor, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Your email address",
                          hintStyle: TextStyle(color: homeViewModel.secondaryTextColor, fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => homeViewModel.showSnackBar(context, "Project request sent successfully!"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: homeViewModel.primaryTextColor,
                      foregroundColor: homeViewModel.isDarkMode ? Colors.black : Colors.white,
                      elevation: 0,
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sent",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
