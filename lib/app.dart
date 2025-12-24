import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'router/app_router.dart';
import 'ui/controllers/locale_controller.dart';
import 'package:fildisi_web/l10n/app_localizations.dart';

class FildisiApp extends StatelessWidget {
  const FildisiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter();
    final localeController = Get.put(LocaleController());

    // Premium Chocolate Palette
    const primaryColor = Color(0xFF3E2723); // Deep Chocolate
    const secondaryColor = Color(0xFFD7CCC8); // Light Cocoa
    const accentColor = Color(0xFFC5A059); // Muted Gold
    const surfaceColor = Color(0xFFFAFAFA); // Off-white
    const scaffoldColor = Color(0xFFFFFFFF); // Pure White

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        brightness: Brightness.light,
      ),
    );

    final theme = base.copyWith(
      scaffoldBackgroundColor: scaffoldColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: scaffoldColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.displayLarge,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.displayMedium,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
        headlineLarge: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.headlineLarge,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.headlineMedium,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
        titleLarge: GoogleFonts.playfairDisplay(
          textStyle: base.textTheme.titleLarge,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        bodyLarge: GoogleFonts.manrope(
          textStyle: base.textTheme.bodyLarge,
          color: Colors.black87,
          height: 1.6,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
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
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
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
        color: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );

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
