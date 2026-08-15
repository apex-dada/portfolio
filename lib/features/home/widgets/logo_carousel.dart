import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LogoCarousel extends StatefulWidget {
  const LogoCarousel({super.key});

  @override
  State<LogoCarousel> createState() => _LogoCarouselState();
}

class _LogoCarouselState extends State<LogoCarousel>
    with SingleTickerProviderStateMixin {
  static const List<String> _logos = [
    'assets/stack/flutter.png',
    'assets/stack/dart.png',
    'assets/stack/block.png',
    'assets/stack/firebase.png',
    'assets/stack/sqlite.webp',
    'assets/stack/supabase.webp',
  ];

  static final List<String> _displayLogos =
      List.generate(40, (_) => _logos).expand((x) => x).toList();

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

    if (dt <= 0 || dt > 0.1) return; // ignore pauses or large frames

    const speed = 30.0; // pixels per second
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    double nextScroll = currentScroll + (speed * dt);
    if (nextScroll >= maxScroll - 100) {
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
    return SizedBox(
      height: 96,
      child: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _displayLogos.length,
            itemBuilder: (context, index) {
              final logo = _displayLogos[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0, bottom: 12.0),
                child: LiquidGlass.withOwnLayer(
                  shape: const LiquidRoundedRectangle(
                    borderRadius: 20,
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
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      cacheWidth: 120,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
