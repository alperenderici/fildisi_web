import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'atelier_tokens.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.isFeatured = false,
    this.onTap,
  });

  final Product product;
  final bool isFeatured;
  final VoidCallback? onTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _reveal = false;

  void _setReveal(bool value) {
    if (_reveal == value) return;
    setState(() => _reveal = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(
        widget.isFeatured ? AtelierTokens.radiusM : AtelierTokens.radiusS);

    final canHover = kIsWeb ||
        {
          TargetPlatform.macOS,
          TargetPlatform.windows,
          TargetPlatform.linux,
        }.contains(defaultTargetPlatform);

    return FocusableActionDetector(
      onShowFocusHighlight: (focused) => _setReveal(focused),
      child: MouseRegion(
        onEnter: canHover ? (_) => _setReveal(true) : null,
        onExit: canHover ? (_) => _setReveal(false) : null,
        child: GestureDetector(
          onTap: () {
            if (!canHover) {
              _setReveal(!_reveal);
              return;
            }
            widget.onTap?.call();
          },
          child: Semantics(
            button: true,
            label: widget.product.name,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: AtelierTokens.ivory,
                borderRadius: radius,
                border: Border.all(
                  color: AtelierTokens.stone,
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: widget.isFeatured ? 4 / 3 : 4 / 5,
                        child: Image.asset(
                          widget.product.imageAsset,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AtelierTokens.space6,
                          AtelierTokens.space6,
                          AtelierTokens.space6,
                          AtelierTokens.space6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: AtelierTokens.cocoa,
                              ),
                            ),
                            const SizedBox(height: AtelierTokens.space2),
                            Text(
                              widget.product.flavorLine,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AtelierTokens.cocoaMuted,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _RevealOverlay(
                    visible: _reveal,
                    radius: radius,
                    notes: widget.product.notes,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RevealOverlay extends StatelessWidget {
  const _RevealOverlay({
    required this.visible,
    required this.radius,
    required this.notes,
  });

  final bool visible;
  final BorderRadius radius;
  final List<String> notes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              color: AtelierTokens.ivory.withValues(alpha: 0.72),
            ),
            padding: const EdgeInsets.all(AtelierTokens.space6),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NOTES',
                    style: theme.textTheme.labelLarge?.copyWith(
                      letterSpacing: 2.0,
                      color: AtelierTokens.cocoa,
                    ),
                  ),
                  const SizedBox(height: AtelierTokens.space3),
                  ...notes.map(
                    (n) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        n,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AtelierTokens.cocoa,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
