import 'package:flutter/material.dart';

class PortraitPeriwinkleCard extends StatefulWidget {
  const PortraitPeriwinkleCard({super.key});

  @override
  State<PortraitPeriwinkleCard> createState() => _PortraitPeriwinkleCardState();
}

class _PortraitPeriwinkleCardState extends State<PortraitPeriwinkleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const periwinkle = Color(0xFF8EAFD1);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: periwinkle,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? periwinkle.withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: _isHovered ? 24 : 12,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // High-res Portrait of Mariz
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: 220,
                  height: 220,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(100)),
                    child: Image.asset(
                      'assets/images/IMG_0741 (1).jpg',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

              // Studio Monogram Badge in Top-Left Corner
              Positioned(
                top: 20,
                left: 20,
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(4, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
