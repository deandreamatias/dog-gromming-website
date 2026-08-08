import 'package:dog_gromming_website/domain/models/opening_hours.dart';

class PlaceDetailsDto {
  final OpeningHours openingHours;

  const PlaceDetailsDto({required this.openingHours});

  factory PlaceDetailsDto.fromJson(Map<String, dynamic> json) {
    final current = _parseHoursInfo(json['currentOpeningHours']);
    final regular = _parseHoursInfo(json['regularOpeningHours']);

    final closedSpecialDays = current.specialDays
        .where((date) => !current.openingDates.contains(date))
        .toList();

    return PlaceDetailsDto(
      openingHours: OpeningHours(
        businessStatus: _parseBusinessStatus(json['businessStatus']),
        weekdays: _buildWeekdays(regular.periods),
        isOpenNow: current.isOpenNow,
        closedSpecialDays: closedSpecialDays,
      ),
    );
  }
}

class _HoursInfo {
  final List<Map<String, dynamic>> periods;
  final bool isOpenNow;
  final List<DateTime> specialDays;
  final List<DateTime> openingDates;

  const _HoursInfo({
    required this.periods,
    required this.isOpenNow,
    required this.specialDays,
    required this.openingDates,
  });
}

_HoursInfo _parseHoursInfo(Object? json) {
  if (json is! Map<String, dynamic>) {
    return const _HoursInfo(
      periods: [],
      isOpenNow: false,
      specialDays: [],
      openingDates: [],
    );
  }

  final rawPeriods = json['periods'];
  final periods = <Map<String, dynamic>>[
    if (rawPeriods is List)
      for (final period in rawPeriods)
        if (period is Map<String, dynamic>) period,
  ];

  final openingDates = <DateTime>[
    for (final period in periods)
      if (_parseDate((period['open'] as Map<String, dynamic>?)?['date'])
          case final DateTime date)
        date,
  ];

  final rawSpecialDays = json['specialDays'];
  final specialDays = <DateTime>[
    if (rawSpecialDays is List)
      for (final specialDay in rawSpecialDays)
        if (specialDay is Map<String, dynamic>)
          if (_parseDate(specialDay['date']) case final DateTime date) date,
  ];

  return _HoursInfo(
    periods: periods,
    isOpenNow: json['openNow'] as bool? ?? false,
    specialDays: specialDays,
    openingDates: openingDates,
  );
}

List<DaySchedule> _buildWeekdays(List<Map<String, dynamic>> periods) {
  final weekdays = List.generate(7, (_) => const DaySchedule());

  for (final period in periods) {
    final open = period['open'];
    final close = period['close'];
    if (open is! Map<String, dynamic>) continue;

    final rawDay = open['day'];
    if (rawDay is! int || rawDay < 0 || rawDay > 6) continue;

    final daySchedule = weekdays[rawDay];
    final times = [...daySchedule.times];
    final start = _toMinutes(open);

    if (close is Map<String, dynamic>) {
      times.add(
        TimeRange(startTime: start, endTime: _endMinutes(close, rawDay)),
      );
    } else {
      times.add(const TimeRange(startTime: 0, endTime: 1440));
    }

    times.sort((a, b) => a.startTime.compareTo(b.startTime));
    weekdays[rawDay] = DaySchedule(times: times);
  }

  return weekdays;
}

int _endMinutes(Map<String, dynamic> close, int openDay) {
  final rawDay = close['day'];
  var daySpan = (rawDay is int ? rawDay : openDay) - openDay;
  if (daySpan < 0) daySpan += 7;
  return (daySpan * 24 * 60 + _toMinutes(close)).clamp(0, 1440).toInt();
}

int _toMinutes(Map<String, dynamic> point) {
  final hour = point['hour'];
  final minute = point['minute'];
  return (hour is int ? hour : 0) * 60 + (minute is int ? minute : 0);
}

DateTime? _parseDate(Object? json) {
  if (json is! Map<String, dynamic>) return null;
  final year = json['year'];
  final month = json['month'];
  final day = json['day'];
  if (year is int && month is int && day is int) {
    return DateTime(year, month, day);
  }
  return null;
}

BusinessStatus _parseBusinessStatus(Object? value) {
  return switch (value) {
    'CLOSED_TEMPORARILY' => BusinessStatus.closedTemporarily,
    'CLOSED_PERMANENTLY' => BusinessStatus.closedPermanently,
    _ => BusinessStatus.operational,
  };
}
