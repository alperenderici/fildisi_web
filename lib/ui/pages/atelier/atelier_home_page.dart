import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_links.dart';
import '../../atelier/data/catalog.dart';
import '../../atelier/widgets/asymmetric_product_grid.dart';
import '../../atelier/widgets/atelier_tokens.dart';
import '../../atelier/widgets/editorial_scaffold.dart';
import '../../atelier/widgets/fade_in.dart';
import '../../atelier/widgets/minimal_footer.dart';
import '../../atelier/widgets/section_header.dart';

class AtelierHomePage extends StatelessWidget {
  const AtelierHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Fildişi — Chocolate & Macaron Atelier',
      color: AtelierTokens.cocoa,
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 900;

    return SingleChildScrollView(
      child: Column(
        children: [
          // HERO
          Container(
            color: AtelierTokens.ivory,
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AtelierTokens.maxWidth),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AtelierTokens.space6,
                  AtelierTokens.space16,
                  AtelierTokens.space6,
                  AtelierTokens.space16,
                ),
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: FadeIn(
                              child: _HeroCopy(
                                onPrimaryCta: () => context.go('/bonbonlar'),
                                onSecondaryCta: () =>
                                    context.go('/hediye-kutulari'),
                              ),
                            ),
                          ),
                          const SizedBox(width: AtelierTokens.space16),
                          Expanded(
                            flex: 6,
                            child: FadeIn(
                              delay: const Duration(milliseconds: 120),
                              child: _HeroMedia(),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeIn(child: _HeroMedia()),
                          const SizedBox(height: AtelierTokens.space12),
                          FadeIn(
                            delay: const Duration(milliseconds: 120),
                            child: _HeroCopy(
                              onPrimaryCta: () => context.go('/bonbonlar'),
                              onSecondaryCta: () =>
                                  context.go('/hediye-kutulari'),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          // BONBONS PREVIEW
          EditorialScaffold(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'Collection',
                  title: 'Bonbons',
                  body:
                      'Geometric forms. Gloss finish. A restrained intensity.',
                ),
                const SizedBox(height: AtelierTokens.space8),
                AsymmetricProductGrid(
                    products: AtelierCatalog.bonbons.take(5).toList()),
                const SizedBox(height: AtelierTokens.space8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => context.go('/bonbonlar'),
                    child: const Text('Explore Bonbons'),
                  ),
                ),
              ],
            ),
          ),

          // MACARONS PREVIEW
          EditorialScaffold(
            padding: const EdgeInsets.fromLTRB(
              AtelierTokens.space6,
              0,
              AtelierTokens.space6,
              AtelierTokens.space12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'Collection',
                  title: 'Macarons',
                  body: 'Thin shells. Clean fillings. Precision.',
                ),
                const SizedBox(height: AtelierTokens.space8),
                AsymmetricProductGrid(products: AtelierCatalog.macarons),
                const SizedBox(height: AtelierTokens.space8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => context.go('/makaronlar'),
                    child: const Text('Explore Macarons'),
                  ),
                ),
              ],
            ),
          ),

          // PHILOSOPHY TEASER
          EditorialScaffold(
            padding: const EdgeInsets.fromLTRB(
              AtelierTokens.space6,
              0,
              AtelierTokens.space6,
              AtelierTokens.space12,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AtelierTokens.paper,
                border: Border.all(color: AtelierTokens.stone),
                borderRadius: BorderRadius.circular(AtelierTokens.radiusM),
              ),
              padding: const EdgeInsets.all(AtelierTokens.space8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ATELIER PHILOSOPHY',
                    style: theme.textTheme.labelLarge?.copyWith(
                      letterSpacing: 2.4,
                      color: AtelierTokens.cocoaMuted,
                    ),
                  ),
                  const SizedBox(height: AtelierTokens.space3),
                  Text(
                    'Small batches. Intentional detail.',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AtelierTokens.cocoa,
                    ),
                  ),
                  const SizedBox(height: AtelierTokens.space4),
                  Text(
                    'Handcrafted bonbons built from aromatic ganache, fruit reductions, and quiet spice—made with precision, in limited production.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AtelierTokens.cocoaMuted,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: AtelierTokens.space6),
                  TextButton(
                    onPressed: () => context.go('/atolye-felsefesi'),
                    child: const Text('Read the philosophy'),
                  ),
                ],
              ),
            ),
          ),

          // Minimal Instagram link strip
          EditorialScaffold(
            padding: const EdgeInsets.fromLTRB(
              AtelierTokens.space6,
              0,
              AtelierTokens.space6,
              AtelierTokens.space12,
            ),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: AtelierTokens.space6),
              child: Row(
                children: [
                  Container(width: 24, height: 1, color: AtelierTokens.stone),
                  const SizedBox(width: AtelierTokens.space4),
                  Text(
                    'INSTAGRAM',
                    style: theme.textTheme.labelLarge?.copyWith(
                      letterSpacing: 2.4,
                      color: AtelierTokens.cocoaMuted,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _openLink(context, AppLinks.instagram),
                    child: const Text('@fildisiatolye'),
                  ),
                ],
              ),
            ),
          ),

          const MinimalFooter(),
        ],
      ),
    );
  }

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.onPrimaryCta,
    required this.onSecondaryCta,
  });

  final VoidCallback onPrimaryCta;
  final VoidCallback onSecondaryCta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sculpted chocolate.\nDesigned to linger.',
          style: theme.textTheme.displayLarge?.copyWith(
            color: AtelierTokens.cocoa,
            height: 1.05,
          ),
        ),
        const SizedBox(height: AtelierTokens.space6),
        Text(
          'Handcrafted bonbons with aromatic ganache and seasonal notes.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AtelierTokens.cocoaMuted,
            height: 1.7,
          ),
        ),
        const SizedBox(height: AtelierTokens.space8),
        Wrap(
          spacing: AtelierTokens.space4,
          runSpacing: AtelierTokens.space3,
          children: [
            FilledButton(
              onPressed: onPrimaryCta,
              child: const Text('Explore Bonbons'),
            ),
            OutlinedButton(
              onPressed: onSecondaryCta,
              child: const Text('Gift Boxes'),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AtelierTokens.stone),
        borderRadius: BorderRadius.circular(AtelierTokens.radiusM),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Image.asset(
          AtelierCatalog.heroBonbonImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
