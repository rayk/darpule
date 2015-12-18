library darpule.test.matchers.criteria;

import 'package:test/test.dart';
import 'package:darpule/matcher.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';

main() {
  group('Match has embeded Tuple:\t', () {
    test('Should detect embeded tuple.', () {
      Tuple imageCaptureEventCriteria = new Tuple([int, String, Tuple, bool]);

      TupleMatcher isImageCapture = criteriaMatcher(imageCaptureEventCriteria);

      Tuple reading1 = new Tuple([
        343,
        'foxtrox',
        new Tuple([34, 43, 45]),
        true
      ]);
      Tuple reading2 = new Tuple([343, 'beta', true]);
      Tuple reading3 = new Tuple([
        834,
        'delta',
        [34, 43, 12],
        true
      ]);

      expect(isImageCapture(reading1), isTrue);
      expect(isImageCapture(reading2), isFalse);
      expect(isImageCapture(reading3), isFalse);
    });
  });

  group('Simple matches:        \t', () {
    Tuple sensorReadingCriteria =
        new Tuple([String, int, int, int, new Optional.of(bool)]);
    Tuple serviceSignal =
        new Tuple([String, int, new Optional.of(int), bool, int]);

    TupleMatcher isSensorReading = criteriaMatcher(sensorReadingCriteria);
    TupleMatcher isServiceSignal = criteriaMatcher(serviceSignal);

    test('Should detect a senor reading with optional bool.', () {
      Tuple reading1 = new Tuple(['92834237', 20, 21, 7837, true]);
      Tuple reading2 = new Tuple(['0', 3, 3, false]);
      expect(isSensorReading(reading1), isTrue);
      expect(isSensorReading(reading2), isFalse);
    });

    test('Should detect a senor reading without optional bool.', () {
      Tuple reading1 = new Tuple(['230489-23498', 30, 31, 99938]);
      Tuple reading2 = new Tuple(['99302-South', 30, 32, 03, 938, 93, true]);
      expect(isSensorReading(reading1), isTrue);
      expect(isSensorReading(reading2), isFalse);
    });

    test('should detect service signal with optional int.', () {
      Tuple reading1 = new Tuple(['south-port', 9023, 2398, false, 8923]);
      Tuple reading2 = new Tuple(['9003-12', 9023, 1293, 2093, false, 9032]);

      expect(isServiceSignal(reading1), isTrue);
      expect(isServiceSignal(reading2), isFalse);
    });

    test('Should detect service signal without optional int.', () {
      Tuple reading1 = new Tuple(['north-port', 89283, true, 9023]);
      Tuple reading2 = new Tuple(['34434', 234, false]);

      expect(isServiceSignal(reading1), isTrue);
      expect(isServiceSignal(reading2), isFalse);
    });
  });

  group('Match has Collection:  \t', () {
    test('Should detect entry attempt with list embeded and optional.', () {
      Tuple entryAttemptCriteria =
          new Tuple([int, String, new Optional.of(int), List, bool]);
      TupleMatcher isEntryAttempt = criteriaMatcher(entryAttemptCriteria);

      Tuple reading1 = new Tuple([
        343,
        'Ocean Street',
        32,
        [3, 4, 2, 4, 2],
        false
      ]);

      Tuple reading2 = new Tuple([
        233,
        'South Wing',
        [8, 3, 2, 1, 4],
        false
      ]);

      Tuple reading3 = new Tuple([223, 'back', 8392, false]);

      Tuple reading4 = new Tuple([
        222,
        'deck',
        {'k1': 3, 'k2': 5, 'k3': 6},
        false
      ]);

      expect(isEntryAttempt(reading1), isTrue);
      expect(isEntryAttempt(reading2), isTrue);
      expect(isEntryAttempt(reading3), isFalse);
      expect(isEntryAttempt(reading4), isFalse);
    });

    test('Should detect valid sequence within an embeded list.', () {
      Tuple validClearanceEventCriteria = new Tuple([
        int,
        String,
        new List.from([39, 23, 93]),
        bool,
        int
      ]);

      TupleMatcher isValidClearance =
          criteriaMatcher(validClearanceEventCriteria);

      Tuple reading1 = new Tuple([
        0339,
        'solepoint',
        [39, 23, 93],
        true,
        23
      ]);
      Tuple reading2 = new Tuple([
        0339,
        'solepoint',
        [39, 72, 21],
        true,
        83
      ]);
      Tuple reading3 = new Tuple([0293, null, null, true, null]);

      expect(isValidClearance(reading1), isTrue);
      expect(isValidClearance(reading2), isFalse);
      expect(isValidClearance(reading3), isFalse);
    });
  });
}
