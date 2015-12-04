import 'package:test/test.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';

main() {

  test('*** Should replace two optional next to each other.B', () {
    Tuple criteria3 = new Tuple(
        [String, new Optional.of(bool), new Optional.of(int), bool, int]);
    Tuple subject3 = new Tuple(['Hello', true, 93]); // (2) _,_,_,*int ...
    injectMissingOptionals(criteria3, subject3).then((Tuple result) {
      print(result);
      expect(result.type, equals(TupleType.quintuple));
      expect(result[0] is String, isTrue);
      expect(result[1] is bool, isTrue);
      expect(result[2] is int, isTrue);
      expect(result[3] is bool, isTrue);
      expect(result[4] is int, isTrue);
    });
  });


}
