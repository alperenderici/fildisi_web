import 'package:flutter/material.dart';

import '../../atelier/data/catalog.dart';
import '../../atelier/widgets/asymmetric_product_grid.dart';
import '../../atelier/widgets/atelier_tokens.dart';
import '../../atelier/widgets/editorial_scaffold.dart';
import '../../atelier/widgets/minimal_footer.dart';
import '../../atelier/widgets/section_header.dart';

class BonbonCollectionPage extends StatelessWidget {
  const BonbonCollectionPage({super.key});

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
                  label: 'Collection',
                  title: 'Bonbon Collection',
                  body:
                      'Geometric forms. Gloss finish. Aromatic ganache and fruit reductions—made in limited production.',
                ),
                const SizedBox(height: AtelierTokens.space8),
                AsymmetricProductGrid(products: AtelierCatalog.bonbons),
                const SizedBox(height: AtelierTokens.space12),
                Container(
                  height: 1,
                  color: AtelierTokens.stone,
                ),
                const SizedBox(height: AtelierTokens.space6),
                Text(
                  'Limited production. Seasonal rotation.',
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
