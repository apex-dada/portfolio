import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ImagePreviewDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final String title;

  const ImagePreviewDialog({
    super.key,
    required this.images,
    this.initialIndex = 0,
    this.title = '',
  });

  static void show(BuildContext context, {required List<String> images, int initialIndex = 0, String title = ''}) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (context) => ImagePreviewDialog(
        images: images,
        initialIndex: initialIndex,
        title: title,
      ),
    );
  }

  @override
  State<ImagePreviewDialog> createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
  late final PageController _pageController;
  late int _currentIndex;
  final TransformationController _transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main Image PageView with InteractiveViewer (Zoom)
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              _resetZoom();
            },
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.images[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),

          // Top Header Bar (Title, Counter, Close)
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title and counter pill
                LiquidGlass.withOwnLayer(
                  shape: const LiquidRoundedRectangle(
                    borderRadius: 20,
                    side: BorderSide(
                      color: Color(0x33FFFFFF),
                      width: 1,
                    ),
                  ),
                  settings: const LiquidGlassSettings(
                    blur: 16.0,
                    glassColor: Colors.transparent,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${widget.title.isNotEmpty ? '${widget.title}  •  ' : ''}${_currentIndex + 1} / ${widget.images.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Action buttons: Reset zoom & Close
                Row(
                  children: [
                    IconButton(
                      onPressed: _resetZoom,
                      tooltip: 'Reset Zoom',
                      icon: LiquidGlass.withOwnLayer(
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
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: const Icon(Icons.zoom_out_map_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close',
                      icon: LiquidGlass.withOwnLayer(
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
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Left Chevron (if multi-image)
          if (widget.images.length > 1 && _currentIndex > 0)
            Positioned(
              left: 12,
              child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
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
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),

          // Right Chevron (if multi-image)
          if (widget.images.length > 1 && _currentIndex < widget.images.length - 1)
            Positioned(
              right: 12,
              child: GestureDetector(
                onTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
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
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
