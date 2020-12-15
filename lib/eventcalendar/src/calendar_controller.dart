//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

part of event_calendar;

const double _dxMax = 1.2;
const double _dxMin = -1.2;

typedef void _SelectedDayCallback(DateTime day);

/// Controller required for `TableCalendar`.
///
/// Should be created in `initState()`, and then disposed in `dispose()`:
/// ```dart
/// @override
/// void initState() {
///   super.initState();
///   _calendarController = CalendarController();
/// }
///
/// @override
/// void dispose() {
///   _calendarController.dispose();
///   super.dispose();
/// }
/// ```
class CalendarController {
  /// Currently focused day (used to determine which year/month should be visible).
  DateTime get focusedDay => _focusedDay;

  /// Currently selected day.
  DateTime get selectedDay => _selectedDay;

  /// Currently visible calendar format.
  CalendarFormat get calendarFormat => _calendarFormat.value;

  /// List of currently visible days.
  List<DateTime> get visibleDays =>
      calendarFormat == CalendarFormat.month && !_includeInvisibleDays
          ? _visibleDays.value.where((day) => !_isExtraDay(day, _focusedDay)).toList()
          : _visibleDays.value;

  /// `Map` of currently visible events.
  Map<DateTime, List> get visibleEvents {
    if (_events == null) {
      return {};
    }

    return Map.fromEntries(
      _events.entries.where((entry) {
        for (final day in visibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }
        for (final day in previousVisibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }
        for (final day in nextVisibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }

        return false;
      }),
    );
  }

  /// `Map` of currently visible holidays.
  Map<DateTime, List> get visibleHolidays {
    if (_holidays == null) {
      return {};
    }

    return Map.fromEntries(
      _holidays.entries.where((entry) {
        for (final day in visibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }
        for (final day in previousVisibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }
        for (final day in nextVisibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }
        return false;
      }),
    );
  }

  Map<DateTime, List> _events;
  Map<DateTime, List> _holidays;
  DateTime _focusedDay;
  DateTime _previousFocusedDay;
  DateTime _nextFocusedDay;
  DateTime _selectedDay;
  StartingDayOfWeek _startingDayOfWeek;
  ValueNotifier<CalendarFormat> _calendarFormat;
  ValueNotifier<List<DateTime>> _visibleDays;
  List<DateTime> _previousVisibleDays;
  List<DateTime> _nextVisibleDays;
  Map<CalendarFormat, String> _availableCalendarFormats;
  DateTime _previousFirstDay;
  DateTime _previousLastDay;
  int _pageId;
  double _dx;
  bool _useNextCalendarFormat;
  bool _includeInvisibleDays;
  _SelectedDayCallback _selectedDayCallback;

  void _init({
    @required Map<DateTime, List> events,
    @required Map<DateTime, List> holidays,
    @required DateTime initialDay,
    @required CalendarFormat initialFormat,
    @required Map<CalendarFormat, String> availableCalendarFormats,
    @required bool useNextCalendarFormat,
    @required StartingDayOfWeek startingDayOfWeek,
    @required _SelectedDayCallback selectedDayCallback,
    @required OnVisibleDaysChanged onVisibleDaysChanged,
    @required OnCalendarCreated onCalendarCreated,
    @required bool includeInvisibleDays,
  }) {
    _events = events;
    _holidays = holidays;
    _availableCalendarFormats = availableCalendarFormats;
    _startingDayOfWeek = startingDayOfWeek;
    _useNextCalendarFormat = useNextCalendarFormat;
    _selectedDayCallback = selectedDayCallback;
    _includeInvisibleDays = includeInvisibleDays;

    _pageId = 0;
    _dx = 0;

    final now = DateTime.now();
    _focusedDay = initialDay ?? _normalizeDate(now);
    _selectedDay = _focusedDay;
    _calendarFormat = ValueNotifier(initialFormat);
    _visibleDays = ValueNotifier(_getVisibleDays());
    _previousFirstDay = _visibleDays.value.first;
    _previousLastDay = _visibleDays.value.last;

    _calendarFormat.addListener(() {
      if (_calendarFormat.value == CalendarFormat.month && focusedDay.year == _selectedDay.year && focusedDay.month == _selectedDay.month) {
        _focusedDay = _selectedDay;
      }
      _visibleDays.value = _getVisibleDays();
    });

    if (onVisibleDaysChanged != null) {
      _visibleDays.addListener(() {
        if (!_isSameDay(_visibleDays.value.first, _previousFirstDay) ||
            !_isSameDay(_visibleDays.value.last, _previousLastDay)) {
          _previousFirstDay = _visibleDays.value.first;
          _previousLastDay = _visibleDays.value.last;
          onVisibleDaysChanged(
            _getFirstDay(includeInvisible: _includeInvisibleDays),
            _getLastDay(includeInvisible: _includeInvisibleDays),
            _calendarFormat.value,
          );
        }
      });
    }

    if (onCalendarCreated != null) {
      onCalendarCreated(
        _getFirstDay(includeInvisible: _includeInvisibleDays),
        _getLastDay(includeInvisible: _includeInvisibleDays),
        _calendarFormat.value,
      );
    }
  }

