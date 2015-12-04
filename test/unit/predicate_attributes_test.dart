library darpule.test.predicate.attribute;

import 'package:darpule/src/predicates/base.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';
import 'package:test/test.dart';

main() {
  group('isOptionalPresent:\t', () {
    test('Should return true when there optional with absent value present.',
        () {
      Tuple testTuple = new Tuple([String, bool, new Optional.absent()]);
      expect(isOptionalPresent(testTuple), isTrue);
    });

    test('Should return true when optional with value is present.', () {
      Tuple testTuple = new Tuple([bool, String, int, new Optional.of(int)]);
      expect(isOptionalPresent(testTuple), isTrue);
    });

    test('Should return true when there are many optionals.', () {
      Tuple testTuple =
          new Tuple([new Optional.of(int), new Optional.absent()]);
      expect(isOptionalPresent(testTuple), isTrue);
    });

    test('Should return false when optional is not present.', () {
      Tuple testTuple = new Tuple([bool, int, double, new Tuple([])]);
      expect(isOptionalPresent(testTuple), isFalse);
    });
  });

  group('isTupleLeaf:        \t',(){

    test('Should return false when another tuple is contained within.',(){
       Tuple testTuple, embeddedTuple;
      embeddedTuple = new Tuple (['String', 83, 0.00]);
      testTuple = new Tuple([bool, String, embeddedTuple, int]);
      expect(isTupleLeaf(testTuple), isFalse);
    });

    test('Should return true when there is not tuple contained within.',(){
       Tuple testTuple = new Tuple([int, bool, String, new DateTime.now()]);
      expect(isTupleLeaf(testTuple), isTrue);
    });



  });
}
