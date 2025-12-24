import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_links.dart';
import 'atelier_tokens.dart';

class MinimalFooter extends StatelessWidget {
  const MinimalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: AtelierTokens.ivory,
      padding: const EdgeInsets.fromLTRB(
        AtelierTokens.space6,
        AtelierTokens.space12,
        AtelierTokens.space6,
        AtelierTokens.space12,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AtelierTokens.maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1,
              color: AtelierTokens.stone,
            ),
            const SizedBox(height: AtelierTokens.space8),
            Text(
              'Fildişi',
              style: theme.textTheme.titleLarge?.copyWith(
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: AtelierTokens.space3),
            Text(
              'Kemalpaşa / İzmir',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AtelierTokens.cocoaMuted,
              ),
            ),
            const SizedBox(height: AtelierTokens.space6),
            Wrap(
              spacing: AtelierTokens.space8,
              runSpacing: AtelierTokens.space3,
              children: [
                _FooterLink(label: 'Instagram', url: AppLinks.instagram),
                _FooterLink(label: 'Harita', url: AppLinks.maps),
              ],
            ),
            const SizedBox(height: AtelierTokens.space8),
            Text(
              '© 2025 Fildişi. Powered by AAD',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AtelierTokens.cocoaMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _launch(url),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          letterSpacing: 1.2,
          color: AtelierTokens.cocoa,
        ),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }
}
