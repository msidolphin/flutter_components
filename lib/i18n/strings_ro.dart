part of 'i18n.dart';

/// Romanian (RO)
class _StringsRo extends _StringsI18n {
  const _StringsRo();

  @override
  String getCancelText() {
    return "Anulare";
  }

  @override
  String getDoneText() {
    return "Ok";
  }

  @override
  List<String> getMonths() {
    return [
      "Ianuarie",
      "Februarie",
      "Martie",
      "Aprilie",
      "Mai",
      "Iunie",
      "Iulie",
      "August",
      "Septembrie",
      "Octombrie",
      "Noiembrie",
      "Decembrie"
    ];
  }

  @override
  List<String> getWeeksFull() {
    return [
      "Luni",
      "Marti",
      "Miercuri",
      "Joi",
      "Vineri",
      "Sambata",
      "Duminica"
    ];
  }

  @override
  List<String> getWeeksShort() {
    return null;
  }

  @override
  String getToastLoadingText() {
    return 'Se încarcă';
  }

  @override
  String getCatalogPickerChoseText() {
    return "chose";
  }
}
