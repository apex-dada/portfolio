import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  final ScrollController mainScrollController = ScrollController();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  String _activeSection = 'Home';
  String get activeSection => _activeSection;

  HomeViewModel() {
    mainScrollController.addListener(_onScroll);
  }

  bool _scrollThrottlePending = false;

  void _onScroll() {
    if (!mainScrollController.hasClients) return;
    if (_scrollThrottlePending) return;

    _scrollThrottlePending = true;
    Timer(const Duration(milliseconds: 60), () {
      _scrollThrottlePending = false;
      _updateActiveSection();
    });
  }

  void _updateActiveSection() {
    if (!mainScrollController.hasClients) return;

    if (mainScrollController.offset < 50) {
      if (_activeSection != 'Home') {
        _activeSection = 'Home';
        notifyListeners();
      }
      return;
    }

    final keys = {
      'Projects': portfolioKey,
      'Experience': experienceKey,
      'About': aboutKey,
      'Contact': contactKey,
    };

    String currentSection = 'Home';
    double closestDistance = double.infinity;

    keys.forEach((section, key) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final position = box.localToGlobal(Offset.zero);
          final distance = position.dy.abs();
          if (distance < closestDistance && position.dy < 350) {
            closestDistance = distance;
            currentSection = section;
          }
        }
      }
    });

    if (_activeSection != currentSection) {
      _activeSection = currentSection;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Theme-derived values matching modern high-contrast design systems
  Color get cardColor => _isDarkMode ? const Color(0xFF151515) : const Color(0xFFFFFFFF);
  Color get borderColor => _isDarkMode ? const Color(0xFF222222) : const Color(0xFFE2E8F0);
  Color get hoverBorderColor => _isDarkMode ? const Color(0xFF3F3F3F) : const Color(0xFFCBD5E1);
  Color get primaryTextColor => _isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF0F172A);
  Color get secondaryTextColor => _isDarkMode ? const Color(0xB3FFFFFF) : const Color(0xFF475569);
  Color get accentColor => _isDarkMode ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

  TextStyle get titleStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: secondaryTextColor,
        letterSpacing: 1.5,
      );

  // Cursor follower configuration (read-only config — position never lives here)
  bool _cursorFollowerEnabled = true;
  bool get cursorFollowerEnabled => _cursorFollowerEnabled;
  Color get cursorFollowerColor =>
      _isDarkMode ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);
  double get cursorFollowerSize => 40.0;
  double get cursorDotSize => 8.0;

  // Bento card hover state — circle cursor only shows when over a bento card
  bool _isOverBentoCard = false;
  bool get isOverBentoCard => _isOverBentoCard;

  void setOverBentoCard(bool value) {
    if (_isOverBentoCard != value) {
      _isOverBentoCard = value;
      notifyListeners();
    }
  }

  void toggleCursorFollower() {
    _cursorFollowerEnabled = !_cursorFollowerEnabled;
    notifyListeners();
  }

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
    mainScrollController.removeListener(_onScroll);
    mainScrollController.dispose();
    super.dispose();
  }
}
