import 'dart:math';

part 'strings_en_us.dart';
part 'strings_zh_cn.dart';
part 'strings_pt_br.dart';
part 'strings_es.dart';
part 'strings_ro.dart';
part 'strings_bn.dart';
part 'strings_ar.dart';
part 'strings_jp.dart';
part 'strings_ru.dart';
part 'strings_de.dart';
part 'strings_ko.dart';
part 'strings_it.dart';
part 'strings_hu.dart';

abstract class _StringsI18n {
  const _StringsI18n();

  /// Get the done widget text
  String getDoneText();

  /// Get the cancel widget text
  String getCancelText();

  /// Get the name of month
  List<String> getMonths();

  /// Get the full name of week
  List<String> getWeeksFull();

  /// Get the short name of week
  List<String> getWeeksShort();

  /// Get the toast loading text
  String getToastLoadingText();

  String getCatalogPickerChoseText();
}

enum FlatLocale {
  /// English (EN) United States
  en_us,

  /// Chinese (ZH) Simplified
  zh_cn,

  /// Portuguese (PT) Brazil
  pt_br,

  /// Spanish (ES)
  es,

  /// Romanian (RO)
  ro,

  /// Bengali (BN)
  bn,

  /// Arabic (ar)
  ar,

  /// Japanese (JP)
  jp,

  /// Russian (RU)
  ru,

  /// German (DE)
  de,

  /// Korea (KO)
  ko,

  /// Italian (IT)
  it,

  /// Hungarian (HU)
  hu,
}

/// Default value of date locale
const FlatLocale DATETIME_PICKER_LOCALE_DEFAULT =
    FlatLocale.en_us;

const Map<FlatLocale, _StringsI18n> i18nMap = {
  FlatLocale.en_us: const _StringsEnUs(),
  FlatLocale.zh_cn: const _StringsZhCn(),
  FlatLocale.pt_br: const _StringsPtBr(),
  FlatLocale.es: const _StringsEs(),
  FlatLocale.ro: const _StringsRo(),
  FlatLocale.bn: const _StringsBn(),
  FlatLocale.ar: const _StringsAr(),
  FlatLocale.jp: const _StringsJp(),
  FlatLocale.ru: const _StringsRu(),
  FlatLocale.de: const _StringsDe(),
  FlatLocale.ko: const _StringsKo(),
  FlatLocale.it: const _StringsIt(),
  FlatLocale.hu: const _StringsHu(),
};

class I18n {
  /// Get done button text
  static String getLocaleDone(FlatLocale locale) {
    _StringsI18n i18n = i18nMap[locale] ??
        i18nMap[DATETIME_PICKER_LOCALE_DEFAULT];
    return i18n.getDoneText() ??
        i18nMap[DATETIME_PICKER_LOCALE_DEFAULT].getDoneText();
  }

  /// Get cancel button text
  static String getLocaleCancel(FlatLocale locale) {
    _StringsI18n i18n = i18nMap[locale] ??
        i18nMap[DATETIME_PICKER_LOCALE_DEFAULT];
    return i18n.getCancelText() ??
        i18nMap[DATETIME_PICKER_LOCALE_DEFAULT].getCancelText();
  }

  /// Get locale month array
  static List<String> getLocaleMonths(FlatLocale locale) {
    _StringsI18n i18n = i18nMap[locale] ??
        i18nMap[DATETIME_PICKER_LOCALE_DEFAULT];
    List<String> months = i18n.getMonths();
    if (months != null && months.isNotEmpty) {
      return months;
    }
    return i18nMap[DATETIME_PICKER_LOCALE_DEFAULT].getMonths();
  }

  /// Get locale week array
  static List<String> getLocaleWeeks(FlatLocale locale,
      [bool isFull = true]) {
    _StringsI18n i18n = i18nMap[locale] ??
        i18nMap[DATETIME_PICKER_LOCALE_DEFAULT];
    if (isFull) {
      List<String> weeks = i18n.getWeeksFull();
      if (weeks != null && weeks.isNotEmpty) {
        return weeks;
      }
      return i18nMap[DATETIME_PICKER_LOCALE_DEFAULT].getWeeksFull();
    }

    List<String> weeks = i18n.getWeeksShort();
    if (weeks != null && weeks.isNotEmpty) {
      return weeks;
    }

    List<String> fullWeeks = i18n.getWeeksFull();
    if (fullWeeks != null && fullWeeks.isNotEmpty) {
      return fullWeeks
          .map((item) => item.substring(0, min(3, item.length)))
          .toList();
    }
    return i18nMap[DATETIME_PICKER_LOCALE_DEFAULT].getWeeksShort();
  }

  static String getToastLoadingText (FlatLocale locale) {
    return i18nMap[locale].getToastLoadingText();
  }

  static String getCatalogPickerChoseText(FlatLocale locale) {
    return i18nMap[locale].getCatalogPickerChoseText();
  }

}
