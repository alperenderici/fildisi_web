import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fildisi_web/l10n/app_localizations.dart';
import '../widgets/hero_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            color: theme.colorScheme.surface,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 16,
              vertical: isDesktop ? 32 : 16,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 5, child: _HeroContent(l10n: l10n)),
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 7,
                            child: HeroCarousel(
                              imageAssets: const [
                                'assets/images/tezgah.jpeg',
                                'assets/images/tezgah0.jpeg',
                                'assets/images/tezgah2.jpeg',
                              ],
                              height: 500,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          HeroCarousel(
                            imageAssets: const [
                              'assets/images/tezgah.jpeg',
                              'assets/images/tezgah0.jpeg',
                              'assets/images/tezgah2.jpeg',
                            ],
                            height: 360,
                          ),
                          const SizedBox(height: 32),
                          _HeroContent(l10n: l10n),
                        ],
                      ),
              ),
            ),
          ),

          // Featured Products Section
          Container(
            color: theme.colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    Text(
                      l10n.ctaGallery, // Using "Gallery" as title for now, or "Our Creations"
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.brandSubtitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    _FeaturedGrid(l10n: l10n),
                  ],
                ),
              ),
            ),
          ),

          // Info Section
          Container(
            color: theme.colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: _InfoCards(l10n: l10n),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.homeHeadline,
          style: theme.textTheme.displayMedium?.copyWith(
            height: 1.1,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.homeDescription,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/galeri'),
              child: Text(l10n.ctaGallery),
            ),
            OutlinedButton(
              onPressed: () => context.go('/iletisim'),
              child: Text(l10n.ctaContact),
            ),
          ],
        ),
      ],
    );
  }
}

class _FeaturedGrid extends StatelessWidget {
  const _FeaturedGrid({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    // Using a mix of available assets
    final items = [
      {
        'image': 'assets/images/cikolata/cikolata.jpeg',
        'title': 'Artisan Chocolates',
      },
      {
        'image': 'assets/images/makaron/makaron.jpeg',
        'title': 'French Macarons',
      },
      {'image': 'assets/images/tatli/tatli1.jpeg', 'title': 'Special Desserts'},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth > 900
            ? 3
            : (constraints.maxWidth > 600 ? 2 : 1);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            childAspectRatio: 0.85,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _ProductCard(
              image: items[index]['image']!,
              title: items[index]['title']!,
            );
          },
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 4, child: Image.asset(image, fit: BoxFit.cover)),
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCards extends StatelessWidget {
  const _InfoCards({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final cards = <Widget>[
          _InfoCard(
            icon: Icons.location_on_outlined,
            title: l10n.infoAddressTitle,
            body: l10n.infoAddressBody,
          ),
          _InfoCard(
            icon: Icons.phone_outlined,
            title: l10n.infoPhoneTitle,
            body: l10n.infoPhoneBody,
          ),
          _InfoCard(
            icon: Icons.access_time,
            title: l10n.infoHoursTitle,
            body: l10n.infoHoursShort,
          ),
        ];

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final c in cards)
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(12), child: c),
                ),
            ],
          );
        }

        return Column(
          children: [
            for (final c in cards)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: c,
              ),
          ],
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 18,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
