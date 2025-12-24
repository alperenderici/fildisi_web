import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import 'package:fildisi_web/l10n/app_localizations.dart';

import '../controllers/locale_controller.dart';
import '../atelier/widgets/atelier_tokens.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child, required this.currentPath});

  final Widget child;
  final String currentPath;

  List<_NavItem> _routes(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return <_NavItem>[
      _NavItem(label: l10n.navBonbons, route: '/bonbonlar'),
      _NavItem(label: l10n.navMacarons, route: '/makaronlar'),
      _NavItem(label: l10n.navGiftBoxes, route: '/hediye-kutulari'),
      _NavItem(label: l10n.navPhilosophy, route: '/atolye-felsefesi'),
      _NavItem(label: l10n.navOrder, route: '/siparis-iletisim'),
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final logoHeight = isWide ? 54.0 : 44.0;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 24,
            toolbarHeight: isWide ? 84 : 68,
            scrolledUnderElevation: 0,
            backgroundColor: AtelierTokens.ivory,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: AtelierTokens.stone),
            ),
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
                    ..._routes(context).map(
                      (item) => _NavButton(
                        label: item.label,
                        isSelected: _isSelected(item.route),
                        onPressed: () => context.go(item.route),
                      ),
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
                      ],
                    ),
                  ),
                ),
          body: SelectionArea(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AtelierTokens.cocoa,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
                letterSpacing: 1.6,
                color:
                    isSelected ? AtelierTokens.cocoa : AtelierTokens.cocoaMuted,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 4,
              width: 4,
              decoration: BoxDecoration(
                color: isSelected ? AtelierTokens.gold : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
