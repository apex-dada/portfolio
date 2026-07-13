import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';
import 'package:portfolio/widget/app_bar_section.dart';
import 'package:portfolio/widget/contact_form_card.dart';
import 'package:portfolio/widget/contact_info_card.dart';
import 'package:portfolio/widget/contact_socials_card.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isDark = homeViewModel.isDarkMode;

    final backgroundDecoration = isDark
        ? const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/background_2.jpg'),
              fit: BoxFit.fill,
            ),
          )
        : const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/background_3.jpg'),
              fit: BoxFit.fill,
            ),
          );

    Widget buildBody(Size size, bool isMobile) {
      if (isMobile) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              ContactFormCard(),
              SizedBox(height: 16),
              ContactInfoCard(),
              SizedBox(height: 16),
              SizedBox(height: 160, child: ContactSocialsCard()),
            ],
          ),
        );
      }

      // Desktop layout
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            // Row 1: Form (flex 6), Details (flex 4)
            SizedBox(
              height: 340,
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
            // Row 2: Social accounts (flex 10)
            SizedBox(
              height: 180,
              child: ContactSocialsCard(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: AppBarSection(
                    isMobile: MediaQuery.of(context).size.width < 900,
                    isContactPage: true,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: SingleChildScrollView(
                      child: buildBody(MediaQuery.of(context).size, MediaQuery.of(context).size.width < 900),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
