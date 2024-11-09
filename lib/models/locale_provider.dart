import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('zh'); // Ngôn ngữ mặc định là tiếng trung

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!['en', 'vn', 'zh'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