  /// Disposes the controller.
  /// ```dart
  /// @override
  /// void dispose() {
  ///   _calendarController.dispose();
  ///   super.dispose();
  /// }
  /// ```
  void dispose() {
    _calendarFormat?.dispose();
    _visibleDays?.dispose();
  }

  /// Toggles calendar format. Same as using `FormatButton`.
  void toggleCalendarFormat() {
    _calendarFormat.value = _nextFormat();
  }

  /// Sets calendar format by emulating swipe.
  void swipeCalendarFormat({@required bool isSwipeUp}) {
    assert(isSwipeUp != null);

    final formats = _availableCalendarFormats.keys.toList();
    int id = formats.indexOf(_calendarFormat.value);

    // Order of CalendarFormats must be from biggest to smallest,
    // eg.: [month, twoWeeks, week]
    if (isSwipeUp) {
      id = _clamp(0, formats.length - 1, id + 1);
    } else {
      id = _clamp(0, formats.length - 1, id - 1);
    }
    _calendarFormat.value = formats[id];
  }

  /// Sets calendar format to a given `value`.
  bool setCalendarFormat(CalendarFormat value) {
    if (_calendarFormat.value == value) return false;
    _calendarFormat.value = value;
    return true;
  }

  /// Sets selected day to a given `value`.
  /// Use `runCallback: true` if this should trigger `OnDaySelected` callback.
  void setSelectedDay(
      DateTime value, {
        bool isProgrammatic = true,
        bool animate = true,
        bool runCallback = false,
      }) {
    final normalizedDate = _normalizeDate(value);

    if (animate) {
      if (normalizedDate.isBefore(_getFirstDay(includeInvisible: false))) {
        _decrementPage();
      } else if (normalizedDate.isAfter(_getLastDay(includeInvisible: false))) {
        _incrementPage();
      }
    }

    _selectedDay = normalizedDate;
    _focusedDay = normalizedDate;
    _updateVisibleDays(isProgrammatic);

    if (isProgrammatic && runCallback && _selectedDayCallback != null) {
      _selectedDayCallback(normalizedDate);
    }
  }

  /// Sets displayed month/year without changing the currently selected day.
  void setFocusedDay(DateTime value) {
    _focusedDay = _normalizeDate(value);
    _updateVisibleDays(true);
  }

  void _updateVisibleDays(bool isProgrammatic) {
    if (calendarFormat != CalendarFormat.twoWeeks || isProgrammatic) {
      _visibleDays.value = _getVisibleDays();
    }
  }

  CalendarFormat _nextFormat() {
    final formats = _availableCalendarFormats.keys.toList();
    int id = formats.indexOf(_calendarFormat.value);
    id = (id + 1) % formats.length;

    return formats[id];
  }

  String _getFormatButtonText() => _useNextCalendarFormat
      ? _availableCalendarFormats[_nextFormat()]
      : _availableCalendarFormats[_calendarFormat.value];

  void _selectPrevious() {
    if (calendarFormat == CalendarFormat.month) {
      _selectPreviousMonth();
      if (focusedDay.year == _selectedDay.year && focusedDay.month == _selectedDay.month) {
        _focusedDay = _selectedDay;
      }
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      _selectPreviousTwoWeeks();
    } else {
      _selectPreviousWeek();
    }

    _visibleDays.value = _getVisibleDays();
    _decrementPage();
  }

