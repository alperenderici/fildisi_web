import 'package:flutter/material.dart';

import '../../atelier/data/catalog.dart';
import '../../atelier/widgets/asymmetric_product_grid.dart';
import '../../atelier/widgets/atelier_tokens.dart';
import '../../atelier/widgets/editorial_scaffold.dart';
import '../../atelier/widgets/minimal_footer.dart';
import '../../atelier/widgets/section_header.dart';

class MacaronCollectionPage extends StatelessWidget {
  const MacaronCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Macarons — Fildişi',
      color: AtelierTokens.cocoa,
      child: SingleChildScrollView(
        child: Column(
          children: [
            EditorialScaffold(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    label: 'Collection',
                    title: 'Macaron Collection',
                    body: 'Thin shells. Clean fillings. Controlled sweetness.',
                  ),
                  const SizedBox(height: AtelierTokens.space8),
                  AsymmetricProductGrid(products: AtelierCatalog.macarons),
                  const SizedBox(height: AtelierTokens.space12),
                  Container(height: 1, color: AtelierTokens.stone),
                  const SizedBox(height: AtelierTokens.space6),
                  Text(
                    'Seasonal rotation—reserve early.',
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
      ),
    );
  }
}
