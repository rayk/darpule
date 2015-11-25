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

    test('Should retuen false tuple is not match element count out.', () {
      Tuple subject = new Tuple(['River', 'Lake']);
      Tuple pattern = new Tuple([String, String, int]);
      expect(isTupleTypeMatched(subject, pattern), isFalse);
    });

    test('Should return turn if the tuple type match is order.', () {
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

    test('Should return tuple when a nullpule is used..', () {
      Tuple nuller = new Tuple([]);
      Tuple subjectTuple = new Tuple([true, true, 343, nuller]);
      Tuple expectedType = new Tuple([bool, bool, int, Tuple]);
      expect(isTupleTypeMatched(subjectTuple, expectedType), isTrue);
    });

    test('Should return false for this long match.', () {
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

    test('Should return true match a tuple in the tuple.', () {
      Tuple pattern = new Tuple([bool, Tuple]);
      Tuple tuptup = new Tuple([]);
      Tuple subject = new Tuple([false, tuptup]);
      expect(isTupleTypeMatched(subject, pattern), isTrue);
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

    test('Should return false when Tuple can not match even with optional.',
        () {
      Tuple pattern = new Tuple(
          [new Optional.of(int), new Optional.of(String), bool, double]);
      Tuple subject = new Tuple(['Waterfalls', true, 8394.23, 903]);
      expect(isTupleTypeMatched(subject, pattern), isFalse);
    });
  });

  group('Deep Type Match:\t', () {

    Tuple layer0, layer1TypeA, layer1TypeB, layer1TypeC, layer2TypeA, layer2TypeB, layer2TypeC, layer2TypeD, layer3TypeA, layer3TypeB, layer3TypeC, layer3TypeD, layer3TypeE, layer4TypeA,
        layer4TypeB,
        layer4TypeC,
        layer4TypeD,
        layer4TypeE,
        layer4TypeF;

    Optional optionalString, optionalBool, optionalInt, optionalDouble, optionalWild;
    optionalString = new Optional.of(String);
    optionalBool = new Optional.of(bool);
    optionalInt = new Optional.of(int);
    optionalDouble = new Optional.of(double);
    optionalWild = new Optional.absent();

    layer4TypeF = new Tuple([bool, String, int, double, int]);
    layer4TypeE = new Tuple([int, bool, String, int, double]);
    layer4TypeD = new Tuple([double, int, bool, String, int]);
    layer4TypeC = new Tuple([int, double, int, bool, String]);
    layer4TypeB = new Tuple([String, int, double, int, bool]);
    layer4TypeA = new Tuple([Object, Object, optionalBool, bool]);

    layer3TypeE = new Tuple([layer4TypeE, bool, layer4TypeF]);
    layer3TypeD =
        new Tuple([Tuple, Object, optionalBool, int, layer4TypeD]);
    layer3TypeC = new Tuple([int, bool, layer4TypeC]);
    layer3TypeB = new Tuple([optionalWild, int, bool, layer4TypeB]);
    layer3TypeA =
        new Tuple([double, optionalBool,int, int, layer4TypeA]);

    layer2TypeD =
        new Tuple([String, layer3TypeE, int, layer3TypeD]);
    layer2TypeC = new Tuple(
        [int, int, Object, optionalString, bool, layer3TypeC]);
    layer2TypeB =
        new Tuple([bool, optionalBool, String, int, layer3TypeB]);
    layer2TypeA = new Tuple([int, String, bool, layer3TypeA]);

    layer1TypeC = new Tuple([
      Object,
      String,
      bool,
      optionalWild,
      layer2TypeA,
      layer2TypeB
    ]);
    layer1TypeB =
        new Tuple([bool, double, Object, optionalString, layer2TypeC]);
    layer1TypeA =
        new Tuple([String, String, Object, int, double, bool, layer2TypeD]);

    layer0 = new Tuple([layer1TypeA, layer1TypeB, layer1TypeC, String, Tuple]);


    test('Should return completeTreeWithOptionals matches baseTree.', () {
      Tuple l1TA, l1TB, l1TC, l2TA, l2TB, l2TC, l2TD, l3TA, l3TB, l3TC, l3TD, l3TE, l4TA, l4TB, l4TC, l4TD, l4TE, l4TF, tup1, tup2, tup3;

      tup1 = new Tuple(['Anything', 'will work here', 934]);
      tup2 = new Tuple([9384, true, false, 23]);
      tup3 = new Tuple(['Anything will work', true, true, true]);
      l4TF = new Tuple([true, 'layer4TypeF String', 3902, 0.323, 232]);
      l4TE = new Tuple([32323,false,'layer4TypeE String',3928,12.23]);;
      l4TD = new Tuple([9384.027, 382 ,true, 'Sting for l4TD', 123]);
      l4TC = new Tuple([23, 834.23, 337, true, 'l4tc String']);
      l4TB = new Tuple(['String l4tB', 292, 384.016, 3993, false]);
      l4TA = new Tuple([false, 38494.01, true, true]);
      l3TE = new Tuple([l4TE, true, l4TF]);
      l3TD = new Tuple([tup2, 3434, false, 9384, l4TD]);
      l3TC = new Tuple([203,false,l4TC]);
      l3TB = new Tuple([tup1, 39, true, l4TB]);
      l3TA = new Tuple([931.002, true, 23423, 34, l4TA]);
      l2TD = new Tuple(['Message System String',l3TE,l3TD,728, l3TD]);
      l2TC = new Tuple([234,34,23.92, 'Optional String', true, l3TC]);
      l2TB = new Tuple([true, false, 'String for l2TB',23, l3TB]);
      l2TA = new Tuple([23, 'String for l2TA', false, l3TA]);
      l1TC = new Tuple(['l1TC object', 'Defined String', true, 'Anything not type checked', l2TA, l2TB]);
      l1TB = new Tuple([false, 9384.23, 'ObjectWild', 839, 9282.34, true, l2TC]);
      l1TA = new Tuple(['rockets', 'fountains', 'wild object string', 2829, 92.34, false,  l2TD]);
      Tuple subjectRoot = new Tuple([l1TA, l1TB, l1TC, 'String of words', tup3]);

      print(subjectRoot[0].runtimeType);
      expect(
          isTupleTypeMatched(subjectRoot, layer0),
          isTrue);
    });
  });
}
