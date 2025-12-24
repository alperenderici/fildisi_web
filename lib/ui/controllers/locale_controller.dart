import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  final locale = const Locale('tr').obs;

  void setTurkish() => locale.value = const Locale('tr');

  void setEnglish() => locale.value = const Locale('en');

  void setLocale(Locale next) => locale.value = next;
}
