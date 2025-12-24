import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fildisi_web/l10n/app_localizations.dart';
import '../../app_links.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  l10n.aboutTitle,
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),

                // Content Section (Story + Image)
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _StoryText(l10n: l10n)),
                      const SizedBox(width: 64),
                      Expanded(flex: 4, child: _AboutImage()),
                    ],
                  )
                else
                  Column(
                    children: [
                      _AboutImage(),
                      const SizedBox(height: 32),
                      _StoryText(l10n: l10n),
                    ],
                  ),

                const SizedBox(height: 64),

                // Instagram Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF833AB4).withValues(alpha: 0.1),
                        const Color(0xFFFD1D1D).withValues(alpha: 0.1),
                        const Color(0xFFFCAF45).withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 48,
                        color: Color(0xFFC13584),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.instagramHandle,
                        style: GoogleFonts.manrope(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => _openUrl(context, AppLinks.instagram),
                        icon: const FaIcon(
                          FontAwesomeIcons.instagram,
                          size: 18,
                        ),
                        label: Text(l10n.contactOpenInstagram),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC13584),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 64),

                // Hours Section
                _SectionTitle(l10n.hoursTitle),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final line in l10n.hoursLong.split('\n'))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: theme.colorScheme.tertiary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                line,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryText extends StatelessWidget {
  const _StoryText({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.aboutBody,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            height: 1.8,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _AboutImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/tezgah.jpeg', // Using shop image as placeholder for now
        fit: BoxFit.cover,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
