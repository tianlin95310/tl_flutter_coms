import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'tl-localizations.dart';

class TlLocalizationsDelegate extends LocalizationsDelegate<I18n> {

  @override
  bool isSupported(Locale locale) {
    return ["en", "zh"].contains(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate<I18n> old) {
    return false;
  }

  @override
  Future<I18n> load(Locale locale) {
    return SynchronousFuture(I18n(locale));
  }

  static const TlLocalizationsDelegate delegate = TlLocalizationsDelegate();

  const TlLocalizationsDelegate();
}