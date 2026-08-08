import 'package:dog_gromming_website/data/dto/place_details_dto.dart';
import 'package:dog_gromming_website/domain/models/opening_hours.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlaceDetailsDto', () {
    test('parses regular opening hours and open now', () {
      final dto = PlaceDetailsDto.fromJson(<String, dynamic>{
        'businessStatus': 'OPERATIONAL',
        'regularOpeningHours': <String, dynamic>{
          'openNow': false,
          'periods': <Map<String, dynamic>>[
            for (var day = 1; day <= 5; day++)
              <String, dynamic>{
                'open': <String, dynamic>{'day': day, 'hour': 10, 'minute': 0},
                'close': <String, dynamic>{'day': day, 'hour': 14, 'minute': 0},
              },
            for (var day = 1; day <= 5; day++)
              <String, dynamic>{
                'open': <String, dynamic>{'day': day, 'hour': 16, 'minute': 0},
                'close': <String, dynamic>{
                  'day': day,
                  'hour': 19,
                  'minute': 30,
                },
              },
          ],
        },
        'currentOpeningHours': <String, dynamic>{
          'openNow': true,
          'specialDays': <Object>[],
        },
      });

      final hours = dto.openingHours;

      expect(hours.businessStatus, BusinessStatus.operational);
      expect(hours.isOpenNow, isTrue);
      expect(hours.closedSpecialDays, isEmpty);
      expect(hours.weekdays, hasLength(7));

      expect(hours.weekdays[0].isClosed, isTrue);
      expect(hours.weekdays[6].isClosed, isTrue);

      final monday = hours.weekdays[1];
      expect(monday.times, hasLength(2));
      expect(monday.times[0].startTime, 600);
      expect(monday.times[0].endTime, 840);
      expect(monday.times[1].startTime, 960);
      expect(monday.times[1].endTime, 1170);
    });

    test('detects special days without opening periods as closed', () {
      final dto = PlaceDetailsDto.fromJson(<String, dynamic>{
        'businessStatus': 'OPERATIONAL',
        'regularOpeningHours': <String, dynamic>{
          'periods': <Map<String, dynamic>>[
            <String, dynamic>{
              'open': <String, dynamic>{'day': 1, 'hour': 10, 'minute': 0},
              'close': <String, dynamic>{'day': 1, 'hour': 14, 'minute': 0},
            },
          ],
        },
        'currentOpeningHours': <String, dynamic>{
          'openNow': false,
          'specialDays': <Map<String, dynamic>>[
            <String, dynamic>{
              'date': <String, dynamic>{'year': 2026, 'month': 8, 'day': 15},
            },
          ],
        },
      });

      expect(dto.openingHours.closedSpecialDays, <DateTime>[
        DateTime(2026, 8, 15),
      ]);
    });

    test('keeps special days with opening periods as open', () {
      final dto = PlaceDetailsDto.fromJson(<String, dynamic>{
        'businessStatus': 'OPERATIONAL',
        'regularOpeningHours': <String, dynamic>{
          'periods': <Map<String, dynamic>>[
            <String, dynamic>{
              'open': <String, dynamic>{'day': 1, 'hour': 10, 'minute': 0},
              'close': <String, dynamic>{'day': 1, 'hour': 14, 'minute': 0},
            },
          ],
        },
        'currentOpeningHours': <String, dynamic>{
          'openNow': false,
          'specialDays': <Map<String, dynamic>>[
            <String, dynamic>{
              'date': <String, dynamic>{'year': 2026, 'month': 12, 'day': 24},
            },
          ],
          'periods': <Map<String, dynamic>>[
            <String, dynamic>{
              'open': <String, dynamic>{
                'date': <String, dynamic>{'year': 2026, 'month': 12, 'day': 24},
                'day': 4,
                'hour': 9,
                'minute': 0,
              },
              'close': <String, dynamic>{'day': 4, 'hour': 13, 'minute': 0},
            },
          ],
        },
      });

      expect(dto.openingHours.closedSpecialDays, isEmpty);
    });

    test('maps closed temporarily business status', () {
      final dto = PlaceDetailsDto.fromJson(<String, dynamic>{
        'businessStatus': 'CLOSED_TEMPORARILY',
        'currentOpeningHours': <String, dynamic>{},
      });

      expect(dto.openingHours.businessStatus, BusinessStatus.closedTemporarily);
    });
  });
}
