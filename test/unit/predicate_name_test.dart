library darpule.test.predicate.name;

import 'package:darpule/src/predicates/base.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';
import 'package:test/test.dart';

main(){
  group('Tuple Name Predicates:\t', () {
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
  });
}