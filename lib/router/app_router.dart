import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/pages/atelier/atelier_home_page.dart';
import '../ui/pages/atelier/atelier_philosophy_page.dart';
import '../ui/pages/atelier/bonbon_collection_page.dart';
import '../ui/pages/atelier/gift_boxes_page.dart';
import '../ui/pages/atelier/macaron_collection_page.dart';
import '../ui/pages/atelier/order_page.dart';
import '../ui/shell/main_shell.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final path = state.uri.path;

      // Keep redirects simple and explicit.
      if (path == '/home') return '/';
      if (path == '/menu') return '/';
      if (path.endsWith('/index.html')) return '/';

      // Legacy prototype routes.
      if (path == '/galeri') return '/bonbonlar';
      if (path == '/hakkinda') return '/atolye-felsefesi';
      if (path == '/iletisim') return '/siparis-iletisim';

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(currentPath: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) =>
                _fadePage(key: state.pageKey, child: const AtelierHomePage()),
          ),
          GoRoute(
            path: '/bonbonlar',
            pageBuilder: (context, state) => _fadePage(
              key: state.pageKey,
              child: const BonbonCollectionPage(),
            ),
          ),
          GoRoute(
            path: '/makaronlar',
            pageBuilder: (context, state) => _fadePage(
              key: state.pageKey,
              child: const MacaronCollectionPage(),
            ),
          ),
          GoRoute(
            path: '/hediye-kutulari',
            pageBuilder: (context, state) =>
                _fadePage(key: state.pageKey, child: const GiftBoxesPage()),
          ),
          GoRoute(
            path: '/atolye-felsefesi',
            pageBuilder: (context, state) => _fadePage(
              key: state.pageKey,
              child: const AtelierPhilosophyPage(),
            ),
          ),
          GoRoute(
            path: '/siparis-iletisim',
            pageBuilder: (context, state) =>
                _fadePage(key: state.pageKey, child: const OrderPage()),
          ),
        ],
      ),

      // Catch-all: redirect unknown paths to home.
      GoRoute(path: '/:splat(.*)', redirect: (context, state) => '/'),
    ],
  );
}

CustomTransitionPage<void> _fadePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 240),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
