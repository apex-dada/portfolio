import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';

/// A GPU-isolated cursor follower overlay.
///
/// Architecture:
/// - Raw cursor position lives in local [ValueNotifier]s — never routed through Provider.
/// - Config (color, size, enabled) is read via [Selector] — no [Consumer]/context.watch.
/// - Wrapped in [RepaintBoundary] + [IgnorePointer] so repaints stay on its own layer
///   and it never blocks hover/click on underlying widgets.
///
/// Verification: toggle `debugRepaintRainbowEnabled = true` — only this widget's
/// RepaintBoundary should flash on mouse move, not the card grid.
class CursorFollower extends StatefulWidget {
  const CursorFollower({super.key});

  @override
  State<CursorFollower> createState() => _CursorFollowerState();
}

class _CursorFollowerState extends State<CursorFollower>
    with SingleTickerProviderStateMixin {
  // ── Local-only position state (never touches Provider) ──
  final ValueNotifier<Offset> _ringPosition = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> _dotPosition = ValueNotifier(Offset.zero);
  final ValueNotifier<double> _opacity = ValueNotifier(0.0);

  Offset _targetPosition = Offset.zero;
  bool _isInsideViewport = false;

  late final Ticker _ticker;

  // Lerp speeds
  static const double _ringSpeed = 0.15;
  static const double _dotSpeed = 0.08;
  static const double _opacitySpeed = 0.12;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _ringPosition.dispose();
    _dotPosition.dispose();
    _opacity.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    // Lerp ring toward target (fast)
    final currentRing = _ringPosition.value;
    final newRing = Offset.lerp(currentRing, _targetPosition, _ringSpeed)!;
    if ((newRing - currentRing).distanceSquared > 0.01) {
      _ringPosition.value = newRing;
    }

    // Lerp dot toward target (slower — trails behind the ring)
    final currentDot = _dotPosition.value;
    final newDot = Offset.lerp(currentDot, _targetPosition, _dotSpeed)!;
    if ((newDot - currentDot).distanceSquared > 0.01) {
      _dotPosition.value = newDot;
    }

    // Lerp opacity for smooth fade in/out
    final targetOpacity = _isInsideViewport ? 1.0 : 0.0;
    final currentOpacity = _opacity.value;
    final newOpacity =
        currentOpacity + (targetOpacity - currentOpacity) * _opacitySpeed;
    if ((newOpacity - currentOpacity).abs() > 0.001) {
      _opacity.value = newOpacity.clamp(0.0, 1.0);
    }
  }

  void _onPointerHover(PointerEvent event) {
    _targetPosition = event.localPosition;
    if (!_isInsideViewport) {
      _isInsideViewport = true;
      // Snap both positions to avoid trailing-in from (0,0)
      _ringPosition.value = event.localPosition;
      _dotPosition.value = event.localPosition;
    }
  }

  void _onPointerExit(PointerEvent event) {
    _isInsideViewport = false;
  }

  @override
  Widget build(BuildContext context) {
    // Read config via Selector — no Consumer/context.watch
    return Selector<HomeViewModel, ({bool enabled, Color color, double size, double dotSize})>(
      selector: (_, vm) => (
        enabled: vm.cursorFollowerEnabled,
        color: vm.cursorFollowerColor,
        size: vm.cursorFollowerSize,
        dotSize: vm.cursorDotSize,
      ),
      builder: (context, config, _) {
        if (!config.enabled) return const SizedBox.shrink();

        return MouseRegion(
          opaque: false,
          onHover: _onPointerHover,
          onExit: _onPointerExit,
          child: RepaintBoundary(
            child: IgnorePointer(
              child: ValueListenableBuilder<double>(
                valueListenable: _opacity,
                builder: (_, opacity, child) {
                  if (opacity < 0.005) return const SizedBox.expand();

                  return Opacity(
                    opacity: opacity,
                    child: ValueListenableBuilder<Offset>(
                      valueListenable: _ringPosition,
                      builder: (_, ringPos, child) {
                        return ValueListenableBuilder<Offset>(
                          valueListenable: _dotPosition,
                          builder: (_, dotPos, child) {
                            return CustomPaint(
                              size: Size.infinite,
                              painter: _CursorFollowerPainter(
                                ringPosition: ringPos,
                                dotPosition: dotPos,
                                ringColor: config.color,
                                ringSize: config.size,
                                dotSize: config.dotSize,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CursorFollowerPainter extends CustomPainter {
  final Offset ringPosition;
  final Offset dotPosition;
  final Color ringColor;
  final double ringSize;
  final double dotSize;

  _CursorFollowerPainter({
    required this.ringPosition,
    required this.dotPosition,
    required this.ringColor,
    required this.ringSize,
    required this.dotSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Outer ring — stroke only
    final ringPaint = Paint()
      ..color = ringColor.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..isAntiAlias = true;

    canvas.drawCircle(ringPosition, ringSize / 2, ringPaint);

    // Inner dot — filled, at the dot's own (slower) position
    final dotPaint = Paint()
      ..color = ringColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawCircle(dotPosition, dotSize / 2, dotPaint);
  }

  @override
  bool shouldRepaint(_CursorFollowerPainter oldDelegate) {
    return ringPosition != oldDelegate.ringPosition ||
        dotPosition != oldDelegate.dotPosition ||
        ringColor != oldDelegate.ringColor ||
        ringSize != oldDelegate.ringSize ||
        dotSize != oldDelegate.dotSize;
  }
}
