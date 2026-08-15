import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/projects/widgets/image_preview_dialog.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ProjectCarouselCard extends StatefulWidget {
  final String projectNumber;
  final String title;
  final IconData icon;
  final List<String> screenshots;
  final String githubUrl;

  const ProjectCarouselCard({
    super.key,
    required this.projectNumber,
    required this.title,
    required this.icon,
    required this.screenshots,
    this.githubUrl = 'https://github.com/apex-dada',
  });

  @override
  State<ProjectCarouselCard> createState() => _ProjectCarouselCardState();
}

class _ProjectCarouselCardState extends State<ProjectCarouselCard>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;
  bool _isHovered = false;

  late final List<String> _displayScreenshots;

  @override
  void initState() {
    super.initState();
    _displayScreenshots =
        List.generate(40, (_) => widget.screenshots).expand((x) => x).toList();
    _ticker = createTicker(_onTick);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent / 2);
        _ticker.start();
      }
    });
  }

  void _onTick(Duration elapsed) {
    if (!mounted || !_scrollController.hasClients || _isHovered) return;
    final dt = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
    _lastElapsed = elapsed;

    if (dt <= 0 || dt > 0.1) return;

    const speed = 24.0; // pixels per second
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    double nextScroll = currentScroll + (speed * dt);
    if (nextScroll >= maxScroll - 200) {
      nextScroll = maxScroll / 2;
    }
    _scrollController.jumpTo(nextScroll);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);
    final cardColor =
        context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor =
        context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor =
        context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor =
        context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final accentColor =
        isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: EdgeInsets.zero,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          children: [
            // Background liquid glass container
            Positioned.fill(
              child: LiquidGlass.withOwnLayer(
                shape: const LiquidRoundedRectangle(
                  borderRadius: 24,
                  side: BorderSide(
                    color: Color(0x1F000000),
                    width: 1,
                  ),
                ),
                settings: const LiquidGlassSettings(
                  blur: 16.0,
                  glassColor: Colors.transparent,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0x22121214)
                        : const Color(0x55F0F2F5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),

            // Continuous Ticker Carousel
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 58),
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _displayScreenshots.length,
                  itemBuilder: (context, index) {
                    final screenshotPath = _displayScreenshots[index];
                    final originalIndex = index % widget.screenshots.length;
                    return GestureDetector(
                      onTap: () {
                        ImagePreviewDialog.show(
                          context,
                          images: widget.screenshots,
                          initialIndex: originalIndex,
                          title: widget.title,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: LiquidGlass.withOwnLayer(
                          shape: const LiquidRoundedRectangle(
                            borderRadius: 14,
                            side: BorderSide(
                              color: Color(0x1F000000),
                              width: 1,
                            ),
                          ),
                          settings: const LiquidGlassSettings(
                            blur: 12.0,
                            glassColor: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              screenshotPath,
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Left / Right Navigation Chevrons on Hover
            if (_isHovered) ...[
              Positioned(
                left: 12,
                top: 0,
                bottom: 58,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final target = (_scrollController.offset - 250)
                          .clamp(0.0, _scrollController.position.maxScrollExtent);
                      _scrollController.animateTo(
                        target,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: LiquidGlass.withOwnLayer(
                      shape: const LiquidRoundedRectangle(
                        borderRadius: 999,
                        side: BorderSide(
                          color: Color(0x33FFFFFF),
                          width: 1,
                        ),
                      ),
                      settings: const LiquidGlassSettings(
                        blur: 12.0,
                        glassColor: Colors.transparent,
                      ),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.7),
                        ),
                        child: Icon(Icons.chevron_left_rounded,
                            size: 22, color: primaryTextColor),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 58,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final target = (_scrollController.offset + 250)
                          .clamp(0.0, _scrollController.position.maxScrollExtent);
                      _scrollController.animateTo(
                        target,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: LiquidGlass.withOwnLayer(
                      shape: const LiquidRoundedRectangle(
                        borderRadius: 999,
                        side: BorderSide(
                          color: Color(0x33FFFFFF),
                          width: 1,
                        ),
                      ),
                      settings: const LiquidGlassSettings(
                        blur: 12.0,
                        glassColor: Colors.transparent,
                      ),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.7),
                        ),
                        child: Icon(Icons.chevron_right_rounded,
                            size: 22, color: primaryTextColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],

            // Bottom-left Title Tag + GitHub button
            Positioned(
              left: 16,
              bottom: 12,
              child: LiquidGlass.withOwnLayer(
                shape: const LiquidRoundedRectangle(
                  borderRadius: 12,
                  side: BorderSide(
                    color: Color(0x1F000000),
                    width: 1,
                  ),
                ),
                settings: const LiquidGlassSettings(
                  blur: 16.0,
                  glassColor: Colors.transparent,
                ),
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0x44000000)
                        : const Color(0x66FFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.icon,
                        color: accentColor,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${widget.projectNumber} / ${widget.title}",
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => context
                            .read<HomeViewModel>()
                            .launchURL(context, widget.githubUrl),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "GitHub",
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Icon(Icons.north_east_rounded,
                                  size: 10, color: accentColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

