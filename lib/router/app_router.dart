import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/pages/about_page.dart';
import '../ui/pages/contact_page.dart';
import '../ui/pages/gallery_page.dart';
import '../ui/pages/home_page.dart';
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
                _fadePage(key: state.pageKey, child: const HomePage()),
          ),
          GoRoute(
            path: '/hakkinda',
            pageBuilder: (context, state) =>
                _fadePage(key: state.pageKey, child: const AboutPage()),
          ),
          GoRoute(
            path: '/galeri',
            pageBuilder: (context, state) =>
                _fadePage(key: state.pageKey, child: const GalleryPage()),
          ),
          GoRoute(
            path: '/iletisim',
            pageBuilder: (context, state) =>
                _fadePage(key: state.pageKey, child: const ContactPage()),
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
    transitionDuration: const Duration(milliseconds: 150),
    reverseTransitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
