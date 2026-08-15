import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class ProjectNestKeeperCard extends StatefulWidget {
  const ProjectNestKeeperCard({super.key});

  @override
  State<ProjectNestKeeperCard> createState() => _ProjectNestKeeperCardState();
}

class _ProjectNestKeeperCardState extends State<ProjectNestKeeperCard> {
  static const List<String> _screenshots = [
    'assets/images/nestkeeper/nest_keeper_1.png',
    'assets/images/nestkeeper/nest_keeper_2.png',
    'assets/images/nestkeeper/nest_keeper_3.png',
    'assets/images/nestkeeper/nest_keeper_4.png',
    'assets/images/nestkeeper/nest_keeper_5.png',
    'assets/images/nestkeeper/nest_keeper_6.png',
    'assets/images/nestkeeper/nest_keeper_7.png',
    'assets/images/nestkeeper/nest_keeper_8.png',
    'assets/images/nestkeeper/nest_keeper_9.png',
    'assets/images/nestkeeper/nest_keeper_10.png',
  ];

  late final PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoPlayTimer;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || _isHovered) return;
      final next = (_currentIndex + 1) % _screenshots.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final accentColor = isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: EdgeInsets.zero,
      onTap: () => context.read<HomeViewModel>().launchURL(context, 'https://github.com/apex-dada'),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          children: [
            // Screenshot PageView
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _screenshots.length,
                onPageChanged: (idx) => setState(() => _currentIndex = idx),
                itemBuilder: (context, index) {
                  return Container(
                    color: isDark ? const Color(0xFF101010) : const Color(0xFFF5F5F7),
                    child: Center(
                      child: Image.asset(
                        _screenshots[index],
                        fit: BoxFit.contain,
                        cacheWidth: 800,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Left / Right Navigation Chevrons on Hover
            if (_isHovered) ...[
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final prev = (_currentIndex - 1 + _screenshots.length) % _screenshots.length;
                      _pageController.animateToPage(
                        prev,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Colors.black.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.8),
                        border: Border.all(color: borderColor),
                      ),
                      child: Icon(Icons.chevron_left_rounded, size: 20, color: primaryTextColor),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final next = (_currentIndex + 1) % _screenshots.length;
                      _pageController.animateToPage(
                        next,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Colors.black.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.8),
                        border: Border.all(color: borderColor),
                      ),
                      child: Icon(Icons.chevron_right_rounded, size: 20, color: primaryTextColor),
                    ),
                  ),
                ),
              ),
            ],

            // Top-right Screenshot Indicator Pill
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black.withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1F000000),
                    width: 1,
                  ),
                ),
                child: Text(
                  "${_currentIndex + 1} / ${_screenshots.length}",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Bottom-left Frosted Title Tag Overlay
            Positioned(
              left: 16,
              bottom: 16,
              child: Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xCC000000) : const Color(0xCCFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1F000000),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flutter_dash,
                      color: accentColor,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "02 / Flutter App: NestKeeper",
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
