import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/widgets/bento_card_viewmodel.dart';

/// A highly customizable, interactive card widget designed for Bento Grid layouts.
/// Supports text, icons, custom background images, action buttons, and hover animations.
class BentoCard extends StatelessWidget {
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
    this.borderRadius = 24.0,
    this.onTap,
    this.isHoverable = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.height,
    this.width,
    this.backgroundGradient,
    this.borderWidth = 1.5,
    this.shadows,
    this.glassBlur = 16.0,
    this.glassColor,
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Premium Color Palette
    final defaultBorderColor = isDark ? const Color(0xFF262626) : const Color(0xFFE5E5EA);
    final defaultHoverBorderColor = isDark ? const Color(0xFF444444) : const Color(0xFFD1D1D6);

    final resolvedPadding = padding ?? const EdgeInsets.all(24.0);

    final resolvedGradient = backgroundGradient != null
        ? (backgroundGradient is LinearGradient
            ? LinearGradient(
                begin: (backgroundGradient as LinearGradient).begin,
                end: (backgroundGradient as LinearGradient).end,
                colors: (backgroundGradient as LinearGradient).colors
                    .map((c) => c.withOpacity(isDark ? 0.15 : 0.25))
                    .toList(),
                stops: (backgroundGradient as LinearGradient).stops,
                tileMode: (backgroundGradient as LinearGradient).tileMode,
                transform: (backgroundGradient as LinearGradient).transform,
              )
            : backgroundGradient is RadialGradient
                ? RadialGradient(
                    center: (backgroundGradient as RadialGradient).center,
                    radius: (backgroundGradient as RadialGradient).radius,
                    colors: (backgroundGradient as RadialGradient).colors
                        .map((c) => c.withOpacity(isDark ? 0.15 : 0.25))
                        .toList(),
                    stops: (backgroundGradient as RadialGradient).stops,
                    tileMode: (backgroundGradient as RadialGradient).tileMode,
                    focal: (backgroundGradient as RadialGradient).focal,
                    focalRadius: (backgroundGradient as RadialGradient).focalRadius,
                    transform: (backgroundGradient as RadialGradient).transform,
                  )
                : backgroundGradient)
        : null;

    // Build the main card structure
    Widget cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          // Background Color / Gradient Layer (Glassified)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                gradient: resolvedGradient,
              ),
            ),
          ),

          // Background Image Layer (Asset)
          if (backgroundImagePath != null)
            Positioned.fill(
              child: Image.asset(
                backgroundImagePath!,
                fit: BoxFit.cover,
              ),
            ),

          // Background Image Layer (Custom Widget)
          if (backgroundImage != null)
            Positioned.fill(
              child: backgroundImage!,
            ),

          // Text content or custom child layout
          Padding(
            padding: resolvedPadding,
            child: child ??
                Column(
                  crossAxisAlignment: crossAxisAlignment,
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(height: 16),
                    ],
                    if (title != null) ...[
                      Text(
                        title!.toUpperCase(),
                        style: titleStyle ??
                            GoogleFonts.outfit(
                              color: isDark ? Colors.white38 : Colors.black38,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.0,
                            ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (description != null)
                      Expanded(
                        child: Text(
                          description!,
                          style: descriptionStyle ??
                              GoogleFonts.inter(
                                color: isDark ? const Color(0xDEFFFFFF) : Colors.black87,
                                fontSize: 15.5,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    if (trailing != null) ...[
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: trailing,
                      ),
                    ],
                  ],
                ),
          ),
        ],
      ),
    );

    return ChangeNotifierProvider(
      create: (_) => BentoCardViewModel(),
      child: Consumer<BentoCardViewModel>(
        builder: (context, viewModel, _) {
          final finalBorderColor = viewModel.isHovered
              ? (hoverBorderColor ?? defaultHoverBorderColor)
              : (borderColor ?? defaultBorderColor);

          return MouseRegion(
            onEnter: (_) {
              if (isHoverable) viewModel.setHovered(true);
            },
            onExit: (_) {
              if (isHoverable) viewModel.setHovered(false);
            },
            cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
            child: GestureDetector(
              onTapDown: (_) {
                if (onTap != null) viewModel.setPressed(true);
              },
              onTapUp: (_) {
                if (onTap != null) viewModel.setPressed(false);
              },
              onTapCancel: () {
                if (onTap != null) viewModel.setPressed(false);
              },
              onTap: onTap,
              child: AnimatedScale(
                scale: isHoverable && viewModel.isHovered ? 1.02 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                child: AnimatedScale(
                  scale: viewModel.isPressed ? 0.98 : 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius),
                      boxShadow: shadows ?? [
                        BoxShadow(
                          color: isDark
                              ? (viewModel.isHovered ? const Color(0x66000000) : const Color(0x33000000))
                              : (viewModel.isHovered ? const Color(0x339E9E9E) : const Color(0x1A9E9E9E)),
                          blurRadius: viewModel.isHovered ? 16 : 8,
                          offset: Offset(0, viewModel.isHovered ? 8 : 4),
                        ),
                      ],
                    ),
                    child: LiquidGlass.withOwnLayer(
                      shape: LiquidRoundedRectangle(
                        borderRadius: borderRadius,
                        side: BorderSide(
                          color: finalBorderColor,
                          width: borderWidth,
                        ),
                      ),
                      settings: LiquidGlassSettings(
                        blur: glassBlur,
                        glassColor: glassColor ?? (backgroundColor != null
                            ? backgroundColor!.withOpacity(isDark ? 0.15 : 0.25)
                            : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02))),
                      ),
                      child: cardContent,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
