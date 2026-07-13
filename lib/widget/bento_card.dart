import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// A highly customizable, interactive card widget designed for Bento Grid layouts.
/// Supports text, icons, custom background images, action buttons, and hover animations.
class BentoCard extends StatefulWidget {
  /// Custom child widget to display inside the card.
  final Widget? child;

  /// Small uppercase category header (e.g., "ABOUT", "RESOURCES").
  final String? title;

  /// Main text content of the card.
  final String? description;

  /// Custom text style for the title/header.
  final TextStyle? titleStyle;

  /// Custom text style for the description.
  final TextStyle? descriptionStyle;

  /// Widget to display at the leading position (top/left).
  final Widget? leading;

  /// Widget to display at the trailing position (typically bottom-right or top-right).
  final Widget? trailing;

  /// Path to a background asset image.
  final String? backgroundImagePath;

  /// Custom widget to use as a background (e.g., Image.network or cached image).
  final Widget? backgroundImage;

  /// Custom background color. Defaults to a premium dark gray (0xFF161616).
  final Color? backgroundColor;

  /// Custom border color. Defaults to a subtle dark gray (0xFF262626).
  final Color? borderColor;

  /// Custom border color when the card is hovered. Defaults to 0xFF444444.
  final Color? hoverBorderColor;

  /// Custom padding inside the card. Defaults to EdgeInsets.all(24.0).
  final EdgeInsetsGeometry? padding;

  /// Card border radius. Defaults to 24.0.
  final double borderRadius;

  /// Action when the card is tapped.
  final VoidCallback? onTap;

  /// Whether the card should animate and scale on hover. Defaults to true.
  final bool isHoverable;

  /// How content should be aligned horizontally. Defaults to CrossAxisAlignment.start.
  final CrossAxisAlignment crossAxisAlignment;

  /// How content should be aligned vertically. Defaults to MainAxisAlignment.start.
  final MainAxisAlignment mainAxisAlignment;

  /// Height of the card (optional).
  final double? height;

  /// Width of the card (optional).
  final double? width;

  const BentoCard({
    super.key,
    this.child,
    this.title,
    this.description,
    this.titleStyle,
    this.descriptionStyle,
    this.leading,
    this.trailing,
    this.backgroundImagePath,
    this.backgroundImage,
    this.backgroundColor,
    this.borderColor,
    this.hoverBorderColor,
    this.padding,
    this.borderRadius = 24.0,
    this.onTap,
    this.isHoverable = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.height,
    this.width,
  });

  /// Factory constructor for a simple text card (like the Introduction card).
  factory BentoCard.text({
    Key? key,
    required String description,
    TextStyle? descriptionStyle,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    double borderRadius = 24.0,
    VoidCallback? onTap,
    double? height,
    double? width,
  }) {
    return BentoCard(
      key: key,
      description: description,
      descriptionStyle: descriptionStyle,
      backgroundColor: backgroundColor,
      padding: padding,
      borderRadius: borderRadius,
      onTap: onTap,
      height: height,
      width: width,
    );
  }

  /// Factory constructor for an image-only card.
  factory BentoCard.image({
    Key? key,
    required Widget image,
    Color? backgroundColor,
    double borderRadius = 24.0,
    VoidCallback? onTap,
    double? height,
    double? width,
  }) {
    return BentoCard(
      key: key,
      backgroundImage: image,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      onTap: onTap,
      padding: EdgeInsets.zero,
      height: height,
      width: width,
    );
  }

  /// Factory constructor for an action card (like the "About" or "Resources" card).
  factory BentoCard.action({
    Key? key,
    required String title,
    required String description,
    required Widget actionButton,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    double borderRadius = 24.0,
    VoidCallback? onTap,
    double? height,
    double? width,
  }) {
    return BentoCard(
      key: key,
      title: title,
      description: description,
      trailing: actionButton,
      backgroundColor: backgroundColor,
      padding: padding,
      borderRadius: borderRadius,
      onTap: onTap,
      height: height,
      width: width,
    );
  }

  @override
  State<BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<BentoCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;

  late final AnimationController _hoverController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    if (!widget.isHoverable) return;
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap == null) return;
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap == null) return;
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    if (widget.onTap == null) return;
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Premium Color Palette
    final defaultBorderColor = isDark ? const Color(0xFF262626) : const Color(0xFFE5E5EA);
    final defaultHoverBorderColor = isDark ? const Color(0xFF444444) : const Color(0xFFD1D1D6);

    final finalBorderColor = _isHovered
        ? (widget.hoverBorderColor ?? defaultHoverBorderColor)
        : (widget.borderColor ?? defaultBorderColor);

    final resolvedPadding = widget.padding ?? const EdgeInsets.all(24.0);

    // Build the main card structure
    Widget cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        children: [
          // Background Image Layer (Asset)
          if (widget.backgroundImagePath != null)
            Positioned.fill(
              child: Image.asset(
                widget.backgroundImagePath!,
                fit: BoxFit.cover,
              ),
            ),

          // Background Image Layer (Custom Widget)
          if (widget.backgroundImage != null)
            Positioned.fill(
              child: widget.backgroundImage!,
            ),

          // Text content or custom child layout
          Padding(
            padding: resolvedPadding,
            child: widget.child ??
                Column(
                  crossAxisAlignment: widget.crossAxisAlignment,
                  mainAxisAlignment: widget.mainAxisAlignment,
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      const SizedBox(height: 16),
                    ],
                    if (widget.title != null) ...[
                      Text(
                        widget.title!.toUpperCase(),
                        style: widget.titleStyle ??
                            TextStyle(
                              color: isDark ? Colors.white38 : Colors.black38,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (widget.description != null)
                      Expanded(
                        child: Text(
                          widget.description!,
                          style: widget.descriptionStyle ??
                              TextStyle(
                                color: isDark ? const Color(0xDEFFFFFF) : Colors.black87,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    if (widget.trailing != null) ...[
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: widget.trailing,
                      ),
                    ],
                  ],
                ),
          ),
        ],
      ),
    );

    // Wrap with AnimatedScale & AnimatedContainer for micro-interactions
    Widget interactiveCard = MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedScale(
            scale: _isPressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? (_isHovered ? const Color(0x66000000) : const Color(0x33000000))
                        : (_isHovered ? const Color(0x339E9E9E) : const Color(0x1A9E9E9E)),
                    blurRadius: _isHovered ? 16 : 8,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
              ),
              child: LiquidGlass.withOwnLayer(
                shape: LiquidRoundedRectangle(
                  borderRadius: widget.borderRadius,
                  side: BorderSide(
                    color: finalBorderColor,
                    width: 1.5,
                  ),
                ),
                settings: const LiquidGlassSettings(
                  blur: 16.0,
                  glassColor: Colors.transparent,
                ),
                child: cardContent,
              ),
            ),
          ),
        ),
      ),
    );

    return interactiveCard;
  }
}