  void _selectNext() {
    if (calendarFormat == CalendarFormat.month) {
      _selectNextMonth();
      if (focusedDay.year == _selectedDay.year && focusedDay.month == _selectedDay.month) {
        _focusedDay = _selectedDay;
      }
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      _selectNextTwoWeeks();
    } else {
      _selectNextWeek();
    }
    _visibleDays.value = _getVisibleDays();
    _incrementPage();
  }

  /// Displays the previous Calendar page.
  void previousPage() {
    if (calendarFormat == CalendarFormat.month) {
      _selectPreviousMonth();
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      _selectPreviousTwoWeeks();
    } else {
      _selectPreviousWeek();
    }

    _visibleDays.value = _getVisibleDays();
    _decrementPage();
  }

  /// Displays the next Calendar page.
  void nextPage() {
    if (calendarFormat == CalendarFormat.month) {
      _selectNextMonth();
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      _selectNextTwoWeeks();
    } else {
      _selectNextWeek();
    }

    _visibleDays.value = _getVisibleDays();
    _incrementPage();
  }

  void _getNextVisibleDays () {
    DateTime focusedDay;
    if (calendarFormat == CalendarFormat.month) {
      focusedDay = nextMonth(_focusedDay);
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      if (!_visibleDays.value.skip(7).contains(_focusedDay)) {
        // not in bottom row [eg: in top row OR not visible]
        focusedDay = _nextWeek(_focusedDay);
      }
    } else {
      focusedDay = _nextWeek(_focusedDay);
    }
    this._nextFocusedDay = focusedDay;
    _nextVisibleDays = getVisibleDays(focusedDay);
  }

  void _getPreviousVisibleDays () {
    DateTime focusedDay;
    if (calendarFormat == CalendarFormat.month) {
      focusedDay = previousMonth(_focusedDay);
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      if (!_visibleDays.value.skip(7).contains(_focusedDay)) {
        // not in bottom row [eg: in top row OR not visible]
        focusedDay = _previousWeek(_focusedDay);
      }
    } else {
      focusedDay = _previousWeek(_focusedDay);
    }
    this._previousFocusedDay = focusedDay;
    _previousVisibleDays = getVisibleDays(focusedDay);
  }

  void _selectPreviousMonth() {
    _focusedDay = previousMonth(_focusedDay);
  }

  void _selectNextMonth() {
    _focusedDay = nextMonth(_focusedDay);
  }

  void _selectPreviousTwoWeeks() {
    if (_visibleDays.value.take(7).contains(_focusedDay)) {
      // in top row
      _focusedDay = _previousWeek(_focusedDay);
    } else {
      // in bottom row OR not visible
      _focusedDay =
          _previousWeek(_focusedDay.subtract(const Duration(days: 7)));
    }
  }

  void _selectNextTwoWeeks() {
    if (!_visibleDays.value.skip(7).contains(_focusedDay)) {
      // not in bottom row [eg: in top row OR not visible]
      _focusedDay = _nextWeek(_focusedDay);
    }
  }

  void _selectPreviousWeek() {
    _focusedDay = _previousWeek(_focusedDay);
  }

  void _selectNextWeek() {
    _focusedDay = _nextWeek(_focusedDay);
  }

  DateTime _getFirstDay({@required bool includeInvisible}) {
    if (_calendarFormat.value == CalendarFormat.month && !includeInvisible) {
      return _firstDayOfMonth(_focusedDay);
    } else {
      return _visibleDays.value.first;
    }
  }

  DateTime _getLastDay({@required bool includeInvisible}) {
    if (_calendarFormat.value == CalendarFormat.month && !includeInvisible) {
      return _lastDayOfMonth(_focusedDay);
    } else {
      return _visibleDays.value.last;
    }
  }

  List<DateTime> _getVisibleDays() {
    _getNextVisibleDays();
    _getPreviousVisibleDays();
    if (calendarFormat == CalendarFormat.month) {
      return _daysInMonth(_focusedDay);
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      return _daysInWeek(_focusedDay)
        ..addAll(_daysInWeek(
          _focusedDay.add(const Duration(days: 7)),
        ));
    } else {
      return _daysInWeek(_focusedDay);
    }
  }

