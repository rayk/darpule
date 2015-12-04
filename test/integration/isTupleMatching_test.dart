library darpule.test.isTupleMatching;

import 'package:test/test.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';

main() {
  group('Simply defined single layer tuple criteria:\t', () {
    // X is Error, Y the optional element is not included

    // Nullpule
    Tuple criteria0 = new Tuple([]);
    Tuple criteria1 = new Tuple([bool]);

    // Monuple
    Tuple subject0 = new Tuple([]);
    Tuple subject1 = new Tuple([true]);
    Tuple subject1x = new Tuple(['String']);

    // Pairple
    Tuple criteria2 = new Tuple([String, int]);
    Tuple criteria2w = new Tuple([String, Object]);
    Tuple criteria2o = new Tuple([String, new Optional.of(int)]);

    Tuple subject2 = new Tuple(['String example', 38493894]);
    Tuple subject2x = new Tuple([true, 3243]);
    Tuple subject2y = new Tuple(['only string included']);

    // Triple
    Tuple criteria3 = new Tuple([bool, String, String]);
    Tuple criteria3w = new Tuple([bool, Object, String]);
    Tuple criteria3o = new Tuple([bool, String, new Optional.of(String)]);

    Tuple subject3 = new Tuple([true, 'example str', 'another str']);
    Tuple subject3x = new Tuple([343, false, 'ending string']);
    Tuple subject3y = new Tuple([false, 'example String']);

    // Quadruple
    Tuple criteria4 = new Tuple([String, int, bool, double]);
    Tuple criteria4w = new Tuple([String, int, bool, Object]);
    Tuple criteria4o = new Tuple([String, int, new Optional.of(bool), double]);

    Tuple subject4 = new Tuple(['Example String', 393, true, 0.23]);
    Tuple subject4x = new Tuple(['example', 45.34, false, 34.1]);
    Tuple subject4y = new Tuple(['example', 3, 9.03]);

    // Quintuple
    Tuple criteria5 = new Tuple([int, int, bool, double, String]);
    Tuple criteria5w = new Tuple([Object, int, Object, Object, String]);
    Tuple criteria5o =
        new Tuple([int, int, new Optional.of(bool), double, String]);

    Tuple subject5 = new Tuple([34, 234, false, 39.23, 'Fiver String']);
    Tuple subject5x = new Tuple([2.1, 34, true, 34.3, 'String']);

    // Sextuple
    Tuple criteria6 = new Tuple([double, int, String, bool, int, double]);
    Tuple criteria6w = new Tuple([double, int, String, Object, int, Object]);
    Tuple criteria6o =
        new Tuple([double, new Optional.of(int), String, bool, int, double]);

    Tuple subject6 = new Tuple([834.12, 39, 'Hello', false, 383, 0.34]);
    Tuple subject6x = new Tuple([34.2, 23, 'hello', true, 343, 232]);

    // SepTuple
    Tuple criteria7 = new Tuple([int, bool, bool, int, bool, int, bool]);
    Tuple criteria7w =
        new Tuple([Object, Object, Object, int, bool, Object, Object]);
    Tuple criteria7o =
        new Tuple([int, bool, new Optional.of(bool), int, bool, int, bool]);

    Tuple subject7 = new Tuple([2, true, true, 3, false, 3, true]);
    Tuple subject7x = new Tuple([1, false, false, 4, false, 3, 5]);

    // Octuple
    Tuple criteria8 =
        new Tuple([int, int, bool, int, String, bool, double, bool]);
    Tuple criteria8w =
        new Tuple([int, Object, Object, int, String, bool, double, bool]);
    Tuple criteria8o = new Tuple([
      new Optional.of(int),
      new Optional.of(int),
      bool,
      int,
      String,
      bool,
      double,
      bool
    ]);

    Tuple subject8 = new Tuple([3, 2, true, 2, 'example', false, 0.3, true]);
    Tuple subject8x =
        new Tuple([true, 2, false, true, 'example', true, 0.2, true]);

    test('Should return true for matched tuple.', () async {
      isTupleMatching(criteria0, subject0).then((r0) => expect(r0, isTrue));
      isTupleMatching(criteria1, subject1).then((r1) => expect(r1, isTrue));
      isTupleMatching(criteria2, subject2).then((r2) => expect(r2, isTrue));
      isTupleMatching(criteria3, subject3).then((r3) => expect(r3, isTrue));
      isTupleMatching(criteria4, subject4).then((r3) => expect(r3, isTrue));
      isTupleMatching(criteria5, subject5).then((r5) => expect(r5, isTrue));
      isTupleMatching(criteria6, subject6).then((r6) => expect(r6, isTrue));
      isTupleMatching(criteria7, subject7).then((r7) => expect(r7, isTrue));
    });

    test('Should retuen false for non match element count.', () async {
      isTupleMatching(criteria3, subject4).then((r3) => expect(r3, isFalse));
      isTupleMatching(criteria5, subject3).then((r5) => expect(r5, isFalse));
      isTupleMatching(criteria6, subject5).then((r6) => expect(r6, isFalse));
      isTupleMatching(criteria7, subject6).then((r7) => expect(r7, isFalse));
    });

    test('Should return false for non matched tuple.', () async {
      isTupleMatching(criteria1, subject1x).then((r1) => expect(r1, isFalse));
      isTupleMatching(criteria2, subject2x).then((r2) => expect(r2, isFalse));
      isTupleMatching(criteria3, subject3x).then((r3) => expect(r3, isFalse));
      isTupleMatching(criteria4, subject4x).then((r4) => expect(r4, isFalse));
      isTupleMatching(criteria5, subject5x).then((r5) => expect(r5, isFalse));
      isTupleMatching(criteria6, subject6x).then((r6) => expect(r6, isFalse));
      isTupleMatching(criteria7, subject7x).then((r7) => expect(r7, isFalse));
    });

    test('Should return true for match with wildcards.', () async {
      isTupleMatching(criteria2w, subject2).then((r2) => expect(r2, isTrue));
      isTupleMatching(criteria3w, subject3).then((r3) => expect(r3, isTrue));
      isTupleMatching(criteria4w, subject4).then((r4) => expect(r4, isTrue));
      isTupleMatching(criteria5w, subject5).then((r5) => expect(r5, isTrue));
      isTupleMatching(criteria6w, subject6).then((r6) => expect(r6, isTrue));
      isTupleMatching(criteria7w, subject7).then((r7) => expect(r7, isTrue));
    });

    test('Should return true for matched with optionals.', () async {
      isTupleMatching(criteria2o, subject2).then((r2) => expect(r2, isTrue));
      isTupleMatching(criteria3o, subject3).then((r3) => expect(r3, isTrue));
      isTupleMatching(criteria4o, subject4).then((r4) => expect(r4, isTrue));
      isTupleMatching(criteria5o, subject5).then((r5) => expect(r5, isTrue));
      isTupleMatching(criteria6o, subject6).then((r6) => expect(r6, isTrue));
      isTupleMatching(criteria7o, subject7).then((r7) => expect(r7, isTrue));
    });

    test('*Should return true when optional elements not included', () {
      isTupleMatching(criteria2o, subject2y).then((r2) => expect(r2, isTrue));
      isTupleMatching(criteria3o, subject3y).then((r3) => expect(r3, isTrue));
      isTupleMatching(criteria4o, subject4y).then((r4) => expect(r4, isTrue));
    });

    test('Should return false for non match with optional type.', () async {
      isTupleMatching(criteria2o, subject2x).then((r2) => expect(r2, isFalse));
      isTupleMatching(criteria3o, subject3x).then((r3) => expect(r3, isFalse));
      isTupleMatching(criteria4o, subject4x).then((r4) => expect(r4, isFalse));
      isTupleMatching(criteria5o, subject5x).then((r5) => expect(r5, isFalse));
      isTupleMatching(criteria6o, subject6x).then((r6) => expect(r6, isFalse));
      isTupleMatching(criteria7o, subject7x).then((r7) => expect(r7, isFalse));
    });
  });
}
