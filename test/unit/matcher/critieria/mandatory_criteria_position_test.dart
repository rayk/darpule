library darpule.test.matchers.criteria.positions;

import 'package:darpule/src/matchers/criteria/criteria_matcher.dart';
import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:quiver_optional/optional.dart';

main() {
  group('Position of manadatory items: \t', () {
    test('Should exclude the optionals.',(){
      Tuple criteria = new Tuple(
          [bool, int, new Optional.of(int), String, new Optional.of(bool)]);

      List mans = mandatoryCriterionPositions(criteria);
      expect(mans, orderedEquals([0, 1, 3]));
    });

    test('Should works without optionals.', ()  {
      Tuple criteria = new Tuple([int, bool, bool, String, Map, Tuple]);
      List mans = mandatoryCriterionPositions(criteria);
      expect(mans, orderedEquals([0,1,2,3,4,5]));
    });

  });
}
