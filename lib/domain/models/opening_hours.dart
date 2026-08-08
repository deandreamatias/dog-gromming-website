enum BusinessStatus { operational, closedTemporarily, closedPermanently }

class TimeRange {
  final int startTime;
  final int endTime;

  const TimeRange({required this.startTime, required this.endTime});
}

class DaySchedule {
  final List<TimeRange> times;

  const DaySchedule({this.times = const []});

  bool get isClosed => times.isEmpty;
}

class OpeningHours {
  final BusinessStatus businessStatus;
  final List<DaySchedule> weekdays;
  final bool isOpenNow;
  final List<DateTime> closedSpecialDays;

  const OpeningHours({
    required this.businessStatus,
    required this.weekdays,
    required this.isOpenNow,
    required this.closedSpecialDays,
  });
}
