library darpule.test.predicate;

import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';
import 'package:test/test.dart';

/// Boring repetitive test, basis of the tuple guarantee of being bug free.

main() {


  group('isElementTypeMatched:\t', () {
    test('** Should return true when criterion and element match.', () {
      expect(isElementTypeMatched(String, 'The Fox and Bear'), isTrue);
      expect(isElementTypeMatched(int, 9302), isTrue);
      expect(isElementTypeMatched(bool, false), isTrue);
      expect(isElementTypeMatched(double, 393.22), isTrue);
      expect(isElementTypeMatched(Tuple, new Tuple([])), isTrue);
      expect(isElementTypeMatched(Tuple, new Tuple(['dog', 'cat'])), isTrue);
      expect(isElementTypeMatched(DateTime, new DateTime.now()), isTrue);
    });

    test('Should return false when criterion and elements do not match.', () {
      expect(isElementTypeMatched(String, false), isFalse);
      expect(isElementTypeMatched(int, 'String example'), isFalse);
      expect(isElementTypeMatched(bool, 323), isFalse);
      expect(isElementTypeMatched(double, true), isFalse);
      expect(isElementTypeMatched(Tuple, new DateTime.now()), isFalse);
      expect(isElementTypeMatched(DateTime, new Tuple([])), isFalse);
    });

    test('Should return true when match against wildcard.', () {
      expect(isElementTypeMatched(Object, 'String Line'), isTrue);
      expect(isElementTypeMatched(Object, 302), isTrue,
          reason: 'int is object');
      expect(isElementTypeMatched(Object, 232.234), isTrue);
      expect(isElementTypeMatched(Object, false), isTrue);
      expect(isElementTypeMatched(Object, new DateTime.now()), isTrue);
      expect(isElementTypeMatched(Object, new Tuple([])), isTrue);
      expect(isElementTypeMatched(Object, null), isTrue);
    });

    test('Should return true when non typed optional matches anything.', () {
      expect(isElementTypeMatched(new Optional.absent(), 'Example'), isTrue);
      expect(isElementTypeMatched(new Optional.absent(), 1234), isTrue);
      expect(isElementTypeMatched(new Optional.absent(), 382.293), isTrue);
      expect(
          isElementTypeMatched(new Optional.absent(), new Tuple([])), isTrue);
      expect(isElementTypeMatched(new Optional.absent(), new DateTime.now()),
          isTrue);
    });

    test('Should return true when typed optional matches element.', () {
      expect(isElementTypeMatched(new Optional.of(int), 83923), isTrue);
      expect(isElementTypeMatched(new Optional.of(String), 'Example'), isTrue);
      expect(isElementTypeMatched(new Optional.of(bool), false), isTrue);
      expect(isElementTypeMatched(new Optional.of(double), 384.2), isTrue);
      expect(
          isElementTypeMatched(new Optional.of(Tuple), new Tuple([])), isTrue);
    });

    test('Should return false when optional element has incorrect type.', () {
      expect(isElementTypeMatched(new Optional.of(int), 'String'), isFalse);
      expect(isElementTypeMatched(new Optional.of(String), 232), isFalse);
      expect(isElementTypeMatched(new Optional.of(bool), 0.343), isFalse);
      expect(isElementTypeMatched(new Optional.of(double), true), isFalse);
      expect(isElementTypeMatched(new Optional.of(Tuple), new DateTime.now()),
          isFalse);
      expect(
          isElementTypeMatched(new Optional.of(Object), 'Anything'), isFalse);
      expect(isElementTypeMatched(new Optional.of(String), null), isFalse);
    });

    test('Should return false when collections are criterion.', () {
      expect(isElementTypeMatched(new Optional.of(List), new List()), isFalse);
      expect(isElementTypeMatched(new Optional.of(Map), new Map()), isFalse);
      expect(isElementTypeMatched(new Optional.of(Set), new Set()), isFalse);
      expect(isElementTypeMatched(List, new List()), isFalse);
    });

    test('Should behaviour predicablity with nulls.', () {
      expect(isElementTypeMatched(null, null), isFalse);
      expect(isElementTypeMatched(String, null), isFalse);
      expect(isElementTypeMatched(int, null), isFalse);
    });
  });

  group('isElementCountEqual:\t', () {
    test('Should return true optional elements not include subject in count.',
        () {
      Tuple pattern = new Tuple([bool, int, String, new Optional.of(String)]);
      Tuple subject = new Tuple([true, 913, 'Sandpiper']);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return true when pattern has many optionals.', () {
      Tuple pattern = new Tuple(
          [bool, int, String, new Optional.of(String), new Optional.of(int)]);
      Tuple subject = new Tuple([true, 913, 'Sandpiper']);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return ture no matter sequence of options.', () {
      Tuple pattern = new Tuple(
          [new Optional.of(bool), int, String, new Optional.of(int), bool]);

      Tuple subject = new Tuple([24, 'Foxtrox', false]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return true when there are no optionals.', () {
      Tuple pattern = new Tuple([String, int, bool]);
      Tuple subject = new Tuple(['farm', 342, false]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return false no wildcards or optionals, subject is short', () {
      Tuple pattern = new Tuple([int, String, bool, double]);
      Tuple subject = new Tuple([23, 'water', true]);
      expect(isMatchPossible(pattern, subject), isFalse);
    });

    test('should return false no wildcards or optionals, subject to long', () {
      Tuple pattern = new Tuple([int, String, bool, double]);
      Tuple subject = new Tuple([23, 'water', true, 0.3, 'string', false]);
      expect(isMatchPossible(pattern, subject), isFalse);
    });

    test('Should return false no wildcards or optionals, subject is long', () {
      Tuple pattern = new Tuple([int, String, bool, double]);
      Tuple subject =
          new Tuple([23, 'waterlittlies', true, 3493.921, false, 'horse']);
      expect(isMatchPossible(pattern, subject), isFalse);
    });

    test('Should return false, as wildcard included but element not.', () {
      Tuple pattern = new Tuple([int, Object, String, bool]);
      Tuple subject = new Tuple([22, 'water-runner', true]);
      expect(isMatchPossible(pattern, subject), isFalse);
    });

    test('Should return true, wildcard included and element is included.', () {
      Tuple pattern = new Tuple([Object, int, String, String, bool]);
      Tuple subject = new Tuple(['Wild', 34, 'string', 'string', true]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return true, when no optional or wildcards are include.', () {
      Tuple pattern = new Tuple([String, int, bool]);
      Tuple subject = new Tuple(['String literal', 39, true]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return true, wildcard and optional used.', () {
      Tuple pattern = new Tuple([String, Object, new Optional.of(String), int]);
      Tuple subject = new Tuple(['Waterfall', 234, 4543]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return true, all optionals in pattern and subject nulluple.',
        () {
      Tuple pattern =
          new Tuple([new Optional.of(String), new Optional.of(int)]);
      Tuple subject = new Tuple([]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('*Should return true, when subject contains some of the optionals.',
        () {
      Tuple pattern = new Tuple(
          [String, new Optional.of(int), bool, new Optional.of(String)]);
      Tuple subject = new Tuple(['String literial', 934, false]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return false, optionals and wildcards used.', () {
      Tuple pattern =
          new Tuple([String, bool, Object, new Optional.of(bool), int, String]);
      Tuple subject = new Tuple(['element', 'element', 'element', 'element']);
      expect(isMatchPossible(pattern, subject), isFalse);
    });

    test('Should return true when optionals are in the actual elements.', () {
      Tuple pattern = new Tuple([String, bool, new Optional.of(int), double]);
      Tuple subject = new Tuple(['WaterRat', true, 38, 394.34]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return true when many optionals are in the actual elements.',
        () {
      Tuple pattern =
          new Tuple([bool, new Optional.of(int), new Optional.of(String), int]);
      Tuple subject = new Tuple([true, 343, 'skyrunner', 992]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });

    test('Should return true no matter where the optional is located.', () {
      Tuple pattern = new Tuple([
        new Optional.of(bool),
        new Optional.absent(),
        new Optional.of(int),
        bool,
        double
      ]);
      Tuple subject = new Tuple([true, 33, 93, false, 393.32]);
      expect(isMatchPossible(pattern, subject), isTrue);
    });
  });

  group("Transform Requirements:\t", () {
    test('Should return true when insert optionals could cause a match.', () {
      Tuple criteria1 = new Tuple([String, int, new Optional.of(int), bool]);
      Tuple subject1 = new Tuple(['String Example', 343, true]);
      expect(isMissingOptionalPossible(criteria1, subject1), isTrue);

      Tuple criteria2 =
          new Tuple([bool, new Optional.of(int), int, new Optional.of(bool)]);
      Tuple subject2 = new Tuple([true, 293, 239]);
      expect(isMissingOptionalPossible(criteria2, subject2), isTrue);

      Tuple criteria3 = new Tuple([
        new Optional.of(bool),
        bool,
        int,
        new Optional.of(int),
        new Optional.of(String),
        String
      ]);
      Tuple subject3 = new Tuple([true, 034, 'Example String']);
      expect(isMissingOptionalPossible(criteria3, subject3), isTrue);
    });

    test('Should return false when no optionals are in the criteria.', () {
      Tuple criteria = new Tuple([String, int, bool]);
      Tuple subject = new Tuple(['Test String', 9304]);
      expect(isMissingOptionalPossible(criteria, subject), isFalse);
    });

    test('Should return false when element count not explained by optionals.',
        () {
      Tuple criteria = new Tuple(
          [int, bool, new Optional.of(int), new Optional.of(bool), bool, int]);
      Tuple subject = new Tuple([23, true, false]);
      expect(isMissingOptionalPossible(criteria, subject), isFalse);
    });
  });
}
