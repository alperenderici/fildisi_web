import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import 'package:fildisi_web/l10n/app_localizations.dart';

import '../controllers/locale_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/app_footer.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child, required this.currentPath});

  final Widget child;
  final String currentPath;

  List<_NavItem> _routes(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return <_NavItem>[
      _NavItem(label: l10n.navAbout, route: '/hakkinda'),
      _NavItem(label: l10n.navGallery, route: '/galeri'),
      _NavItem(label: l10n.navContact, route: '/iletisim'),
    ];
  }

  bool _isSelected(String route) {
    if (route == '/') return currentPath == '/';
    return currentPath == route;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeController = Get.find<LocaleController>();
    final themeController = Get.find<ThemeController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final logoHeight = isWide ? 80.0 : 64.0;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final isDark = theme.brightness == Brightness.dark;

        final appBarGradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  colorScheme.surface,
                  colorScheme.primary.withValues(alpha: 0.12),
                  colorScheme.tertiary.withValues(alpha: 0.15),
                  colorScheme.secondary.withValues(alpha: 0.08),
                  colorScheme.primary.withValues(alpha: 0.10),
                  colorScheme.surface.withValues(alpha: 0.95),
                ]
              : [
                  colorScheme.surface,
                  colorScheme.primary.withValues(alpha: 0.04),
                  colorScheme.tertiary.withValues(alpha: 0.06),
                  colorScheme.secondary.withValues(alpha: 0.03),
                  colorScheme.primary.withValues(alpha: 0.05),
                  colorScheme.surface.withValues(alpha: 0.98),
                ],
          stops: const [0.0, 0.25, 0.45, 0.65, 0.85, 1.0],
        );

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: DecoratedBox(
              decoration: BoxDecoration(gradient: appBarGradient),
              child: const SizedBox.expand(),
            ),
            titleSpacing: 24,
            toolbarHeight: isWide ? 90 : 70,
            title: InkWell(
              onTap: () => context.go('/'),
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
                child: Image.asset(
                  'assets/images/logo/fildisi_logo_transparent.png',
                  height: logoHeight,
                ),
              ),
            ),
            actions: isWide
                ? [
                    _NavButton(
                      label: l10n.navAbout,
                      isSelected: _isSelected('/hakkinda'),
                      onPressed: () => context.go('/hakkinda'),
                    ),
                    _NavButton(
                      label: l10n.navGallery,
                      isSelected: _isSelected('/galeri'),
                      onPressed: () => context.go('/galeri'),
                    ),
                    _NavButton(
                      label: l10n.navContact,
                      isSelected: _isSelected('/iletisim'),
                      onPressed: () => context.go('/iletisim'),
                    ),
                    const SizedBox(width: 16),
                    PopupMenuButton<Locale>(
                      tooltip: 'Language',
                      onSelected: localeController.setLocale,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: const Locale('tr'),
                          child: Text(l10n.languageTR),
                        ),
                        PopupMenuItem(
                          value: const Locale('en'),
                          child: Text(l10n.languageEN),
                        ),
                      ],
                      icon: const Icon(Icons.language),
                    ),
                    Obx(
                      () => IconButton(
                        tooltip: themeController.isDark
                            ? 'Light theme'
                            : 'Dark theme',
                        onPressed: themeController.toggle,
                        icon: Icon(
                          themeController.isDark
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ]
                : null,
          ),
          drawer: isWide
              ? null
              : Drawer(
                  child: SafeArea(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                          child: Text(
                            l10n.navMenu,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ..._routes(context).map(
                          (item) => ListTile(
                            selected: _isSelected(item.route),
                            title: Text(item.label),
                            onTap: () {
                              Navigator.of(context).pop();
                              context.go(item.route);
                            },
                          ),
                        ),
                        const Divider(height: 24),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: Text(l10n.languageTR),
                          onTap: () {
                            localeController.setTurkish();
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: Text(l10n.languageEN),
                          onTap: () {
                            localeController.setEnglish();
                            Navigator.of(context).pop();
                          },
                        ),
                        const Divider(height: 24),
                        Obx(
                          () => SwitchListTile(
                            value: themeController.isDark,
                            onChanged: (_) {
                              themeController.toggle();
                              Navigator.of(context).pop();
                            },
                            title: Text(
                              themeController.isDark
                                  ? 'Light theme'
                                  : 'Dark theme',
                            ),
                            secondary: Icon(
                              themeController.isDark
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          body: Column(
            children: [
              Expanded(
                child: SelectionArea(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: KeyedSubtree(
                      key: ValueKey<String>(currentPath),
                      child: child,
                    ),
                  ),
                ),
              ),
              const AppFooter(),
            ],
          ),
        );
      },
    );
  }
}

class _NavItem {
  const _NavItem({required this.label, required this.route});

  final String label;
  final String route;
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isSelected
              ? colorScheme.primary
              : colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isSelected ? 20 : 0,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
