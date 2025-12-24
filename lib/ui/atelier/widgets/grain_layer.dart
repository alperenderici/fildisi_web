import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'atelier_tokens.dart';

class GrainLayer extends StatelessWidget {
  const GrainLayer({
    super.key,
    this.opacity = 0.055,
    this.density = 0.0012,
  });

  /// Overall grain visibility; keep very subtle.
  final double opacity;

  /// Dots per pixel. 0.0012 ≈ ~1200 dots per 1M pixels.
  final double density;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _GrainPainter(opacity: opacity, density: density),
        ),
      ),
    );
  }
}

class _GrainPainter extends CustomPainter {
  _GrainPainter({required this.opacity, required this.density});

  final double opacity;
  final double density;

  Size? _lastSize;

  @override
  void paint(Canvas canvas, Size size) {
    _lastSize = size;

    final dotCount =
        (size.width * size.height * density).clamp(600, 2400).toInt();
    final rng = math.Random(7);

    final dotPaint = Paint()
      ..color = AtelierTokens.cocoa.withValues(alpha: opacity)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = AtelierTokens.cocoa.withValues(alpha: opacity * 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (var i = 0; i < dotCount; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final r = 0.35 + rng.nextDouble() * 0.75;
      canvas.drawCircle(Offset(x, y), r, dotPaint);

      // A few micro-scratches for a paper-like feel.
      if (i % 14 == 0) {
        final len = 6 + rng.nextDouble() * 18;
        final angle = rng.nextDouble() * math.pi;
        final dx = math.cos(angle) * len;
        final dy = math.sin(angle) * len;
        canvas.drawLine(Offset(x, y), Offset(x + dx, y + dy), strokePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) {
    // Only repaint if parameters change or if size meaningfully changes.
    if (opacity != oldDelegate.opacity) return true;
    if (density != oldDelegate.density) return true;
    if (_lastSize == null || oldDelegate._lastSize == null) return true;
    final dw = _lastSize!.width - oldDelegate._lastSize!.width;
    final dh = _lastSize!.height - oldDelegate._lastSize!.height;
    return (dw * dw + dh * dh) > 4;
  }
}
