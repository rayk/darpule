library darpule.test.predicate;

import 'package:test/test.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';

/// Boring repetitive test, basis of the tuple guarantee of being bug free.

main() {
  group('Base Predicates:\t', () {
    Tuple nulluple = new Tuple([]);
    Tuple monuple = new Tuple(["Cat"]);
    Tuple pairple = new Tuple([382, "Water"]);
    Tuple triple = new Tuple([true, false, true]);
    Tuple quadruple = new Tuple(['Rocky', 383.23902, true, 21]);
    Tuple quintuple = new Tuple([1932, false, 93928.2382, 'Mountains', 1]);
    Tuple sextuple = new Tuple([1, 8, 5, 6, 7, 0]);
    Tuple septuple = new Tuple(['true', 3, 2, false, false, 23.2, 8]);
    Tuple octuple = new Tuple([3, 1, 6, 4, 6, true, 58.3, 10]);
    Tuple nonuple = new Tuple([true, true, false, 3, 3, 2, 0, false, 4.2]);
    Tuple decuple = new Tuple([1, 3, 8, 9, 2, 5, 2, true, 84.3, 'Goat']);
    Tuple hendecuple = new Tuple([false, 3, 5, 29.4, 29, '@', 3, 7, 9, 1, 0]);
    Tuple duodecuple = new Tuple([2, 3, 5, 6, 8, 2, 8, 9, 12, 75, 12, 85]);
    Tuple tredecuple = new Tuple([1, 9, 2, 7, 3, 9, 1, 9, 1, 0, 2, 8, 2]);
    Tuple quattuordecuple =
    new Tuple([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    Tuple quindecuple =
    new Tuple([9, 3, 5, 6, 7, 2, 1, 7, 8, 5, 3, 7, 4, 6, 3]);
    Tuple sexdecuple = new Tuple(
        [true, false, 0, 3983.1, 9009, true, false, 0, 0, 0, 1, 1, 4, 5, 6, 2]);

    test('Should return true when tuple has no element else false.', () {
      expect(isNulluple(nulluple), isTrue, reason: '0 Elements ~> true');
      expect(isNulluple(monuple), isFalse, reason: '1 Element ~> false');
    });

    test('Should return true when tuple has one element else false.', () {
      expect(isMonuple(monuple), isTrue, reason: '1 Element ~> true');
      expect(isMonuple(nulluple), isFalse, reason: '0 Elements ~> false');
      expect(isMonuple(pairple), isFalse, reason: '2 Elements ~> false');
    });

    test('Should return true when tuple has two elemenets else false.', () {
      expect(isPairple(nulluple), isFalse, reason: '0 Elements ~> False');
      expect(isPairple(pairple), isTrue, reason: '2 Elements ~> True');
      expect(isPairple(triple), isFalse, reason: '3 Elements ~> True');
    });

    test('Should return true when tuple has three elements else false.', () {
      expect(isTriple(triple), isTrue, reason: '3 Elements ~> True');
      expect(isTriple(monuple), isFalse, reason: '1 Element ~> False');
      expect(isTriple(quadruple), isFalse, reason: '4 Elements ~> False');
    });

    test('Should return true when tuple has four elements else false.', () {
      expect(isQuadruple(quadruple), isTrue, reason: '4 Elements ~> true.');
      expect(isQuadruple(nulluple), isFalse, reason: '0 Elements ~> false.');
      expect(isQuadruple(quintuple), isFalse, reason: '5 Elements ~> false.');
    });

    test('Should return true when tuple has five elements else false.', () {
      expect(isQuinTuple(quintuple), isTrue, reason: '5 Elements ~> True.');
      expect(isQuinTuple(triple), isFalse, reason: '3 Elements ~> False.');
      expect(isQuinTuple(sextuple), isFalse, reason: '6 Elements ~> False');
    });

    test('Should return true when tuple has six elements else false.', () {
      expect(isSexTuple(sextuple), isTrue, reason: '6 Elements ~> True');
      expect(isSexTuple(pairple), isFalse, reason: '2 Elements ~> False');
      expect(isSexTuple(septuple), isFalse, reason: '7 Elements ~> False');
    });

    test('Should return true when tuple has seven elements else false..', () {
      expect(isSepTuple(septuple), isTrue, reason: '7 Elements ~> True');
      expect(isSepTuple(sextuple), isFalse, reason: '6 Elements ~> False');
      expect(isSepTuple(decuple), isFalse, reason: '10 Elements ~>');
    });

    test('Should return true when tuple has eight elements else false.', () {
      expect(isOctuple(octuple), isTrue, reason: '8 Elements ~> True');
      expect(isOctuple(pairple), isFalse, reason: '2 Elements ~> False');
      expect(isOctuple(hendecuple), isFalse, reason: '11 Elements ~> False');
    });

    test('Should return true when tuple has nine elements else false.', () {
      expect(isNonuple(nonuple), isTrue, reason: '9 Elements ~> True');
      expect(isNonuple(quadruple), isFalse, reason: '4 Elements ~> False');
      expect(isNonuple(quattuordecuple), isFalse,
          reason: '14 Elements ~> False');
    });

    test('Should return true when tuple has ten elements else false.', () {
      expect(isDecuple(decuple), isTrue, reason: '10 Elements ~> True');
      expect(isDecuple(sextuple), isFalse, reason: '6 Elements ~> False');
      expect(isDecuple(quintuple), isFalse, reason: '15 Elements ~> False');
    });

    test("Should return true when tuple has eleven elements else false.", () {
      expect(isHendecuple(hendecuple), isTrue, reason: '11 Elements ~> True');
      expect(isHendecuple(septuple), isFalse, reason: '7 Elements ~> False');
      expect(isHendecuple(sexdecuple), isFalse, reason: '16 Elements ~> False');
    });

    test('Should return true when tuple has twelve elements else false.', () {
      expect(isDuodecuple(duodecuple), isTrue, reason: '12 Elements ~> True');
      expect(isDuodecuple(nonuple), isFalse, reason: '9 Elements ~> False');
      expect(isDuodecuple(tredecuple), isFalse, reason: '13 Elements ~> False');
    });

    test('Should return true when tuple has thirteen elements else false.', () {
      expect(isTredecuple(tredecuple), isTrue, reason: '13 Elements ~> True');
      expect(isTredecuple(decuple), isFalse, reason: '10 Elements ~> False');
      expect(isTredecuple(octuple), isFalse, reason: '8 Elements ~> False');
    });

    test('Should return true when tuple has fourteen elements else false.', () {
      expect(isQuattuordecuple(quattuordecuple), isTrue,
          reason: '14 Elements ~> True');
      expect(isQuattuordecuple(tredecuple), isFalse,
          reason: '13 Elements ~> False');
      expect(isQuattuordecuple(sexdecuple), isFalse,
          reason: '16 Elements ~> False');
    });

    test('Should return true when tuple has fifteen elements else false.', () {
      expect(isQuindecuple(quindecuple), isTrue, reason: '15 Elements ~> True');
      expect(isQuindecuple(triple), isFalse, reason: '3 Elements ~> False');
      expect(isQuindecuple(sexdecuple), isFalse, reason: '16 Elements ~> True');
    });

    test('Should return true when tuple has sixteen elements else false.', () {
      expect(isSexdecuple(sexdecuple), isTrue, reason: '16 Elements ~> True');
      expect(isSexdecuple(nulluple), isFalse, reason: '0 Elements ~> False');
      expect(isSexdecuple(monuple), isFalse, reason: '1 Element ~>');
    });

    test('Should return true optional elements not include subject in count.',
        () {
      Tuple pattern = new Tuple([bool, int, String, new Optional.of(String)]);
      Tuple subject = new Tuple([true, 913, 'Sandpiper']);
      expect(isElementCountEqual(subject, pattern), isTrue);
    });

    test('Should return true when pattern has many optionals.', () {
      Tuple pattern = new Tuple(
          [bool, int, String, new Optional.of(String), new Optional.of(int)]);
      Tuple subject = new Tuple([true, 913, 'Sandpiper']);
      expect(isElementCountEqual(subject, pattern), isTrue);
    });

    test('Should return ture no matter sequence of options.', () {
      Tuple pattern = new Tuple(
          [new Optional.of(bool), int, String, new Optional.of(int), bool]);

      Tuple subject = new Tuple([24, 'Foxtrox', false]);
      expect(isElementCountEqual(subject, pattern), isTrue);
    });

    test('Should return true when there are no optionals.', () {
      Tuple pattern = new Tuple([String, int, bool]);
      Tuple subject = new Tuple(['farm', 342, false]);
      expect(isElementCountEqual(subject, pattern), isTrue);
    });

    test('Should return false no wildcards or optionals, subject is short', () {
      Tuple pattern = new Tuple([int, String, bool, double]);
      Tuple subject = new Tuple([23, 'water', true]);
      expect(isElementCountEqual(subject, pattern), isFalse);
    });

    test('Should return false no wildcards or optionals, subject is long', () {
      Tuple pattern = new Tuple([int, String, bool, double]);
      Tuple subject =
      new Tuple([23, 'waterlittlies', true, 3493.921, false, 'horse']);
      expect(isElementCountEqual(subject, pattern), isFalse);
    });

    test('Should return false, as wildcard included but element not.', () {
      Tuple pattern = new Tuple([int, Object, String, bool]);
      Tuple subject = new Tuple([22, 'water runner', true]);
      expect(isElementCountEqual(subject, pattern), isFalse);
    });

    test('Should return true, wildcard included and element is included.', () {
      Tuple pattern = new Tuple([Object, int, String, String, bool]);
      Tuple subject = new Tuple(['Wild', 34, 'string', 'string', true]);
      expect(isElementCountEqual(subject, pattern), isTrue);
    });

    test('Should return true, wildcard and optional used.', () {
      Tuple pattern = new Tuple([String, Object, new Optional.of(String), int]);
      Tuple subject = new Tuple(['Waterfall', 234, 4543]);
      expect(isElementCountEqual(subject, pattern), isTrue);
    });

    test('Should return true, all optionals in pattern and subject nulluple.',
        () {
      Tuple pattern =
      new Tuple([new Optional.of(String), new Optional.of(int)]);
      Tuple subject = new Tuple([]);
      expect(isElementCountEqual(subject, pattern), isTrue);
    });

    test('Should return false, optionals and wildcards used.', () {
      Tuple pattern =
      new Tuple([String, bool, Object, new Optional.of(bool), int, String]);
      Tuple subject = new Tuple(['element', 'element', 'element', 'element']);
      expect(isElementCountEqual(subject, pattern), isFalse);
    });

    test('Should return elements types as matching true.', () async {
      var element = String;
      var pattern = String;
      expect(isElementTypeMatch(element, pattern), isTrue);
    });

    test('Should return element types as not matching false.', () async {
      var element = bool;
      var pattern = int;
      expect(isElementTypeMatch(element, pattern), isFalse);
    });

    test('Should return element types as matching true.', () async {
      var element = bool;
      var pattern = Object;
      expect(isElementTypeMatch(element, pattern), isTrue);
    });

    test('Should return true when both are of type Object.', () async {
      var element = Object;
      var pattern = Object;
      expect(isElementTypeMatch(element, pattern), isTrue);
    });

    test('Should return true tuple is type matched.', () async {
      Tuple subject = new Tuple(['Views', 3490, 'lakes']);
      Tuple pattern = new Tuple([String, int, String]);
      expect(isEachElementMatched(subject, pattern), isTrue);
    });

    test('Should return false tuple not type matched.', () async {
      Tuple subject = new Tuple([8392, true, 'lake']);
      Tuple pattern = new Tuple([bool, bool, bool]);
      expect(isEachElementMatched(subject, pattern), isFalse);
    });

    test('should return false tuple not type matched.', () {
      Tuple pattern = new Tuple([Object, Object, bool, int]);
      Tuple subject = new Tuple(['string', 'string', true, 343.34]);
      expect(isEachElementMatched(subject, pattern), isFalse);
    });

    test('Should return false tuple same length not type matched.', () {
      Tuple subject = new Tuple(['Waterhole', true, false, 323]);
      Tuple pattern = new Tuple([String, int, int, int]);
      expect(isEachElementMatched(subject, pattern), isFalse);
    });

    test('should return true tuple is type matched using wild cards.', () {
      Tuple subject = new Tuple([true, true, 3900, 'lake']);
      Tuple pattern = new Tuple([Object, Object, int, String]);
      expect(isEachElementMatched(subject, pattern), isTrue);
    });



    test('Should return true if the tuple does not contain another tuple.',
        () async {
      Tuple tup1 = new Tuple(['Rain', 'forest']);
      Tuple tup2 = new Tuple(['wildeness', tup1]);
      expect(isLeaf(tup1), isTrue);
    });

    test('Should return false if the tuple does contain another tuple.',
        () async {
      Tuple tup1 = new Tuple(['Rain', 'forest']);
      Tuple tup2 = new Tuple(['wildeness', tup1]);
      expect(isLeaf(tup2), isFalse);
    });




  });
}
