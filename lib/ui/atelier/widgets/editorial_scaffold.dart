import 'package:flutter/material.dart';

import 'atelier_tokens.dart';
import 'grain_layer.dart';

class EditorialScaffold extends StatelessWidget {
  const EditorialScaffold({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AtelierTokens.space6,
      vertical: AtelierTokens.space12,
    ),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AtelierTokens.ivory,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          const Positioned.fill(
            child: GrainLayer(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AtelierTokens.maxWidth),
              child: Padding(padding: padding, child: child),
            ),
          ),
        ],
      ),
    );
  }
}
