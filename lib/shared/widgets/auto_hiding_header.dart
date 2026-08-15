import 'package:flutter/material.dart';

/// A wrapper widget that provides a butter-smooth auto-hiding header (AppBar).
///
/// - Shows when at the top of the scrollable (pixels <= 10).
/// - Hides smoothly when scrolling down.
/// - Shows smoothly when scrolling up.
class AutoHidingHeader extends StatefulWidget {
  final Widget child;
  final Widget appBar;
  final double maxWidth;

  const AutoHidingHeader({
    super.key,
    required this.child,
    required this.appBar,
    this.maxWidth = 1200,
  });

  @override
  State<AutoHidingHeader> createState() => _AutoHidingHeaderState();
}

class _AutoHidingHeaderState extends State<AutoHidingHeader> {
  bool _isVisible = true;
  double _accumulatedDelta = 0;

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;
    if (notification.depth != 0) return false;

    final pixels = notification.metrics.pixels;

    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;

      // Always show when near the very top of the page
      if (pixels <= 10) {
        _accumulatedDelta = 0;
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
        return false;
      }

      // Track scroll direction changes
      if ((delta > 0 && _accumulatedDelta < 0) || (delta < 0 && _accumulatedDelta > 0)) {
        _accumulatedDelta = 0;
      }
      _accumulatedDelta += delta;

      // Hide on scrolling down past threshold
      if (_accumulatedDelta > 12) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      }
      // Show on scrolling up past threshold
      else if (_accumulatedDelta < -12) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: Stack(
        children: [
          // Main scrollable content filling full screen area
          Positioned.fill(
            child: widget.child,
          ),

          // Auto-hiding floating AppBar
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.maxWidth),
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 350),
                curve: const Cubic(0.2, 0.8, 0.2, 1.0),
                offset: _isVisible ? Offset.zero : const Offset(0, -1.3),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeInOut,
                  opacity: _isVisible ? 1.0 : 0.0,
                  child: IgnorePointer(
                    ignoring: !_isVisible,
                    child: widget.appBar,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
