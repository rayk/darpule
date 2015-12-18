library darpule.test.matchers.criteria;

import 'package:darpule/src/matchers/criteria/criteria_matcher.dart';
import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:quiver_optional/optional.dart';

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
      List result = viableSubjectLengths(criteria);
      expect(result, orderedEquals([5,6,7,8,9,10,11,12,13]));

    });
  });

  group('Includes:\t', () {
    test('Should n for all mandatory elements:', () {
      Tuple criteria = new Tuple([bool, int, String, int]);
      List result = viableSubjectLengths(criteria);
     expect(result, orderedEquals([4]));
    });
  });
}
