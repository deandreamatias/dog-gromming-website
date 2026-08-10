import 'package:dog_gromming_website/ui/utils/validators_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValidatorsUtil.isEmail', () {
    const validEmails = <String>[
      'a@b.es',
      'name.surname@example.com',
      'name+suffix@example.co.uk',
      'user_name@sub.example.com',
      '"a b"@example.es',
      'a@b.cat',
    ];

    const invalidEmails = <String>[
      'a@',
      'a@b',
      'a b@example.com',
      'x@.com',
      '@example.com',
      'a@b..com',
      'a b c@example.com',
      'john.doe@example..com',
    ];

    for (final email in validEmails) {
      test('accepts "$email"', () {
        expect(ValidatorsUtil.isEmail(email), isTrue);
      });
    }

    for (final email in invalidEmails) {
      test('rejects "$email"', () {
        expect(ValidatorsUtil.isEmail(email), isFalse);
      });
    }
  });

  group('ValidatorsUtil.isPhone', () {
    const validPhones = <String>[
      '+34654477396',
      '654477396',
      '+34 654 477 396',
      '+351912345678',
      '+35191 234 5678',
      '91-2345-678',
    ];

    const invalidPhones = <String>[
      '+',
      '12345',
      'a12',
      '12a',
      '+1234567890123456',
      '+12345678901234567',
      '',
    ];

    for (final phone in validPhones) {
      test('accepts "$phone"', () {
        expect(ValidatorsUtil.isPhone(phone), isTrue);
      });
    }

    for (final phone in invalidPhones) {
      test('rejects "$phone"', () {
        expect(ValidatorsUtil.isPhone(phone), isFalse);
      });
    }
  });
}
