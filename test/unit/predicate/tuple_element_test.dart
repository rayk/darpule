library darpule.test.predicate.elements;

import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:quiver_optional/optional.dart';

main() {
  group('isCollectionList:      \t', () {
    List list1 = new List();

    test("Should return true when a collection is an instance of List.", () {
      expect(isCollectionValueList(list1), isTrue);
      expect(isCollectionValueList(new Tuple([])), isTrue);
    });

    test("Should return false for other collections.", () {
      expect(isCollectionValueList(new Map()), isFalse);
      expect(isCollectionValueList(new Set()), isFalse);
      expect(isCollectionValueList(List), isFalse);
    });
  });

  group('isCollectionMap:       \t', () {
    test('Should return true when a collection is an instance of Map.', () {
      expect(isCollectionValueMap(new Map()), isTrue);
    });

    test('Should return false for other collections.', () {
      expect(isCollectionValueMap(new List()), isFalse);
      expect(isCollectionValueMap(new Set()), isFalse);
      expect(isCollectionValueMap(new Tuple([])), isFalse);
      expect(isCollectionValueMap(Map), isFalse);
    });
  });

  group('isCollectionSet:       \t', () {
    test('Should return true when a collection is an of set.', () {
      expect(isCollectionValueSet(new Set()), isTrue);
    });

    test('Should return false when for other collections.', () {
      expect(isCollectionValueSet(new List()), isFalse);
      expect(isCollectionValueSet(new Map()), isFalse);
      expect(isCollectionValueMap(Map), isFalse);
    });
  });

  group('isFunction:            \t', () {
    calRange(int x) => x * 10;
    Function calRgn = calRange;

    test('Should return true for Functions.', () {
      expect(isFunction(Function), isFalse);
      expect(isFunction(calRgn), isTrue);
    });

    test('Should return false for values and types.', () {
      expect(isFunction(String), isFalse);
      expect(isFunction(bool), isFalse);
      expect(isFunction(new Optional.of(Function)), isFalse);
    });
  });



  group('isOptionalValued:      \t', () {
    test('Should return true when the optional specified a value', () {
      expect(isOptionalValued(new Optional.of('Hello World')), isTrue);
    });

    test('Should return false when a value is not specified', () {
      expect(isOptionalValued(new Optional.of(String)), isFalse);
      expect(isOptionalValued(Optional), isFalse);
    });
  });
  group('isOptionalWild:        \t', () {
    test('Should return true when the optional is wild.', () {
      expect(isOptionalWild(Optional), isTrue);
      expect(isOptionalWild(new Optional.absent()), isTrue);
    });

    test('Should return false when the optional is not wild.', () {
      expect(isOptionalWild(new Optional.of(String)), isFalse);
      expect(isOptionalWild(new Optional.of('Hello World')), isFalse);
    });
  });

  group('isPattern:             \t', () {
    test('Should return true for RegExp patterns.', () {
      expect(isPattern(new RegExp('')), isTrue);
    });
  });

  group('isType:                 \t', () {
    test('Should return true when element contains a type.', () {
      expect(isAType(String), isTrue);
      expect(isAType(int), isTrue);
      expect(isAType(bool), isTrue);
      expect(isAType(double), isTrue);
      expect(isAType(Tuple), isTrue);
      expect(isAType(Function), isTrue);
      expect(isAType(Optional), isTrue);
    });

    test('Should return false when element does not contain type.', () {
      expect(isAType('Hello World'), isFalse);
      expect(isAType(203984), isFalse);
      expect(isAType(new Tuple([])), isFalse);
      expect(isAType(new DateTime.now()), isFalse);
      expect(isAType(new Optional.absent()), isFalse);
    });
  });

  group('isTypeCollection:       \t', () {
    test('Should return true if the element a collection type.', () {
      expect(isTypeCollection(List), isTrue);
      expect(isTypeCollection(Set), isTrue);
      expect(isTypeCollection(Map), isTrue);
      expect(isTypeCollection(Tuple), isFalse);
    });
  });

  group('isTypeFunction:        \t', () {
    test('Should return true when the type is specified as function.', () {
      expect(isTypeFunction(Function), isTrue);
    });

    test('Should return false when the type is not a function.', () {
      expect(isTypeFunction(String), isFalse);
    });
  });

  group('isTypeOptional:        \t', () {
    test('Should return true if the type or instance is used.', () {
      expect(isTypeOptional(Optional), isFalse);
      expect(isTypeOptional(new Optional.absent()), isFalse);
      expect(isTypeOptional('Optional'), isFalse);
      expect(isTypeOptional(String), isFalse);
      expect(isTypeOptional(new Optional.of(int)), isTrue);
      expect(isTypeOptional(new Optional.of(bool)), isTrue);
      expect(isTypeOptional(new Optional.of('Hello World')), isFalse);
    });
  });

  group('isTypeWildOptionally:   \t',(){
     test('Should return true when a type is contain in the optional',(){
       expect(isTypeWildOptionally(new Optional.of(Type)), isTrue);
       expect(isTypeWildOptionally(new Optional.of(String)), isFalse);
       expect(isTypeWildOptionally(new Optional.absent()), isFalse);

     });
  });

  group('isTypeWildMandartory:  \t',(){
     test('Should return when TYPE is used',(){
       expect(isTypeWildMandatory(Type), isTrue);
       expect(isTypeWildMandatory(String), isFalse);
       expect(isTypeWildMandatory(Object), isFalse);
       expect(isTypeWildMandatory(Optional), isFalse);
     });
  });

  group('isValueOptional:       \t', () {
    test('Should return true for an instance of optional with value', () {
      expect(isValueOptional(new Optional.of('hello')), isTrue);
      expect(isValueOptional(new Optional.of(String)), isFalse);
      expect(isValueOptional(new Optional.absent()), isFalse);
    });
  });

  group('isValueWildOptionally:  \t', () {
    test('Should return true for an instance of option without value', () {
      expect(isValueWildOptionally(new Optional.absent()), isFalse);
      expect(isValueWildOptionally(new Optional.of(Object)), isTrue);
    });
  });

  group('isValueWildMandatory:  \t', () {
    test('Should return true for an instance of optional with.', () {
      expect(isValueWildMandatory(Object), isTrue);
      expect(isValueWildMandatory(Optional), isFalse);
      expect(isValueWildMandatory(Type), isFalse);
    });
  });

  group('isTypeTuple:            \t', () {
    test('Should return true on Tuple only', () {
      expect(isTypeTuple(Tuple), isTrue);
      expect(isTypeTuple(String), isFalse);
    });
  });


  group('isValue:             \t', () {
    calRange(int x) => x * 10;
    Function calRgn = calRange;

    test('Should return true for literials.', () {
      expect(isValue('hello World'), isTrue);
      expect(isValue(new Tuple([])), isTrue);
      expect(isValue(calRange), isTrue);
      expect(isValue(calRgn), isTrue);
      expect(isValue(new RegExp('')), isTrue);
    });

    test('Should return false for types.', () {
      expect(isValue(String), isFalse);
      expect(isValue(Tuple), isFalse);
      expect(isValue(Function), isFalse);
    });
  });

  group('isValueCollection:      \t', () {
    List list = new List();
    Map map = new Map();
    Set set = new Set();
    Tuple tuple = new Tuple([true, true]);

    test('Should return true when the items is any kind of collection.', () {
      expect(isValueCollection(list), isTrue);
      expect(isValueCollection(map), isTrue);
      expect(isValueCollection(set), isTrue);
      expect(isValueCollection(tuple), isTrue);
      expect(isValueCollection(Tuple), isFalse);
    });
  });

  group('isValueTuple:          \t', () {
    Tuple tuple = new Tuple([true, false]);
    List list = new List();
    test('Should return true when the items is an instance of a Tuple.', () {
      expect(isValueTuple(tuple), isTrue);
      expect(isValueTuple(list), isFalse);
      expect(isValueTuple(Tuple), isFalse);
    });
  });

  group('isValueBoolean:        \t',(){
    test('Should return true when the value is a true or false.', () {
      expect(isValueBoolean(true), isTrue);
      expect(isValueBoolean(false), isTrue);
      expect(isValueBoolean(null), isFalse);
      expect(isValueBoolean(bool), isFalse);
      expect(isValueBoolean('true'), isFalse);
    });
  });

  group('isValueRunnable:        \t', () {
    calRange(int x) => x * 10;
    ;
    test('Should return true for executables.', () {
      expect(isValueRunnable(calRange), isTrue);
      expect(isValueRunnable(new RegExp('')), isTrue);
    });
  });
}
