import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/gallery_controller.dart';
import 'package:fildisi_web/l10n/app_localizations.dart';
import '../widgets/image_caption.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  List<_GalleryCategory> _categories(AppLocalizations l10n) =>
      <_GalleryCategory>[
        _GalleryCategory(l10n.galleryCategoryBonbon, [
          'assets/images/bonbon/bonbon4.jpeg',
          'assets/images/bonbon/bonbon6.jpeg',
          'assets/images/bonbon/bonbon_ahududu.jpeg',
          'assets/images/bonbon/bonbon_box.jpeg',
          'assets/images/bonbon/bonbon_carkifelek.jpeg',
          'assets/images/bonbon/bonbon_espresso.jpeg',
          'assets/images/bonbon/bonbon_limon.jpeg',
          'assets/images/bonbon/bonbon_satsuma.jpeg',
          'assets/images/bonbon/bonbon_satsuma2.jpeg',
          'assets/images/bonbon/bonbon_sutlu.jpeg',
          'assets/images/bonbon/truf.jpeg',
        ]),
        _GalleryCategory(l10n.galleryCategoryChocolate, [
          'assets/images/cikolata/cikolata.jpeg',
          'assets/images/cikolata/findikli_cikolata.jpeg',
          'assets/images/cikolata/fistikli_cikolata.jpeg',
          'assets/images/cikolata/kalip_cikolata.jpeg',
        ]),
        _GalleryCategory(l10n.galleryCategoryMacaron, [
          'assets/images/makaron/makaron.jpeg',
        ]),
        _GalleryCategory(l10n.galleryCategoryDessert, [
          'assets/images/tatli/tatli1.jpeg',
          'assets/images/tatli/tatli2.jpeg',
        ]),
        _GalleryCategory(l10n.galleryCategoryShop, [
          'assets/images/tezgah.jpeg',
          'assets/images/tezgah0.jpeg',
          'assets/images/tezgah2.jpeg',
        ]),
      ];

  Future<void> _openImage(BuildContext context, String assetPath) async {
    final caption = captionFromAssetPath(assetPath);
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'image',
      barrierColor: Colors.black.withValues(alpha: 0.9),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Hero(
                      tag: assetPath,
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: InteractiveViewer(
                                  minScale: 0.9,
                                  maxScale: 4,
                                  child: Image.asset(
                                    assetPath,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            if (caption.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Text(
                                caption,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = _categories(l10n);
    final controller = Get.put(GalleryController());
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.galleryTitle,
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Obx(() {
                  final selected = controller.selectedCategoryIndex.value;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (var i = 0; i < categories.length; i++)
                        ChoiceChip(
                          label: Text(categories[i].title),
                          selected: i == selected,
                          onSelected: (_) => controller.selectCategory(i),
                          labelStyle: TextStyle(
                            color: i == selected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          selectedColor: theme.colorScheme.primary,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                            side: BorderSide(
                              color: theme.colorScheme.primary,
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                    ],
                  );
                }),
                const SizedBox(height: 32),
                Obx(() {
                  final selected = controller.selectedCategoryIndex.value;
                  final images = categories[selected].images;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final crossAxisCount = width >= 1000
                          ? 4
                          : width >= 700
                          ? 3
                          : 2;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          final path = images[index];
                          final caption = captionFromAssetPath(path);
                          return InkWell(
                            onTap: () => _openImage(context, path),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Hero(
                                      tag: path,
                                      child: Image.asset(
                                        path,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withValues(alpha: 0.7),
                                          ],
                                          stops: const [0.6, 1.0],
                                        ),
                                      ),
                                    ),
                                    if (caption.isNotEmpty)
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            caption,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.playfairDisplay(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GalleryCategory {
  const _GalleryCategory(this.title, this.images);

  final String title;
  final List<String> images;
}
