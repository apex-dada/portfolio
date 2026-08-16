import 'package:flutter/material.dart';
import 'package:portfolio/shared/widgets/editorial_top_bar.dart';
import 'package:portfolio/features/contact/widgets/contact_form_card.dart';
import 'package:portfolio/features/contact/widgets/contact_info_card.dart';
import 'package:portfolio/features/contact/widgets/contact_socials_card.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Widget buildBody(Size size, bool isMobile) {
    if (isMobile) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: double.infinity, child: ContactFormCard()),
            SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ContactInfoCard()),
            SizedBox(height: 16),
            SizedBox(height: 160, width: double.infinity, child: ContactSocialsCard()),
          ],
        ),
      );
    }

    // Desktop layout
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row 1: Form (flex 6), Details (flex 4)
          SizedBox(
            height: 340,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 6, child: ContactFormCard()),
                SizedBox(width: 16),
                Expanded(flex: 4, child: ContactInfoCard()),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Row 2: Social accounts ("CONNECT WITH ME")
          SizedBox(
            height: 180,
            width: double.infinity,
            child: ContactSocialsCard(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0E),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  children: [
                    EditorialTopBar(
                      isMobile: isMobile,
                      isContactPage: true,
                    ),
                    buildBody(size, isMobile),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
