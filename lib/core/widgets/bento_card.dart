import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
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

  /// Card border radius. Defaults to 28.0.
  final double borderRadius;

  /// Action when the card is tapped.
  final VoidCallback? onTap;

  /// Whether the card should animate and scale on hover. Defaults to true.
  final bool isHoverable;

  /// Whether to apply liquid glass effect to the card. Defaults to true.
  final bool enableGlass;

  /// How content should be aligned horizontally. Defaults to CrossAxisAlignment.start.
  final CrossAxisAlignment crossAxisAlignment;

  /// How content should be aligned vertically. Defaults to MainAxisAlignment.start.
  final MainAxisAlignment mainAxisAlignment;

  /// Height of the card (optional).
  final double? height;

  /// Width of the card (optional).
  final double? width;

  /// Custom background gradient.
  final Gradient? backgroundGradient;

  /// Custom border width. Defaults to 1.5.
  final double borderWidth;

  /// Custom box shadows.
  final List<BoxShadow>? shadows;

  /// Custom glass blur value. Defaults to 16.0.
  final double glassBlur;

  /// Custom glass overlay color.
  final Color? glassColor;

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
    this.borderRadius = 28.0,
    this.onTap,
    this.isHoverable = true,
    this.enableGlass = false,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.height,
    this.width,
    this.backgroundGradient,
    this.borderWidth = 1.0,
    this.shadows,
    this.glassBlur = 16.0,
    this.glassColor,
  });

  /// Factory constructor for a standard Media/Image Card.
  factory BentoCard.media({
    Key? key,
    required String imagePath,
    String? title,
    String? description,
    VoidCallback? onTap,
    double? height,
    double? width,
    double borderRadius = 24.0,
    Widget? overlayContent,
  }) {
    return BentoCard(
      key: key,
      backgroundImagePath: imagePath,
      title: title,
      description: description,
      onTap: onTap,
      height: height,
      width: width,
      borderRadius: borderRadius,
      child: overlayContent,
    );
  }

  /// Factory constructor for a Feature/Highlight Card with a leading Icon.
  factory BentoCard.feature({
    Key? key,
    required IconData icon,
    required String title,
    required String description,
    Color? iconColor,
    VoidCallback? onTap,
    double? height,
    double? width,
  }) {
    return BentoCard(
      key: key,
      leading: Icon(icon, size: 28, color: iconColor ?? Colors.white),
      title: title,
      description: description,
      onTap: onTap,
      height: height,
      width: width,
    );
  }

  /// Factory constructor for an Action/CTA Card.
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

class _BentoCardState extends State<BentoCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Premium Color Palette
    final defaultBorderColor = isDark ? const Color(0xFF262626) : const Color(0xFFE5E5EA);
    final defaultHoverBorderColor = isDark ? const Color(0xFF444444) : const Color(0xFFD1D1D6);

    final resolvedPadding = widget.padding ?? const EdgeInsets.all(24.0);

    final resolvedGradient = widget.backgroundGradient != null
        ? (widget.backgroundGradient is LinearGradient
            ? LinearGradient(
                begin: (widget.backgroundGradient as LinearGradient).begin,
                end: (widget.backgroundGradient as LinearGradient).end,
                colors: (widget.backgroundGradient as LinearGradient).colors
                    .map((c) => c.withValues(alpha: isDark ? 0.15 : 0.25))
                    .toList(),
                stops: (widget.backgroundGradient as LinearGradient).stops,
                tileMode: (widget.backgroundGradient as LinearGradient).tileMode,
                transform: (widget.backgroundGradient as LinearGradient).transform,
              )
            : widget.backgroundGradient is RadialGradient
                ? RadialGradient(
                    center: (widget.backgroundGradient as RadialGradient).center,
                    radius: (widget.backgroundGradient as RadialGradient).radius,
                    colors: (widget.backgroundGradient as RadialGradient).colors
                        .map((c) => c.withValues(alpha: isDark ? 0.15 : 0.25))
                        .toList(),
                    stops: (widget.backgroundGradient as RadialGradient).stops,
                    tileMode: (widget.backgroundGradient as RadialGradient).tileMode,
                    focal: (widget.backgroundGradient as RadialGradient).focal,
                    focalRadius: (widget.backgroundGradient as RadialGradient).focalRadius,
                    transform: (widget.backgroundGradient as RadialGradient).transform,
                  )
                : widget.backgroundGradient)
        : null;

    final finalBorderColor = _isHovered
        ? (widget.hoverBorderColor ?? defaultHoverBorderColor)
        : (widget.borderColor ?? defaultBorderColor);

    final cardBgColor = widget.backgroundColor ??
        (isDark ? const Color(0xFF15181E) : const Color(0xFFECEFF4));

    // Build the main card structure
    Widget cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        children: [
          // Background Color / Gradient Layer
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                gradient: resolvedGradient,
              ),
            ),
          ),

          // Background Image Layer (Asset)
          if (widget.backgroundImagePath != null)
            Positioned.fill(
              child: Image.asset(
                widget.backgroundImagePath!,
                fit: BoxFit.cover,
                cacheWidth: 800,
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
                            GoogleFonts.plusJakartaSans(
                              color: isDark ? const Color(0xFF8EAFD1) : const Color(0xFF1E2837),
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                            ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (widget.description != null)
                      Expanded(
                        child: Text(
                          widget.description!,
                          style: widget.descriptionStyle ??
                              GoogleFonts.inter(
                                color: isDark ? const Color(0xDEFFFFFF) : Colors.black87,
                                fontSize: 15.5,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
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

    final borderSide = BorderSide(
      color: finalBorderColor,
      width: widget.borderWidth,
    );

    Widget containerWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: widget.shadows ?? [
          BoxShadow(
            color: isDark
                ? (_isHovered ? const Color(0x66000000) : const Color(0x33000000))
                : (_isHovered ? const Color(0x339E9E9E) : const Color(0x1A9E9E9E)),
            blurRadius: _isHovered ? 16 : 8,
            offset: Offset(0, _isHovered ? 8 : 4),
          ),
        ],
      ),
      child: cardContent,
    );

    Widget blurredContainer = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: widget.glassBlur,
          sigmaY: widget.glassBlur,
        ),
        child: containerWidget,
      ),
    );

    Widget cardWidget = (widget.enableGlass && !kIsWeb)
        ? LiquidGlass.withOwnLayer(
            shape: LiquidRoundedRectangle(
              borderRadius: widget.borderRadius,
              side: borderSide,
            ),
            settings: LiquidGlassSettings(
              blur: widget.glassBlur,
              glassColor: Colors.transparent,
            ),
            child: containerWidget,
          )
        : Container(
            decoration: BoxDecoration(
              border: Border.all(color: finalBorderColor, width: widget.borderWidth),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: widget.enableGlass ? blurredContainer : containerWidget,
          );

    return MouseRegion(
      onEnter: (_) {
        if (widget.isHoverable) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (widget.isHoverable) setState(() => _isHovered = false);
      },
      cursor: SystemMouseCursors.none,
      child: GestureDetector(
        onTapDown: (_) {
          if (widget.onTap != null) setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          if (widget.onTap != null) setState(() => _isPressed = false);
        },
        onTapCancel: () {
          if (widget.onTap != null) setState(() => _isPressed = false);
        },
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: widget.isHoverable && _isHovered ? 1.015 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedScale(
            scale: _isPressed ? 0.985 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: cardWidget,
          ),
        ),
      ),
    );
  }
}
