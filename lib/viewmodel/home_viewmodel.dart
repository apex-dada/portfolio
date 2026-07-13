import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  final ScrollController mainScrollController = ScrollController();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Theme-derived values matching the original designs
  Color get cardColor => _isDarkMode ? const Color(0xFF151515) : const Color(0xFFFFFFFF);
  Color get borderColor => _isDarkMode ? const Color(0xFF222222) : const Color(0xFFE8E8E8);
  Color get hoverBorderColor => _isDarkMode ? const Color(0xFF3F3F3F) : const Color(0xFFCCCCCC);
  Color get primaryTextColor => _isDarkMode ? Colors.white : Colors.black;
  Color get secondaryTextColor => _isDarkMode ? Colors.white54 : Colors.black54;

  TextStyle get titleStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: secondaryTextColor,
        letterSpacing: 1.5,
      );

  void scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void scrollToTop() {
    mainScrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> launchURL(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        showSnackBar(context, "Could not launch $urlString");
      }
    }
  }

  Future<void> sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'kaziwoaej@gmail.com',
    );
    if (!await launchUrl(emailLaunchUri)) {
      if (context.mounted) {
        showSnackBar(context, "Could not launch email client");
      }
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF333333), width: 1),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    mainScrollController.dispose();
    super.dispose();
  }
}
