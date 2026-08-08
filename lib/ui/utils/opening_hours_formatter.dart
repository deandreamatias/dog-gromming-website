import 'package:dog_gromming_website/domain/models/opening_hours.dart';

class OpeningHoursFormatter {
  const OpeningHoursFormatter();

  List<String> schedule(OpeningHours hours, List<String> weekdayLabels) {
    final lines = <String>[];
    final weekdays = hours.weekdays;

    int dayIndex = 0;
    while (dayIndex < 7) {
      final day = weekdays[dayIndex];
      if (day.isClosed) {
        dayIndex++;
        continue;
      }

      final signature = _signature(day);
      final groupLabels = <String>[];
      while (dayIndex < 7 &&
          !weekdays[dayIndex].isClosed &&
          _signature(weekdays[dayIndex]) == signature) {
        groupLabels.add(weekdayLabels[dayIndex]);
        dayIndex++;
      }

      final dayLabel = groupLabels.length == 1
          ? groupLabels.first
          : '${groupLabels.first} – ${groupLabels.last}';
      lines.add('$dayLabel: $signature');
    }

    return lines;
  }

  List<String> closedDayLines(
    OpeningHours hours,
    List<String> weekdayLabels,
    String Function(DateTime date) labelOf,
  ) {
    return [
      for (final date in hours.closedSpecialDays)
        '${labelOf(date)} (${_weekdayLabel(date, weekdayLabels)})',
    ];
  }

  String _signature(DaySchedule day) {
    return day.times
        .map(
          (time) =>
              '${_formatTime(time.startTime)}–${_formatTime(time.endTime)}',
        )
        .join(', ');
  }

  String _weekdayLabel(DateTime date, List<String> weekdayLabels) =>
      weekdayLabels[date.weekday % 7];

  String _formatTime(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${remainingMinutes.toString().padLeft(2, '0')}';
  }
}
