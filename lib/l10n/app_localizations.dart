import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Fildişi Chocolate & Macaron Atelier'**
  String get appTitle;

  /// No description provided for @brandSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chocolate shop'**
  String get brandSubtitle;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get navGallery;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Fildişi Chocolate & Macaron Atelier'**
  String get homeHeadline;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'Handmade chocolate, bonbons, macarons, and boutique desserts in Kemalpaşa/İzmir.'**
  String get homeDescription;

  /// No description provided for @ctaGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get ctaGallery;

  /// No description provided for @ctaContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get ctaContact;

  /// No description provided for @ctaAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get ctaAbout;

  /// No description provided for @infoAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get infoAddressTitle;

  /// No description provided for @infoAddressBody.
  ///
  /// In en, this message translates to:
  /// **'Armutlu 85. Yıl Cumhuriyet, Armutlu Belediye Cd. No:45, 35737 Kemalpaşa/İzmir'**
  String get infoAddressBody;

  /// No description provided for @infoPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get infoPhoneTitle;

  /// No description provided for @infoPhoneBody.
  ///
  /// In en, this message translates to:
  /// **'+90 534 820 48 89'**
  String get infoPhoneBody;

  /// No description provided for @infoHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get infoHoursTitle;

  /// No description provided for @infoHoursShort.
  ///
  /// In en, this message translates to:
  /// **'Mon–Sat: 12:00–21:00\nSun: Closed'**
  String get infoHoursShort;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutTitle;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'Our founder, Uğur Eskici, after receiving professional pastry and chocolate training in the United States, returned to his birthplace to realize his dream of establishing Izmir\'s finest chocolate and macaron atelier.\n\nAt Fildişi Chocolate & Macaron Atelier, every product is prepared by our chef\'s own hands with great passion and precision. We carefully select fruits from local producers and offer them to you in their most natural form, without using any additives.\n\nIn our atelier where quality, naturalness, and taste meet, every chocolate and macaron is designed to leave an unforgettable mark on your palate.'**
  String get aboutBody;

  /// No description provided for @hoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hoursTitle;

  /// No description provided for @hoursLong.
  ///
  /// In en, this message translates to:
  /// **'Monday: 12:00–21:00\nTuesday: 12:00–21:00\nWednesday: 12:00–21:00\nThursday: 12:00–21:00\nFriday: 12:00–21:00\nSaturday: 12:00–21:00\nSunday: Closed'**
  String get hoursLong;

  /// No description provided for @socialTitle.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get socialTitle;

  /// No description provided for @instagramHandle.
  ///
  /// In en, this message translates to:
  /// **'@fildisiatolye'**
  String get instagramHandle;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryTitle;

  /// No description provided for @galleryCategoryBonbon.
  ///
  /// In en, this message translates to:
  /// **'Bonbons & Truffles'**
  String get galleryCategoryBonbon;

  /// No description provided for @galleryCategoryChocolate.
  ///
  /// In en, this message translates to:
  /// **'Chocolate'**
  String get galleryCategoryChocolate;

  /// No description provided for @galleryCategoryMacaron.
  ///
  /// In en, this message translates to:
  /// **'Macaron'**
  String get galleryCategoryMacaron;

  /// No description provided for @galleryCategoryDessert.
  ///
  /// In en, this message translates to:
  /// **'Desserts'**
  String get galleryCategoryDessert;

  /// No description provided for @galleryCategoryShop.
  ///
  /// In en, this message translates to:
  /// **'Shop/Counters'**
  String get galleryCategoryShop;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTitle;

  /// No description provided for @contactOpenOnMap.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get contactOpenOnMap;

  /// No description provided for @contactCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get contactCall;

  /// No description provided for @contactOpenInstagram.
  ///
  /// In en, this message translates to:
  /// **'Open Instagram'**
  String get contactOpenInstagram;

  /// No description provided for @snackLinkFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link.'**
  String get snackLinkFailed;

  /// No description provided for @snackCallFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not start the call.'**
  String get snackCallFailed;

  /// No description provided for @footerSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get footerSocial;

  /// No description provided for @footerBuiltBy.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Fildişi. Powered by AAD'**
  String get footerBuiltBy;

  /// No description provided for @footerTwitter.
  ///
  /// In en, this message translates to:
  /// **'Twitter'**
  String get footerTwitter;

  /// No description provided for @footerLinkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get footerLinkedIn;

  /// No description provided for @footerInstagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get footerInstagram;

  /// No description provided for @languageTR.
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get languageTR;

  /// No description provided for @languageEN.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEN;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
