// Copyright (c) 2015, Ray King. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library darpule.test.tuple;

import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:quiver_optional/optional.dart';

/// Boring repetitive test that provide the baseline guarantees as to tuple behaviour.

main() {
  group("Tuple Creation:\t", () {
    String element0 = "Mountain Ranges";
    int element1 = 3920;
    double element2 = 29023.12;
    String element3 = "Cut Valley";
    List element4 = new List(0);
    Map element5 = {'key1': 'value1', 'key2': 'value2'};
    List element6 = ['winter', 'spring', 'summer', 'autunm'];
    String element7 = "";
    String element8 = 'Edge Point';
    String element9 = 'Gathering Point';
    int element10 = 1234;
    DateTime element11 = new DateTime.now();
    List element12 = ['cold', 'warm', 'hot', 'cool'];
    double element13 = 1972.12;
    Map element14 = {'key3': 'value3', 'key4': 'value4'};
    String element15 = 'A9384F039483CB3490Z5';

    test('Should create a Nulluple, no elements.', () {
      Tuple testTuple = new Tuple([]);
      expect(testTuple.type, equals(TupleType.nulluple));
      expect(testTuple.elementCount, equals(0));
    });

    test('Should create a Monuple, with 1 element.', () {
      Tuple testTuple = new Tuple([element0]);
      expect(testTuple.type, equals(TupleType.monuple));
      expect(testTuple[0] is String, isTrue);
    });

    test('Should create a Pairple, with 2 element.', () {
      Tuple testTuple = new Tuple([element0, element1]);
      expect(testTuple.type, equals(TupleType.pairple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
    });

    test('Should create a Triple, with 3 elements.', () {
      Tuple testTuple = new Tuple([element0, element1, element2]);
      expect(testTuple.type, equals(TupleType.triple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
    });

    test('Should create a Quadruple, with 4 elements.', () {
      Tuple testTuple = new Tuple([element0, element1, element2, element3]);
      expect(testTuple.type, equals(TupleType.quadruple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
    });

    test('Should create a Quintuple, with 5 elements.', () {
      Tuple testTuple =
      new Tuple([element0, element1, element2, element3, element4]);
      expect(testTuple.type, equals(TupleType.quintuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
    });

    test("Should create a Sextuple, with 6 elements.", () {
      Tuple testTuple = new Tuple(
          [element0, element1, element2, element3, element4, element5]);
      expect(testTuple.type, equals(TupleType.sextuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
    });

    test('Should create a Septuple, with 7 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6
      ]);
      expect(testTuple.type, equals(TupleType.septuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
    });

    test('Should create a Octuple, with 8 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7
      ]);
      expect(testTuple.type, equals(TupleType.octuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
    });

    test('Should create a Nonuple, with 9 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8
      ]);
      expect(testTuple.type, equals(TupleType.nonuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
    });

    test("Should create a Decuple, with 10 elements.", () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9
      ]);
      expect(testTuple.type, equals(TupleType.decuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
      expect(testTuple[9] is String, isTrue);
    });

    test("Should create a Hendecuple, with 11 elements.", () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9,
        element10
      ]);
      expect(testTuple.type, equals(TupleType.hendecuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
      expect(testTuple[9] is String, isTrue);
      expect(testTuple[10] is int, isTrue);
    });

    test('Should create a Duodecuple, with 12 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9,
        element10,
        element11
      ]);
      expect(testTuple.type, equals(TupleType.duodecuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
      expect(testTuple[9] is String, isTrue);
      expect(testTuple[10] is int, isTrue);
      expect(testTuple[11] is DateTime, isTrue);
    });

    test('Should create a Tredecuple, with 13 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9,
        element10,
        element11,
        element12
      ]);
      expect(testTuple.type, equals(TupleType.tredecuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
      expect(testTuple[9] is String, isTrue);
      expect(testTuple[10] is int, isTrue);
      expect(testTuple[11] is DateTime, isTrue);
      expect(testTuple[12] is List, isTrue);
    });

    test('Should create a Quattuordecuple, with 14 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9,
        element10,
        element11,
        element12,
        element13
      ]);
      expect(testTuple.type, equals(TupleType.quattuordecuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
      expect(testTuple[9] is String, isTrue);
      expect(testTuple[10] is int, isTrue);
      expect(testTuple[11] is DateTime, isTrue);
      expect(testTuple[12] is List, isTrue);
      expect(testTuple[13] is double, isTrue);
    });

    test('Should create a Quindecuple, with 15 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9,
        element10,
        element11,
        element12,
        element13,
        element14
      ]);
      expect(testTuple.type, equals(TupleType.quindecuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
      expect(testTuple[9] is String, isTrue);
      expect(testTuple[10] is int, isTrue);
      expect(testTuple[11] is DateTime, isTrue);
      expect(testTuple[12] is List, isTrue);
      expect(testTuple[13] is double, isTrue);
      expect(testTuple[14] is Map, isTrue);
    });

    test('Should create a Sexdecuple, with 16 elements.', () {
      Tuple testTuple = new Tuple([
        element0,
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9,
        element10,
        element11,
        element12,
        element13,
        element14,
        element15,
      ]);
      expect(testTuple.type, equals(TupleType.sexdecuple));
      expect(testTuple[0] is String, isTrue);
      expect(testTuple[1] is int, isTrue);
      expect(testTuple[2] is double, isTrue);
      expect(testTuple[3] is String, isTrue);
      expect(testTuple[4] is List, isTrue);
      expect(testTuple[5] is Map, isTrue);
      expect(testTuple[6] is List, isTrue);
      expect(testTuple[7] is String, isTrue);
      expect(testTuple[8] is String, isTrue);
      expect(testTuple[9] is String, isTrue);
      expect(testTuple[10] is int, isTrue);
      expect(testTuple[11] is DateTime, isTrue);
      expect(testTuple[12] is List, isTrue);
      expect(testTuple[13] is double, isTrue);
      expect(testTuple[14] is Map, isTrue);
      expect(testTuple[15] is String, isTrue);
    });

    test('Should not include optional types in element count.', () {
      Tuple testTupleOpt =
      new Tuple(['String Word', 23, true, new Optional.absent()]);
      expect(testTupleOpt.elementCount, 3);
      expect(testTupleOpt.length, 4);
    });

    test('Should not include many optional types in element count.', () {
      Tuple testTupleOpt = new Tuple(
          [String, int, new Optional.absent(), new Optional.absent()]);
      expect(testTupleOpt.elementCount, 2);
      expect(testTupleOpt.length, 4);
    });
  });

  group('Tuple Hashing:\t', () {
    test('Should always return the same hash for same tuple.', () {
      Tuple testTuple = new Tuple(['Horse', 323, 2342.23]);
      var hashcode1 = testTuple.hashCode;
      var hashcode2 = testTuple.hashCode;
      expect(hashcode1, equals(hashcode2));
    });

    test("Should return a unquie hash for simular tuples.", () {
      Tuple testTuple01 = new Tuple(['Horse', 'Cart']);
      Tuple testTuple02 = new Tuple(['Horse', 'Cart']);
      expect(testTuple01.hashCode, isNot(equals(testTuple02)));
      expect(identical(testTuple01, testTuple02), isFalse);
    });

    test("Should return a unquie after assignment of the tuple.", () {
      Tuple testTuple = new Tuple([234, 1238, 433, "River"]);
      List assignTuple = testTuple();
      expect(testTuple.hashCode, isNot(equals(assignTuple.hashCode)));
    });
  });

  group('Tuple Equals:\t', () {
    test('Should not be equal if the number of elements is different.', () {
      Tuple testTuple1 = new Tuple(["City", 'Wind', 3490]);
      Tuple testTuple2 = new Tuple(['City', 'Willow', 3489, 234.12]);
      expect(testTuple1 == testTuple2, isFalse);
    });

    test('Should be equals on  same number of elements with same values.', () {
      Tuple testTuple1 = new Tuple(['City', 'Horse', 1234]);
      Tuple testTuple2 = new Tuple(['City', 'Horse', 1234]);
      expect(testTuple1 == testTuple2, isTrue);
    });

    test('Should not be equal just because the same number of elements.', () {
      Tuple testTuple1 = new Tuple(['Water', 'Wind', 'Fire']);
      Tuple testTuple2 = new Tuple(['Rabbit', 'Jack', ' Total']);
      expect(testTuple1 == testTuple2, isFalse);
    });

    test('Should not be equal because of a partial match.', () {
      Tuple testTuple1 = new Tuple(['Water', 'Wind', 'Water']);
      Tuple testTuple2 = new Tuple(['Water', 'Wild', 'Fire']);
      expect(testTuple1 == testTuple2, isFalse);
    });
  });

  group('Element Types;\t', () {
    test('Should return the element types.', () async {
      Tuple typeTest1 = new Tuple(["String", 3892, 3892.34]);
      Tuple elementTypes = elementTypesOf(typeTest1);
    });
  });

  group("Tuple toString():\t", () {
    test('Should return a string describing the tuple', () {
      Tuple testTupleA =
      new Tuple(['Bear', 'snow', 'water', 34.23, 2, 'views', 'food']);
      expect(
          testTupleA.toString(),
          equals(
              "TupleType.septuple - [Bear, snow, water, 34.23, 2, views, food]"));
    });
  });
}
