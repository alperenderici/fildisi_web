import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
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

    final backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        theme.colorScheme.surface,
        theme.colorScheme.primary.withValues(alpha: 0.06),
        theme.colorScheme.tertiary.withValues(alpha: 0.05),
      ],
      stops: const [0.0, 0.6, 1.0],
    );

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
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

                  // Instagram Section (+ Photos)
                  _InstagramSection(
                    handleText: l10n.instagramHandle,
                    buttonText: l10n.contactOpenInstagram,
                    onOpenInstagram: () =>
                        _openUrl(context, AppLinks.instagram),
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
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
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
      ),
    );
  }
}

class _InstagramSection extends StatelessWidget {
  const _InstagramSection({
    required this.handleText,
    required this.buttonText,
    required this.onOpenInstagram,
  });

  final String handleText;
  final String buttonText;
  final VoidCallback onOpenInstagram;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.08),
            theme.colorScheme.tertiary.withValues(alpha: 0.06),
            theme.colorScheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: _InstagramIntro(
                    handleText: handleText,
                    buttonText: buttonText,
                    onOpenInstagram: onOpenInstagram,
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(flex: 6, child: _InstagramPhotoGrid()),
              ],
            )
          : Column(
              children: [
                _InstagramIntro(
                  handleText: handleText,
                  buttonText: buttonText,
                  onOpenInstagram: onOpenInstagram,
                ),
                const SizedBox(height: 16),
                const _InstagramPhotoGrid(),
              ],
            ),
    );
  }
}

class _InstagramIntro extends StatelessWidget {
  const _InstagramIntro({
    required this.handleText,
    required this.buttonText,
    required this.onOpenInstagram,
  });

  final String handleText;
  final String buttonText;
  final VoidCallback onOpenInstagram;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.instagram,
          size: 44,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text(
          handleText,
          style: GoogleFonts.manrope(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onOpenInstagram,
          icon: const FaIcon(FontAwesomeIcons.instagram, size: 18),
          label: Text(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          ),
        ),
      ],
    );
  }
}

class _InstagramPhotoGrid extends StatefulWidget {
  const _InstagramPhotoGrid();

  @override
  State<_InstagramPhotoGrid> createState() => _InstagramPhotoGridState();
}

class _InstagramPhotoGridState extends State<_InstagramPhotoGrid> {
  late final Future<List<String>> _futureUrls = _loadUrls();

  Future<List<String>> _loadUrls() async {
    final feedUrl = AppLinks.instagramFeedJson.trim();
    if (feedUrl.isEmpty) return const <String>[];

    final uri = Uri.parse(feedUrl);
    final raw = await NetworkAssetBundle(uri).loadString('');
    final decoded = jsonDecode(raw);

    if (decoded is List) {
      return decoded.whereType<String>().toList(growable: false);
    }

    if (decoded is Map && decoded['images'] is List) {
      final list = decoded['images'] as List;
      return list.whereType<String>().toList(growable: false);
    }

    return const <String>[];
  }

  List<String> _fallbackAssets() {
    return const [
      'assets/images/bonbon/bonbon4.jpeg',
      'assets/images/bonbon/bonbon_box.jpeg',
      'assets/images/cikolata/cikolata.jpeg',
      'assets/images/makaron/makaron.jpeg',
      'assets/images/tatli/tatli1.jpeg',
      'assets/images/tatli/tatli2.jpeg',
    ];
  }

  void _openImage(BuildContext context, Widget child) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.9),
                    child: Center(child: InteractiveViewer(child: child)),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<String>>(
      future: _futureUrls,
      builder: (context, snapshot) {
        final urls = (snapshot.data ?? const <String>[]).take(9).toList();
        final useNetwork = urls.isNotEmpty;
        final items = useNetwork ? urls : _fallbackAssets();

        return DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth >= 520 ? 3 : 2;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];

                    final image = useNetwork
                        ? Image.network(
                            item,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Center(
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (_, __, ___) {
                              return Container(
                                color: theme.colorScheme.surfaceVariant,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            item,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          );

                    return InkWell(
                      onTap: () => _openImage(context, image),
                      borderRadius: BorderRadius.circular(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: image,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
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
            color: theme.colorScheme.onSurface,
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
