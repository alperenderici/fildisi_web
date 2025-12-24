import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_links.dart';
import '../../atelier/widgets/atelier_tokens.dart';
import '../../atelier/widgets/editorial_scaffold.dart';
import '../../atelier/widgets/minimal_footer.dart';
import '../../atelier/widgets/section_header.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 900;

    return SingleChildScrollView(
      child: Column(
        children: [
          EditorialScaffold(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'Order',
                  title: 'Contact / Order',
                  body:
                      'Orders are limited. Reserve in advance—especially for gifting and seasonal selections.',
                ),
                const SizedBox(height: AtelierTokens.space12),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _LeftColumn(theme: theme)),
                          const SizedBox(width: AtelierTokens.space16),
                          Expanded(child: _RightColumn(theme: theme)),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LeftColumn(theme: theme),
                          const SizedBox(height: AtelierTokens.space12),
                          _RightColumn(theme: theme),
                        ],
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

class _LeftColumn extends StatelessWidget {
  const _LeftColumn({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AtelierTokens.paper,
        border: Border.all(color: AtelierTokens.stone),
        borderRadius: BorderRadius.circular(AtelierTokens.radiusM),
      ),
      padding: const EdgeInsets.all(AtelierTokens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Label(title: 'LOCATION'),
          const SizedBox(height: AtelierTokens.space3),
          Text(
            'Kemalpaşa / İzmir',
            style: theme.textTheme.titleMedium?.copyWith(
              color: AtelierTokens.cocoa,
            ),
          ),
          const SizedBox(height: AtelierTokens.space8),
          _Label(title: 'ADDRESS'),
          const SizedBox(height: AtelierTokens.space3),
          Text(
            'Armutlu 85. Yıl Cumhuriyet, Armutlu Belediye Cd. No:45, 35737 Kemalpaşa/İzmir',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AtelierTokens.cocoaMuted,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AtelierTokens.space6),
          Wrap(
            spacing: AtelierTokens.space4,
            runSpacing: AtelierTokens.space3,
            children: [
              OutlinedButton(
                onPressed: () => _launch(context, AppLinks.maps),
                child: const Text('Open in Maps'),
              ),
              OutlinedButton(
                onPressed: () => _launch(context, AppLinks.instagram),
                child: const Text('Instagram'),
              ),
            ],
          ),
          const SizedBox(height: AtelierTokens.space12),
          _Label(title: 'HOURS'),
          const SizedBox(height: AtelierTokens.space3),
          Text(
            'Mon–Sat: 12:00–21:00\nSun: Closed',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AtelierTokens.cocoaMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launch(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      // Keep silent for luxury feel; can add a subtle toast later.
    }
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AtelierTokens.ivory,
        border: Border.all(color: AtelierTokens.stone),
        borderRadius: BorderRadius.circular(AtelierTokens.radiusM),
      ),
      padding: const EdgeInsets.all(AtelierTokens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Label(title: 'ORDER INQUIRY'),
          const SizedBox(height: AtelierTokens.space4),
          Text(
            'To reserve, share:',
            style: theme.textTheme.titleMedium?.copyWith(
              color: AtelierTokens.cocoa,
            ),
          ),
          const SizedBox(height: AtelierTokens.space6),
          _Bullet(text: 'Desired collection (Bonbon / Macaron / Gift Box)'),
          _Bullet(text: 'Quantity and preferred pickup date'),
          _Bullet(text: 'Any allergies or ingredient preferences'),
          const SizedBox(height: AtelierTokens.space12),
          Container(height: 1, color: AtelierTokens.stone),
          const SizedBox(height: AtelierTokens.space6),
          Text(
            'Lead times vary by seasonal drops and production capacity.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AtelierTokens.cocoaMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            letterSpacing: 2.4,
            color: AtelierTokens.cocoaMuted,
          ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AtelierTokens.space3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AtelierTokens.gold,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: AtelierTokens.space4),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AtelierTokens.cocoaMuted,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
