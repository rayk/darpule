import 'package:test/test.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';

main() {

  /// Embedded Types
  List list1 = [34, 9.3, 'Home', true, 'bears'];
  Map map1 = {'k0':'A', 'k1':12, 'k3':30.34, 'k4':true};
  Tuple tuple1 = new Tuple(['Arc', false, 93.3]);
  RegExp reg1 = new RegExp(r'\W+');
  bool rangeCheck(int number) => number > 0 && number < 100 ? true : false;


  Tuple criteriaA = new Tuple([bool, String, int, String, Object, int]);
  Tuple pass = new Tuple([true, 'water', 393, 'more', true, 34]);
  Tuple subjectA_x0 =
  new Tuple([String, int, bool, double, List, Map, Tuple, RegExp]);
  Tuple subjectA_x1 = new Tuple(['Hello', 34, true, 0.3, list1, map1, tuple1, reg1]);
  Tuple subjectA_f_i =
  new Tuple(['Hello', 34, true, 37, 93.2, true, 20, 192, true, false]);
  Tuple subjectA_f_o = new Tuple([reg1, tuple1, map1, list1, 0.3, true, 34, 'Hello']);
  Tuple subjectA_f_t =
  new Tuple(['String', 'dog', true, 1, 'list', reg1, map1, tuple1]);
  Tuple subjectA_f_p = new Tuple(['String', 1, true, 0.2, list1, map1, tuple1, 232]);
  Tuple subjectA_f_h = new Tuple([123, 23, true, 03.3, list1, map1, tuple1, reg1]);
  Tuple subjectA_f_e = new Tuple([123, 23, true, 03.3, list1, map1, tuple1, 34]);

  test('Should pass simple type match.', () {
    Function criteriaAMatcher = tupleMatcher(criteriaA);
    expect(criteriaAMatcher(pass), isTrue);
  });
}
