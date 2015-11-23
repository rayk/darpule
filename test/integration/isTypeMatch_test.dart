library darpule.test.isTupleTypeMatched;

import 'package:test/test.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';

main() {
  group('Concrete Pattern:\t', () {
    test('Should return false tuple is not matched using wild cards.', () {
      Tuple subject = new Tuple(['River', 'Sand', 302.3, false]);
      Tuple pattern = new Tuple([Object, Object, int, Object]);
      expect(isTupleTypeMatched(subject, pattern), isFalse);
    });

    test('Should retuen false tuple is not match element count out.', () async {
      Tuple subject = new Tuple(['River', 'Lake']);
      Tuple pattern = new Tuple([String, String, int]);
      expect(isTupleTypeMatched(subject, pattern), isFalse);
    });

    test('Should return turn if the tuple type match is order.', () async {
      Tuple tup1 = new Tuple(['Mountains', false, 392, 390.12, 'green']);
      Tuple target = new Tuple([String, bool, int, double, String]);
      expect(isTupleTypeMatched(tup1, target), isTrue);
    });

    test('Should return false if the tuple type do not orderly match.', () {
      Tuple subjectTuple = new Tuple(['String', 'String', 'String', false]);
      Tuple expectedType = new Tuple([bool, bool, int, int]);
      expect(isTupleTypeMatched(subjectTuple, expectedType), isFalse);
    });

    test('Should return false if type right but element count off.', () {
      Tuple subjectTuple = new Tuple([true, true, 343]);
      Tuple expectedType = new Tuple([bool, bool, int, int]);
      expect(isTupleTypeMatched(subjectTuple, expectedType), isFalse);
    });

    test('Should return tuple when a nullpule is used..', () async {
      Tuple nuller = new Tuple([]);
      Tuple subjectTuple = new Tuple([true, true, 343, nuller]);
      Tuple expectedType = new Tuple([bool, bool, int, Tuple]);
      expect(isTupleTypeMatched(subjectTuple, expectedType), isTrue);
    });

    test('Should return false for this long match.', () async {
      Tuple subjectTuple = new Tuple([
        'Ab',
        28,
        392.129,
        true,
        'cD',
        false,
        10,
        'longstring',
        false,
        true,
        'green'
      ]);

      Tuple pattern = new Tuple([
        String,
        int,
        double,
        bool,
        String,
        bool,
        int,
        int,
        bool,
        bool,
        bool
      ]);

      expect(isTupleTypeMatched(subjectTuple, pattern), isFalse);
    });
  });

  group('Pattern Wildcard:\t', () {
    test('Should return false element count off in pattern match.', () {
      Tuple pattern1 = new Tuple([Object, bool, int]);
      Tuple subjectTuple1 = new Tuple(['string', 'string', true, 394]);
      expect(isTupleTypeMatched(subjectTuple1, pattern1), isFalse);
    });

    test('Should return true when matching with Object wildcard.', () {
      Tuple pattern1 = new Tuple([Object, Object, bool, int]);
      Tuple subjectTuple1 = new Tuple(['string', 'string', true, 394]);
      expect(isTupleTypeMatched(subjectTuple1, pattern1), isTrue);
    });

    test('Should return true when base objects as used as wildcard.', () {
      Tuple subject = new Tuple(['Mountains', false, 392, 390.12, 'green']);
      Tuple pattern = new Tuple([Object, Object, Object, Object, String]);
      expect(isTupleTypeMatched(subject, pattern), isTrue);
    });

    test('Should return false when matching with wildcards.', () {
      Tuple pattern = new Tuple([Object, int]);
      Tuple subjectTuple = new Tuple(['string', true]);
      expect(isTupleTypeMatched(subjectTuple, pattern), isFalse);
    });
  });

  group('Optional Pattern:\t', () {
    test('Should return true when optional untyped element is present.', () {
      Tuple pattern =
          new Tuple([String, bool, int, new Optional.absent(), int]);
      Tuple subjectTuple = new Tuple(['rabbit', false, 23, 29]);
      expect(isTupleTypeMatched(subjectTuple, pattern), isTrue);
    });
  });
}
