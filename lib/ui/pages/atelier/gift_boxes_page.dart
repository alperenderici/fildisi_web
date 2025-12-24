import 'package:flutter/material.dart';

import '../../atelier/data/catalog.dart';
import '../../atelier/widgets/asymmetric_product_grid.dart';
import '../../atelier/widgets/atelier_tokens.dart';
import '../../atelier/widgets/editorial_scaffold.dart';
import '../../atelier/widgets/minimal_footer.dart';
import '../../atelier/widgets/section_header.dart';

class GiftBoxesPage extends StatelessWidget {
  const GiftBoxesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Title(
      title: 'Gift Boxes — Fildişi',
      color: AtelierTokens.cocoa,
      child: SingleChildScrollView(
        child: Column(
          children: [
            EditorialScaffold(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    label: 'Gifting',
                    title: 'Gift Boxes',
                    body:
                        'Curated selections finished with understated detail—designed for quiet impact.',
                  ),
                  const SizedBox(height: AtelierTokens.space8),
                  AsymmetricProductGrid(products: AtelierCatalog.giftBoxes),
                  const SizedBox(height: AtelierTokens.space12),
                  Container(
                    decoration: BoxDecoration(
                      color: AtelierTokens.paper,
                      border: Border.all(color: AtelierTokens.stone),
                      borderRadius:
                          BorderRadius.circular(AtelierTokens.radiusM),
                    ),
                    padding: const EdgeInsets.all(AtelierTokens.space8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WHAT ARRIVES',
                          style: theme.textTheme.labelLarge?.copyWith(
                            letterSpacing: 2.4,
                            color: AtelierTokens.cocoaMuted,
                          ),
                        ),
                        const SizedBox(height: AtelierTokens.space4),
                        Text(
                          'A finished gift presentation with care guidance. Storage and serving notes are included.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AtelierTokens.cocoaMuted,
                            height: 1.65,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AtelierTokens.space8),
                  Container(height: 1, color: AtelierTokens.stone),
                  const SizedBox(height: AtelierTokens.space6),
                  Text(
                    'Orders are limited. Reserve in advance.',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AtelierTokens.cocoaMuted),
                  ),
                ],
              ),
            ),
            const MinimalFooter(),
          ],
        ),
      ),
    );
  }
}
