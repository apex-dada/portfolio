import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkflowList extends StatefulWidget {
  const WorkflowList({super.key});

  @override
  State<WorkflowList> createState() => _WorkflowListState();
}

class _WorkflowListState extends State<WorkflowList>
    with SingleTickerProviderStateMixin {
  static const List<String> _steps = [
    'Requirements',
    'Planning & Design',
    'Project Setup',
    'UI Development',
    'State Management',
    'Business Logic',
    'API Integration',
    'Local Database & Storage',
    'Testing',
    'Debugging & Optimization',
    'Build & Release',
    'Deployment',
    'Monitoring & Maintenance',
  ];

  static final List<String> _displaySteps =
      List.generate(40, (_) => _steps).expand((x) => x).toList();

  final ScrollController _scrollController = ScrollController();
  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent / 2);
        _ticker.start();
      }
    });
  }

  void _onTick(Duration elapsed) {
    if (!mounted || !_scrollController.hasClients) return;
    final dt = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
    _lastElapsed = elapsed;

    if (dt <= 0 || dt > 0.1) return;

    const speed = 25.0; // pixels per second
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    double nextScroll = currentScroll + (speed * dt);
    if (nextScroll >= maxScroll - 60) {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black;

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.white,
            Colors.white,
            Colors.transparent,
          ],
          stops: [0.0, 0.08, 0.92, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Stack(
        children: [
          // Static Timeline Line
          Positioned(
            left: 27,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              color: isDark ? const Color(0xFF262626) : const Color(0xFFE5E5EA),
            ),
          ),
          // Scrolling List
          ListView.builder(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _displaySteps.length,
            itemBuilder: (context, index) {
              final step = _displaySteps[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
                child: Row(
                  children: [
                    // Timeline Dot
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF),
                        boxShadow: [
                          BoxShadow(
                            color: isDark ? const Color(0x663DDC84) : const Color(0x66007AFF),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Step Text
                    Expanded(
                      child: Text(
                        step,
                        style: GoogleFonts.inter(
                          color: primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
