import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'router/app_router.dart';
import 'ui/controllers/locale_controller.dart';
import 'ui/controllers/theme_controller.dart';
import 'package:fildisi_web/l10n/app_localizations.dart';

class FildisiApp extends StatelessWidget {
  const FildisiApp({super.key});

  ThemeData _buildTheme({required Brightness brightness}) {
    // Premium Chocolate Palette
    const primaryColor = Color(0xFF3E2723); // Deep Chocolate
    const secondaryColor = Color(0xFFD7CCC8); // Light Cocoa
    const accentColor = Color(0xFFC5A059); // Muted Gold
    const lightSurfaceColor = Color(0xFFFAFAFA); // Off-white
    const lightScaffoldColor = Color(0xFFFFFFFF); // Pure White

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
      // Preserve the current light palette exactly; let dark derive sensible
      // contrast values from the seed.
      primary: brightness == Brightness.light ? primaryColor : null,
      secondary: brightness == Brightness.light ? secondaryColor : null,
      tertiary: brightness == Brightness.light ? accentColor : null,
      surface: brightness == Brightness.light ? lightSurfaceColor : null,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);

    final scaffoldBackgroundColor = brightness == Brightness.light
        ? lightScaffoldColor
        : colorScheme.surface;

    final appBarBackgroundColor = brightness == Brightness.light
        ? lightScaffoldColor
        : colorScheme.surface;

    final textTheme = GoogleFonts.manropeTextTheme(base.textTheme);
    final headlineColor = brightness == Brightness.light
        ? primaryColor
        : colorScheme.onSurface;

    return base.copyWith(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      textTheme: textTheme.copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.displayLarge,
          fontWeight: FontWeight.w700,
          color: headlineColor,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.displayMedium,
          fontWeight: FontWeight.w700,
          color: headlineColor,
        ),
        headlineLarge: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.headlineLarge,
          fontWeight: FontWeight.w700,
          color: headlineColor,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.headlineMedium,
          fontWeight: FontWeight.w700,
          color: headlineColor,
        ),
        titleLarge: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.titleLarge,
          fontWeight: FontWeight.w600,
          color: headlineColor,
        ),
        bodyLarge: GoogleFonts.manrope(
          textStyle: base.textTheme.bodyLarge,
          color: colorScheme.onSurface,
          height: 1.6,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.manrope(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.manrope(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter();
    final localeController = Get.put(LocaleController());

    final themeController = Get.put(ThemeController());

    final theme = _buildTheme(brightness: Brightness.light);
    final darkTheme = _buildTheme(brightness: Brightness.dark);

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
        darkTheme: darkTheme,
        themeMode: themeController.themeMode.value,
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
