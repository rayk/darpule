library darpule.test.matchers.criteria;

import 'package:darpule/src/matchers/critieria/critieria_matcher.dart';
import 'package:darpule/tuple.dart';
import 'package:test/test.dart';

main() {
  group('Optionals:\t', () {
    test('Should count number of elements until the next manadatory.', () {
      Tuple criteria = new Tuple([
        new Optional.of(int),
        int,
        int,
        new Optional.of(int),
        int,
        new Optional.of(int),
        new Optional.of(int),
        int,
        new Optional.of(int),
        new Optional.of(int),
        bool,
        new Optional.of(bool),
        new Optional.of(int)
      ]);
      Map result = sequenceElements(criteria);
      print(result);
      expect(result.length, equals(criteria.length));
    });
  });

  group('Includes:\t', () {
    test('Should n for all mandatory elements:', () {
      Tuple criteria = new Tuple([bool, int, String, int]);
      Map result = sequenceElements(criteria);
      print(result);
    });
  });
}
