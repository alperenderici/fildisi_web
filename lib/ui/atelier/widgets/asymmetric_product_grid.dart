import 'package:flutter/material.dart';

import '../models/product.dart';
import 'atelier_tokens.dart';
import 'product_card.dart';

class AsymmetricProductGrid extends StatelessWidget {
  const AsymmetricProductGrid({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= 980 && products.length >= 4) {
          // A calm, editorial rhythm:
          // Row 1: featured + standard
          // Row 2: 3 standards
          // Row 3+: 2-col pairs
          final remaining = products.skip(5).toList();

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ProductCard(
                      product: products[0],
                      isFeatured: true,
                    ),
                  ),
                  const SizedBox(width: AtelierTokens.space6),
                  Expanded(
                    flex: 1,
                    child: ProductCard(product: products[1]),
                  ),
                ],
              ),
              const SizedBox(height: AtelierTokens.space6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ProductCard(product: products[2])),
                  const SizedBox(width: AtelierTokens.space6),
                  Expanded(child: ProductCard(product: products[3])),
                  const SizedBox(width: AtelierTokens.space6),
                  Expanded(child: ProductCard(product: products[4])),
                ],
              ),
              if (remaining.isNotEmpty) ...[
                const SizedBox(height: AtelierTokens.space6),
                _TwoColumnPairs(products: remaining),
              ],
            ],
          );
        }

        if (width >= 680 && products.length >= 2) {
          // Tablet: 2-column rhythm.
          final rows = <Widget>[];
          for (var i = 0; i < products.length; i += 2) {
            final left = products[i];
            final right = i + 1 < products.length ? products[i + 1] : null;
            rows.add(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProductCard(
                      product: left,
                      isFeatured: i == 0,
                    ),
                  ),
                  if (right != null) ...[
                    const SizedBox(width: AtelierTokens.space6),
                    Expanded(child: ProductCard(product: right)),
                  ],
                ],
              ),
            );
            if (i + 2 < products.length) {
              rows.add(const SizedBox(height: AtelierTokens.space6));
            }
          }
          return Column(children: rows);
        }

        // Mobile: single column.
        return Column(
          children: [
            for (var i = 0; i < products.length; i++) ...[
              ProductCard(product: products[i], isFeatured: i == 0),
              if (i != products.length - 1)
                const SizedBox(height: AtelierTokens.space6),
            ],
          ],
        );
      },
    );
  }
}

class _TwoColumnPairs extends StatelessWidget {
  const _TwoColumnPairs({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < products.length; i += 2) {
      final left = products[i];
      final right = i + 1 < products.length ? products[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ProductCard(product: left)),
            if (right != null) ...[
              const SizedBox(width: AtelierTokens.space6),
              Expanded(child: ProductCard(product: right)),
            ],
          ],
        ),
      );
      if (i + 2 < products.length) {
        rows.add(const SizedBox(height: AtelierTokens.space6));
      }
    }

    return Column(children: rows);
  }
}
