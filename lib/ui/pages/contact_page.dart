import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fildisi_web/l10n/app_localizations.dart';

import '../../app_links.dart';
import '../widgets/app_footer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  static const _phone = '0534 820 48 89';

  Future<void> _openUrl(BuildContext context, String url) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.snackLinkFailed)));
    }
  }

  Future<void> _callPhone(BuildContext context, String phone) async {
    final l10n = AppLocalizations.of(context)!;
    final telUri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    final ok = await launchUrl(telUri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.snackCallFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.contactTitle,
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 48),
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: _ContactInfo(
                              l10n: l10n,
                              phone: _phone,
                              onOpenUrl: (url) => _openUrl(context, url),
                              onCallPhone: (phone) =>
                                  _callPhone(context, phone),
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 4,
                            child: _HoursBlock(
                              title: l10n.hoursTitle,
                              hoursText: l10n.hoursLong,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _ContactInfo(
                            l10n: l10n,
                            phone: _phone,
                            onOpenUrl: (url) => _openUrl(context, url),
                            onCallPhone: (phone) => _callPhone(context, phone),
                          ),
                          const SizedBox(height: 32),
                          _HoursBlock(
                            title: l10n.hoursTitle,
                            hoursText: l10n.hoursLong,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Footer at bottom
          const AppFooter(),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({
    required this.l10n,
    required this.phone,
    required this.onOpenUrl,
    required this.onCallPhone,
  });

  final AppLocalizations l10n;
  final String phone;
  final Function(String) onOpenUrl;
  final Function(String) onCallPhone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _ContactCard(
          icon: Icons.location_on_outlined,
          title: l10n.infoAddressTitle,
          content: l10n.infoAddressBody,
          actionLabel: l10n.contactOpenOnMap,
          onAction: () => onOpenUrl(AppLinks.maps),
          extraContent: Container(
            height: 180,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onOpenUrl(AppLinks.maps),
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Placeholder pattern or gradient
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.surfaceVariant,
                            theme.colorScheme.surface,
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 48,
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.contactOpenOnMap,
                          style: TextStyle(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.7,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _ContactCard(
          icon: Icons.phone_outlined,
          title: l10n.infoPhoneTitle,
          content: phone,
          actionLabel: l10n.contactCall,
          onAction: () => onCallPhone(phone),
        ),
        const SizedBox(height: 24),
        _ContactCard(
          icon: FontAwesomeIcons.instagram,
          title: l10n.footerInstagram,
          content: AppLinks.instagram,
          actionLabel: l10n.contactOpenInstagram,
          onAction: () => onOpenUrl(AppLinks.instagram),
          isFontAwesome: true,
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.actionLabel,
    required this.onAction,
    this.isFontAwesome = false,
    this.extraContent,
  });

  final IconData icon;
  final String title;
  final String content;
  final String actionLabel;
  final VoidCallback onAction;
  final bool isFontAwesome;
  final Widget? extraContent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isFontAwesome)
                FaIcon(icon, size: 24, color: theme.colorScheme.primary)
              else
                Icon(icon, size: 28, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (extraContent != null) extraContent!,
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onAction,
              child: Text(actionLabel),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoursBlock extends StatelessWidget {
  const _HoursBlock({required this.title, required this.hoursText});

  final String title;
  final String hoursText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: theme.colorScheme.tertiary),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          for (final line in hoursText.split('\n'))
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                line,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
