import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'router/app_router.dart';
import 'ui/controllers/locale_controller.dart';
import 'package:fildisi_web/l10n/app_localizations.dart';
import 'ui/atelier/widgets/atelier_tokens.dart';

class FildisiApp extends StatelessWidget {
  const FildisiApp({super.key});

  ThemeData _buildAtelierTheme() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AtelierTokens.cocoa,
      onPrimary: AtelierTokens.ivory,
      secondary: AtelierTokens.paper,
      onSecondary: AtelierTokens.cocoa,
      tertiary: AtelierTokens.gold,
      onTertiary: AtelierTokens.cocoa,
      error: Color(0xFFB3261E),
      onError: Colors.white,
      surface: AtelierTokens.ivory,
      onSurface: AtelierTokens.cocoa,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);

    final sans = GoogleFonts.manropeTextTheme(base.textTheme);
    final serif = GoogleFonts.playfairDisplayTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: AtelierTokens.ivory,
      dividerColor: AtelierTokens.stone,
      appBarTheme: const AppBarTheme(
        backgroundColor: AtelierTokens.ivory,
        foregroundColor: AtelierTokens.cocoa,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      textTheme: sans.copyWith(
        displayLarge: serif.displayLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AtelierTokens.cocoa,
          letterSpacing: -0.4,
        ),
        displayMedium: serif.displayMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AtelierTokens.cocoa,
          letterSpacing: -0.3,
        ),
        headlineLarge: serif.headlineLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AtelierTokens.cocoa,
        ),
        headlineMedium: serif.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AtelierTokens.cocoa,
        ),
        titleLarge: serif.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AtelierTokens.cocoa,
        ),
        bodyLarge: sans.bodyLarge?.copyWith(
          color: AtelierTokens.cocoa,
          height: 1.7,
        ),
        bodyMedium: sans.bodyMedium?.copyWith(
          color: AtelierTokens.cocoaMuted,
          height: 1.6,
        ),
        labelLarge: sans.labelLarge?.copyWith(
          color: AtelierTokens.cocoa,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w600,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AtelierTokens.cocoa,
          foregroundColor: AtelierTokens.ivory,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AtelierTokens.cocoa,
          side: const BorderSide(color: AtelierTokens.stone),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AtelierTokens.cocoa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter();
    final localeController = Get.put(LocaleController());

    final theme = _buildAtelierTheme();

    return Obx(
      () => MaterialApp.router(
        title: 'Fildişi Çikolata & Makaron Atölyesi',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          },
        ),
        routerConfig: router,
        theme: theme,
        locale: localeController.locale.value,
        supportedLocales: const [Locale('tr'), Locale('en')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