  List<DateTime> getVisibleDays(DateTime focusedDay) {
    if (calendarFormat == CalendarFormat.month) {
      return _daysInMonth(focusedDay);
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      return _daysInWeek(focusedDay)
        ..addAll(_daysInWeek(
          focusedDay.add(const Duration(days: 7)),
        ));
    } else {
      return _daysInWeek(focusedDay);
    }
  }

  void _decrementPage() {
    _pageId--;
    _dx = _dxMin;
  }

  void _incrementPage() {
    _pageId++;
    _dx = _dxMax;
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final first = _firstDayOfMonth(month);
    final daysBefore = _getDaysBefore(first);
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    final last = _lastDayOfMonth(month);
    final daysAfter = _getDaysAfter(last);

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return _daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  int _getDaysBefore(DateTime firstDay) {
    return (firstDay.weekday + 7 - _getWeekdayNumber(_startingDayOfWeek)) % 7;
  }

  int _getDaysAfter(DateTime lastDay) {
    int invertedStartingWeekday = 8 - _getWeekdayNumber(_startingDayOfWeek);

    int daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7) + 1;
    if (daysAfter == 8) {
      daysAfter = 1;
    }

    return daysAfter;
  }

  List<DateTime> _daysInWeek(DateTime week) {
    final first = _firstDayOfWeek(week);
    final last = _lastDayOfWeek(week);

    return _daysInRange(first, last).toList();
  }

  DateTime _firstDayOfWeek(DateTime day) {
    day = _normalizeDate(day);

    final decreaseNum = _getDaysBefore(day);
    return day.subtract(Duration(days: decreaseNum));
  }

  DateTime _lastDayOfWeek(DateTime day) {
    day = _normalizeDate(day);

    final increaseNum = _getDaysBefore(day);
    return day.add(Duration(days: 7 - increaseNum));
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1, 12)
        : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }

  DateTime _previousWeek(DateTime week) {
    return week.subtract(const Duration(days: 7));
  }

  DateTime _nextWeek(DateTime week) {
    return week.add(const Duration(days: 7));
  }

  DateTime previousMonth(DateTime month) {
    if (month.month == 1) {
      return DateTime(month.year - 1, 12);
    } else {
      return DateTime(month.year, month.month - 1);
    }
  }

  DateTime nextMonth(DateTime month) {
    if (month.month == 12) {
      return DateTime(month.year + 1, 1);
    } else {
      return DateTime(month.year, month.month + 1);
    }
  }

  Iterable<DateTime> _daysInRange(DateTime firstDay, DateTime lastDay) sync* {
    var temp = firstDay;

    while (temp.isBefore(lastDay)) {
      yield _normalizeDate(temp);
      temp = temp.add(const Duration(days: 1));
    }
  }

  DateTime _normalizeDate(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day, 12);
  }

  DateTime _getEventKey(DateTime day) {
    return visibleEvents.keys
        .firstWhere((it) => _isSameDay(it, day), orElse: () => null);
  }

  DateTime _getHolidayKey(DateTime day) {
    return visibleHolidays.keys
        .firstWhere((it) => _isSameDay(it, day), orElse: () => null);
  }

  /// Returns true if `day` is currently selected.
  bool isSelected(DateTime day) {
    return _isSameDay(day, selectedDay);
  }

  /// Returns true if `day` is the same day as `DateTime.now()`.
  bool isToday(DateTime day) {
    return _isSameDay(day, DateTime.now());
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  bool _isWeekend(DateTime day, List<int> weekendDays) {
    return weekendDays.contains(day.weekday);
  }

  bool _isExtraDay(DateTime day, DateTime focusedDay) {
    return _isExtraDayBefore(day, focusedDay) || _isExtraDayAfter(day, focusedDay);
  }

  bool _isExtraDayBefore(DateTime day, DateTime focusedDay) {
    return day.month < focusedDay.month;
  }

  bool _isExtraDayAfter(DateTime day, DateTime focusedDay) {
    return day.month > focusedDay.month;
  }


  List<DateTime> get nextVisibleDays => _nextVisibleDays;

  int _clamp(int min, int max, int value) {
    if (value > max) {
      return max;
    } else if (value < min) {
      return min;
    } else {
      return value;
    }
  }

  List<DateTime> get previousVisibleDays => _previousVisibleDays;

  DateTime get nextFocusedDay => _nextFocusedDay;

  DateTime get previousFocusedDay => _previousFocusedDay;

}
