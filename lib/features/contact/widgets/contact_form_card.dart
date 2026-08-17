import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ContactFormCard extends StatefulWidget {
  const ContactFormCard({super.key});

  @override
  State<ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<ContactFormCard> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim());
  }

  Future<void> _submitForm(BuildContext context) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (email.isEmpty) {
      context.read<HomeViewModel>().showSnackBar(context, "Please enter your email address.");
      return;
    }

    if (!_isValidEmail(email)) {
      context.read<HomeViewModel>().showSnackBar(context, "Please enter a valid email address.");
      return;
    }

    if (message.isEmpty) {
      context.read<HomeViewModel>().showSnackBar(context, "Please enter a message or project inquiry.");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final endpoint = Uri.base.replace(path: '/api/contact', query: '');

      final response = await http.post(
        endpoint,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name.isEmpty ? 'Portfolio Visitor' : name,
          'email': email,
          'message': message,
        }),
      ).timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (mounted) {
        if (response.statusCode == 200 && data['success'] == true) {
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          context.read<HomeViewModel>().showSnackBar(
            context,
            "Message sent successfully! I'll get back to you soon.",
          );
        } else {
          final errorMessage = data['error'] ?? "Failed to send message. Please try again.";
          context.read<HomeViewModel>().showSnackBar(context, errorMessage);
        }
      }
    } catch (e) {
      if (mounted) {
        context.read<HomeViewModel>().showSnackBar(
          context,
          "Error sending message. Please try emailing directly at kaziwoaej@gmail.com",
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    Widget buildInputField({
      required TextEditingController controller,
      required String hintText,
      int maxLines = 1,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.inter(
            color: primaryTextColor,
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              color: secondaryTextColor.withValues(alpha: 0.6),
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      );
    }

    return BentoCard(
      width: double.infinity,
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CONTACT FORM",
            style: GoogleFonts.outfit(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Have a project in mind? Let's connect.",
            style: GoogleFonts.outfit(
              color: primaryTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 450;
              if (isNarrow) {
                return Column(
                  children: [
                    buildInputField(
                      controller: _nameController,
                      hintText: "Your Name (Optional)",
                    ),
                    const SizedBox(height: 10),
                    buildInputField(
                      controller: _emailController,
                      hintText: "Your Email Address *",
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: buildInputField(
                      controller: _nameController,
                      hintText: "Your Name (Optional)",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildInputField(
                      controller: _emailController,
                      hintText: "Your Email Address *",
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          buildInputField(
            controller: _messageController,
            hintText: "Tell me about your project or inquiry... *",
            maxLines: 3,
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: _isSubmitting ? null : () => _submitForm(context),
              icon: _isSubmitting
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                    )
                  : const Icon(Icons.send_rounded, size: 16),
              label: Text(
                _isSubmitting ? "Sending..." : "Send Message",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTextColor,
                foregroundColor: isDark ? Colors.black : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
