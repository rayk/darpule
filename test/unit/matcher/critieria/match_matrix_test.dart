library darpule.test.matchers.criteria.positions;

import 'package:darpule/src/matchers/criteria/criteria_matcher.dart';
import 'package:darpule/src/matchers/criteria/combiner/combine.dart';
import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:quiver_optional/optional.dart';

main() {
  group('Combination Generation:\t', () {
    Tuple criteria = new Tuple([
      bool,
      new Optional.of(int),
      String,
      double,
      new Optional.of(bool),
      String,
      bool,
      new Optional.of(String),
      new Optional.of(bool),
      int,
      String,
      String,
      new Optional.of(int),
      new Optional.of(double),
      bool,
      new Optional.of(String)
    ]);

    List mandatory = [0, 2, 3, 5, 6, 9, 10, 11, 14];

    test('Should return list of 1 combination, for 9 elements.', () {
      List result = combine(9, criteria, mandatory);
      expect(result.length, equals(1));
    });

    test('Should return list of 7 combinations, for 10 elements', () {
      List result = combine(10, criteria, mandatory);
      expect(result.length, equals(7));
    });

    test('Should return list of 21 combinations, for 11 elements', () {
      List result = combine(11, criteria, mandatory);
      expect(result.length, equals(21));
    });

    test('Should return list of 35 combinations, for 12 elements', () {
      List result = combine(12, criteria, mandatory);
      expect(result.length, equals(35));
    });

    test('Should return list of 35 combinations, for 13 elements', () {
      List result = combine(13, criteria, mandatory);
      expect(result.length, equals(35));
    });

    test('Should return list of 21 combination, for 14 elements', () {
      List result = combine(14, criteria, mandatory);
      expect(result.length, equals(21));
    });

    test('Should return list of 7 combination, for 15 elements', () {
      List result = combine(15, criteria, mandatory);
      expect(result.length, equals(7));
    });

    test('Should return list of 1 combination, for 16 elements', () {
      List result = combine(16, criteria, mandatory);
      expect(result.length, equals(1));
    });
  });

  group('Combinations Mapped:   \t', () {
    Tuple criteria = new Tuple([
      bool,
      new Optional.of(int),
      String,
      double,
      new Optional.of(bool),
      String,
      bool,
      new Optional.of(String),
      new Optional.of(bool),
      int,
      String,
      String,
      new Optional.of(int),
      new Optional.of(double),
      bool,
      new Optional.of(String)
    ]);


    test('Should return a Map.', () {
      Map result = generateMatchMatrix(criteria);
      expect(result is Map, isTrue);
    });

    test('Should contian keys matching sequence length.', () {
      Map result = generateMatchMatrix(criteria);
      expect(result[9] is List, isTrue);
      expect(result[9].length, equals(1));
      expect(result[10].length, equals(7));
      expect(result[11].length, equals(21));
      expect(result[12].length, equals(35));
      expect(result[13].length, equals(35));
      expect(result[14].length, equals(21));
      expect(result[15].length, equals(7));
      expect(result[16].length, equals(1));
    });

    test('Should contain the set of matchers..', ()  {
      Map result = generateMatchMatrix(criteria);
      expect(result['matchers'], isNotEmpty);
    });
  });
}
