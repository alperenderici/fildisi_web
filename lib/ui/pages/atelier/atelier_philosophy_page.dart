import 'package:flutter/material.dart';

import '../../atelier/widgets/atelier_tokens.dart';
import '../../atelier/widgets/editorial_scaffold.dart';
import '../../atelier/widgets/minimal_footer.dart';
import '../../atelier/widgets/section_header.dart';

class AtelierPhilosophyPage extends StatelessWidget {
  const AtelierPhilosophyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EditorialScaffold(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'Editorial',
                  title: 'Atelier Philosophy',
                  body:
                      'Quiet precision, sculpted forms, and vivid flavor—built in small batches with intentional detail.',
                ),
                const SizedBox(height: AtelierTokens.space12),
                _Chapter(
                  title: 'Craft',
                  body:
                      'Every piece is finished by hand. Surfaces are polished, edges are clean, and each form is designed to feel like an object—not a dessert.',
                  imageAsset: 'assets/images/bonbon/bonbon6.jpeg',
                ),
                const SizedBox(height: AtelierTokens.space16),
                _Chapter(
                  title: 'Ingredients',
                  body:
                      'Aromatic ganache, fruit reductions, quiet spice. We chase balance—where intensity remains restrained and the finish stays clean.',
                  imageAsset: 'assets/images/bonbon/bonbon_ahududu.jpeg',
                ),
                const SizedBox(height: AtelierTokens.space16),
                _Chapter(
                  title: 'Process',
                  body:
                      'We work in controlled iterations: texture, aroma, finish. Each seasonal drop is measured and repeated only when it earns its place.',
                  imageAsset: 'assets/images/bonbon/bonbon_espresso.jpeg',
                ),
                const SizedBox(height: AtelierTokens.space16),
                _Chapter(
                  title: 'Limited Production',
                  body:
                      'Availability is intentionally limited. Reserve early—especially for gifting and seasonal selections.',
                  imageAsset: 'assets/images/bonbon/bonbon_box.jpeg',
                ),
                const SizedBox(height: AtelierTokens.space12),
                Container(height: 1, color: AtelierTokens.stone),
                const SizedBox(height: AtelierTokens.space6),
                Text(
                  'Seasonal drops are announced via Instagram.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AtelierTokens.cocoaMuted),
                ),
              ],
            ),
          ),
          const MinimalFooter(),
        ],
      ),
    );
  }
}

class _Chapter extends StatelessWidget {
  const _Chapter({
    required this.title,
    required this.body,
    required this.imageAsset,
  });

  final String title;
  final String body;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return isWide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: _ChapterText(title: title, body: body),
              ),
              const SizedBox(width: AtelierTokens.space16),
              Expanded(
                flex: 6,
                child: _ChapterImage(asset: imageAsset),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ChapterImage(asset: imageAsset),
              const SizedBox(height: AtelierTokens.space8),
              _ChapterText(title: title, body: body),
            ],
          );
  }
}

class _ChapterText extends StatelessWidget {
  const _ChapterText({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: AtelierTokens.cocoa,
          ),
        ),
        const SizedBox(height: AtelierTokens.space4),
        Text(
          body,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AtelierTokens.cocoaMuted,
            height: 1.75,
          ),
        ),
      ],
    );
  }
}

class _ChapterImage extends StatelessWidget {
  const _ChapterImage({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AtelierTokens.stone),
        borderRadius: BorderRadius.circular(AtelierTokens.radiusM),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}
