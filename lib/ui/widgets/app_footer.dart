import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_links.dart';
import 'package:fildisi_web/l10n/app_localizations.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.snackLinkFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: l10n.footerTwitter,
                    onPressed: () => _openUrl(context, AppLinks.twitter),
                    icon: const FaIcon(FontAwesomeIcons.xTwitter, size: 18),
                  ),
                  IconButton(
                    tooltip: l10n.footerLinkedIn,
                    onPressed: () => _openUrl(context, AppLinks.linkedIn),
                    icon: const FaIcon(FontAwesomeIcons.linkedinIn, size: 18),
                  ),
                  IconButton(
                    tooltip: l10n.footerInstagram,
                    onPressed: () => _openUrl(context, AppLinks.instagram),
                    icon: const FaIcon(FontAwesomeIcons.instagram, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              InkWell(
                onTap: () => _openUrl(context, AppLinks.developer),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    l10n.footerBuiltBy,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
