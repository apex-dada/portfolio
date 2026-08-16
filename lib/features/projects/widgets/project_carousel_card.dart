import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';
import 'package:portfolio/features/projects/widgets/image_preview_dialog.dart';

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
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final isDark = context.select<HomeViewModel, bool>((vm) => vm.isDarkMode);

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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0x33242C38)
                                  : const Color(0x1F000000),
                              width: 1,
                            ),
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
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? const Color(0xFF1E2837)
                            : const Color(0xFFECEFF4),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 22,
                        color: isDark ? Colors.white : const Color(0xFF1E2837),
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
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? const Color(0xFF1E2837)
                            : const Color(0xFFECEFF4),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 22,
                        color: isDark ? Colors.white : const Color(0xFF1E2837),
                      ),
                    ),
                  ),
                ),
              ),
            ],

            // Bottom-left Solid Title Tag + GitHub button
            Positioned(
              left: 16,
              bottom: 14,
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFFECEFF4)
                      : const Color(0xFF1E2837),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      color: isDark
                          ? const Color(0xFF1E2837)
                          : Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${widget.projectNumber} / ${widget.title}",
                      style: GoogleFonts.plusJakartaSans(
                        color: isDark
                            ? const Color(0xFF1E2837)
                            : Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => context
                          .read<HomeViewModel>()
                          .launchURL(context, widget.githubUrl),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E2837)
                              : const Color(0xFF8EAFD1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "GitHub",
                              style: GoogleFonts.plusJakartaSans(
                                color: isDark
                                    ? const Color(0xFF8EAFD1)
                                    : const Color(0xFF1E2837),
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.north_east_rounded,
                              size: 11,
                              color: isDark
                                  ? const Color(0xFF8EAFD1)
                                  : const Color(0xFF1E2837),
                            ),
                          ],
                        ),
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
