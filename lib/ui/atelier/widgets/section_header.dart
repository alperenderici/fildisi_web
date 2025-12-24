import 'package:flutter/material.dart';

import 'atelier_tokens.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.body,
  });

  final String label;
  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            letterSpacing: 2.4,
            color: AtelierTokens.cocoaMuted,
          ),
        ),
        const SizedBox(height: AtelierTokens.space3),
        Text(
          title,
          style: theme.textTheme.headlineLarge?.copyWith(
            color: AtelierTokens.cocoa,
          ),
        ),
        if (body != null) ...[
          const SizedBox(height: AtelierTokens.space4),
          Text(
            body!,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AtelierTokens.cocoaMuted,
              height: 1.65,
            ),
          ),
        ],
      ],
    );
  }
}
