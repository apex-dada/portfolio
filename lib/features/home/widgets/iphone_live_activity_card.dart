import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IphoneLiveActivityCard extends StatefulWidget {
  const IphoneLiveActivityCard({super.key});

  @override
  State<IphoneLiveActivityCard> createState() => _IphoneLiveActivityCardState();
}

class _IphoneLiveActivityCardState extends State<IphoneLiveActivityCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _progressAnimation = Tween<double>(begin: 0.15, end: 0.85).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        child: Center(
          child: AspectRatio(
            aspectRatio: 886 / 1152,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = constraints.maxHeight;

                // Frame bezel proportions derived from 886x1152 phone mockup
                final leftInset = w * (50.0 / 886.0);
                final rightInset = w * (50.0 / 886.0);
                final topInset = h * (57.0 / 1152.0);
                final topCornerRadius = w * (48.0 / 886.0);

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // 1. Phone Screen Contents (precisely clipped inside bezel)
                    Positioned(
                      left: leftInset,
                      right: rightInset,
                      top: topInset,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(topCornerRadius),
                          topRight: Radius.circular(topCornerRadius),
                          bottomLeft: const Radius.circular(16),
                          bottomRight: const Radius.circular(16),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Corrugated Slate-Blue Container Wallpaper
                            Container(
                              color: const Color(0xFF334A60),
                              child: LayoutBuilder(
                                builder: (context, innerConstraints) {
                                  final count = (innerConstraints.maxWidth / 12).floor();
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: List.generate(count, (index) {
                                      return Container(
                                        width: 2,
                                        height: double.infinity,
                                        color: const Color(0xFF283B4E),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),

                            // Vignette / Soft Lighting Gradient
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.18),
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.38),
                                  ],
                                ),
                              ),
                            ),

                            // Status Bar (Time and Icons flanking Dynamic Island)
                            Positioned(
                              top: h * 0.014,
                              left: 18,
                              right: 18,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "9:41",
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.signal_cellular_alt_rounded,
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.wifi_rounded,
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.battery_full_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Lockscreen Date & Clock
                            Positioned(
                              top: h * 0.10,
                              left: 0,
                              right: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Wednesday, June 30",
                                    style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFFC7D3E2),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "17:30",
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 60,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -2.5,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Floating Live Activity Notification Widget
                            Positioned(
                              left: 12,
                              right: 12,
                              bottom: 24,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x33000000),
                                      blurRadius: 18,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Package arriving in 5 min",
                                                style: GoogleFonts.plusJakartaSans(
                                                  color: const Color(0xFF11141A),
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              const SizedBox(height: 1),
                                              Text(
                                                "Delivery from Kazi Woaej Mariz",
                                                style: GoogleFonts.inter(
                                                  color: const Color(0xFF6B7280),
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Geometric Monogram Icon
                                        SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: GridView.count(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 2,
                                            mainAxisSpacing: 2,
                                            physics: const NeverScrollableScrollPhysics(),
                                            children: [
                                              Container(color: const Color(0xFF1E2837)),
                                              Container(color: const Color(0xFF1E2837)),
                                              Container(color: const Color(0xFF1E2837)),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color(0xFF1E2837),
                                                    width: 1.2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),

                                    // Progress Track with Moving Parcel
                                    AnimatedBuilder(
                                      animation: _progressAnimation,
                                      builder: (context, child) {
                                        return Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Container(
                                              height: 3,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE5E9F0),
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                            ),
                                            FractionallySizedBox(
                                              widthFactor: _progressAnimation.value,
                                              child: Container(
                                                height: 3,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF8EAFD1),
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment(
                                                (_progressAnimation.value * 2) - 1,
                                                0,
                                              ),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF1E2837),
                                                  borderRadius: BorderRadius.circular(5),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color(0x26000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.inventory_2_rounded,
                                                    color: Color(0xFF8EAFD1),
                                                    size: 11,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Align(
                                              alignment: Alignment.centerRight,
                                              child: CircleAvatar(
                                                radius: 3.5,
                                                backgroundColor: Color(0xFF8EAFD1),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 2. Realistic Phone Mockup Frame Overlay (covers screen & container)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Image.asset(
                          'assets/images/phone_mockup.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
