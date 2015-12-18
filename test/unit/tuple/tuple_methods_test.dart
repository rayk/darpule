library darpule.test.tuple.methods;

import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:darpule/predicate.dart';



main(){

  group('intoSplice:\t',(){
    test('Should splice in the second tuple before boolean value.', (){

      Tuple partReading1 = new Tuple([384, 920, true, 'Sti-834']);
      Tuple partReading2 = new Tuple([3943,8283,0293,2833]);

      int partReading1Hash = partReading1.hashCode;
      int partReading2Hash = partReading2.hashCode;

      Tuple completeReading = partReading1.intoSplice(partReading2, isValueBoolean);

      expect(completeReading is Tuple, isTrue);
      expect(completeReading.length, equals(partReading1.length + 1));
      expect(identical(completeReading[2], partReading2), isFalse);
      expect(completeReading[2] == partReading2, isTrue);
      expect(identical(partReading1, completeReading), isFalse);
      expect(partReading1Hash == partReading1.hashCode, isTrue);
      expect(partReading2Hash == partReading2.hashCode, isTrue);

    });

    test('Should splice in the second tuple after the boolean value.',(){
      Tuple partReading1 = new Tuple([384, 920, true, 'Sti-834']);
      Tuple partReading2 = new Tuple([3943, 8283, 0293, 2833]);

      int partReading1Hash = partReading1.hashCode;
      int partReading2Hash = partReading2.hashCode;

      Tuple completeReading = partReading1.intoSplice(
          partReading2, isValueBoolean, before: false);

      expect(completeReading is Tuple, isTrue);
      expect(completeReading.length, equals(partReading1.length + 1));
      expect(identical(completeReading[3], partReading2), isFalse);
      expect(completeReading[3] == partReading2, isTrue);
      expect(identical(partReading1, completeReading), isFalse);
      expect(partReading1Hash == partReading1.hashCode, isTrue);
      expect(partReading2Hash == partReading2.hashCode, isTrue);
    });


  });

  group('concatWith:\t',(){
    test('Should append the content of the passed in tuple.', () async {
      Tuple base = new Tuple(['dog', false,  3923.23, 'waterfalls']);
      Tuple appendTuple = new Tuple([true, 'rain', false, ['list', 'of', 'Strings']]);

      Tuple longerTuple = base.concatWith(appendTuple);

      expect(longerTuple.type == TupleType.octuple, isTrue);
      expect(longerTuple[0], equals('dog'));
      expect(longerTuple[6], equals(false));
      expect(longerTuple[7], orderedEquals(['list', 'of', 'Strings']));
      expect(base != longerTuple, isTrue);
      expect(appendTuple != longerTuple, isTrue);


    });

  });


}