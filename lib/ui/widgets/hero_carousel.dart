import 'dart:async';

import 'package:flutter/material.dart';

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key, required this.imageAssets, this.height = 380});

  final List<String> imageAssets;
  final double height;

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || widget.imageAssets.isEmpty) return;
      final next = (_index + 1) % widget.imageAssets.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (!mounted || widget.imageAssets.isEmpty) return;
    final next = (_index + 1) % widget.imageAssets.length;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _resetTimer();
  }

  void _prevPage() {
    if (!mounted || widget.imageAssets.isEmpty) return;
    final prev =
        (_index - 1 + widget.imageAssets.length) % widget.imageAssets.length;
    _controller.animateToPage(
      prev,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _resetTimer();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted || widget.imageAssets.isEmpty) return;
      final next = (_index + 1) % widget.imageAssets.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageAssets.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.imageAssets.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.imageAssets[index],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            // Navigation Arrows
            if (MediaQuery.of(context).size.width > 600) ...[
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton.filled(
                    onPressed: _prevPage,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black26,
                      foregroundColor: Colors.white,
                      hoverColor: primary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton.filled(
                    onPressed: _nextPage,
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black26,
                      foregroundColor: Colors.white,
                      hoverColor: primary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ],
            // Indicators
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _Dots(
                  count: widget.imageAssets.length,
                  activeIndex: _index,
                  color: Colors.white,
                  activeColor: theme.colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({
    required this.count,
    required this.activeIndex,
    required this.color,
    this.activeColor,
  });

  final int count;
  final int activeIndex;
  final Color color;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: i == activeIndex ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == activeIndex
                    ? (activeColor ?? color)
                    : color.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}
