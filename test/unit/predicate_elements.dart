library darpule.test.predicate.elements;

import 'package:darpule/src/predicates/base.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';
import 'package:test/test.dart';

main() {
  group('isElementLiteral: \t', () {
    test('Should return ture when element contains a string.', () {
      expect(isElementLiteral('Hello World'), isTrue);
      expect(isElementLiteral(29034), isTrue);
      expect(isElementLiteral(true), isTrue);
      expect(isElementLiteral(93.39), isTrue);
      expect(isElementLiteral(5 + 2), isTrue);
    });

    test('Should return false when a type is passed in.', () {
      expect(isElementLiteral(String), isFalse);
    });
  });

  group('isElementType:    \t', () {
    test('Should return true when element contains a type.', () {
      expect(isElementType(String), isTrue);
      expect(isElementType(int), isTrue);
      expect(isElementType(bool), isTrue);
      expect(isElementType(double), isTrue);
      expect(isElementType(Object), isTrue);
      expect(isElementType(Type), isTrue);
      expect(isElementType(Map), isTrue);
      expect(isElementType(List), isTrue);
      expect(isElementType(Symbol), isTrue);
      expect(isElementType(Function), isTrue);
      expect(isElementType(Tuple), isTrue);
      expect(isElementType(Pattern), isTrue);
      expect(isElementType(Set), isTrue);
    });

    test('Should return false when element does not contain type.', () {
      expect(isElementType('Hello World'), isFalse);
      expect(isElementType(203984), isFalse);
      expect(isElementType(new Tuple([])), isFalse);
      expect(isElementType(new DateTime.now()), isFalse);
    });
  });

  group('isElementTuple:    \t', () {
    test('Should return true when element is a tuple.', () {
      expect(isElementTuple(new Tuple([])), isTrue);
    });

    test('Should return false when element is not tuple.', () {
      expect(isElementTuple(String), isFalse);
      expect(isElementTuple(Null), isFalse);
    });
  });

  group('isElementOptional:  \t', () {
    test('Should return true if the element is any varation of optional.', () {
      expect(isElementOptional(new Optional.absent()), isTrue);
      expect(isElementOptional(new Optional.absent()), isTrue);
      expect(isElementOptional(new Optional.of('Hello Word')), isTrue);
    });

    test('Should return false is the elemenet is not an optional.', () {
      expect(isElementOptional(String), isFalse);
      expect(isElementOptional(Null), isFalse);
    });
  });

  group('isElementPattern: \t', () {
    test("Should return true if the element contains a RegExp pattern.", () {
      RegExp regex1 = new RegExp(r"(\w+)");
      expect(isElementPattern(regex1), isTrue);
    });

    test('Should return false if the element does not contain a pattern.', () {
      expect(isElementPattern('hello world'), isFalse);
    });
  });

  group('isOptionalElementTyped: \t', () {
    test('Should return true if the optional contains a type.', () {
      expect(isOptionalElementTyped(new Optional.of(String)), isTrue);
      expect(isOptionalElementTyped(new Optional.of(Tuple)), isTrue);
    });

    test('Should return false is the optional contains a literial.', () {
      expect(isOptionalElementTyped(new Optional.of('Hello World')), isFalse);
      expect(isOptionalElementTyped(new Optional.absent()), isFalse);
    });
  });

  group('isOptionalElementValued: \t', () {
    test('Should return true if the optional contains a literial value', () {
      expect(isOptionalElementValued(new Optional.of(34343)), isTrue);
    });

    test('Should return false fo optional without literial value', () {
      expect(isOptionalElementValued(new Optional.of(int)), isFalse);
      expect(isOptionalElementValued(new Optional.absent()), isFalse);
    });
  });

  group('isOptionalElementWild: \t', () {
    test('Should return true if the optional is absent any type or value.', () {
      expect(isOptionalElementWild(new Optional.absent()), isTrue);
    });

    test('Should return false if the optional specifies type or value.', () {
      expect(isOptionalElementWild(new Optional.of(bool)), isFalse);
      expect(isOptionalElementWild(new Optional.of(Object)), isFalse);
    });
  });

  group('isOptionalElementFunction:\t', () {
    test('Should return true if the optional specifies a function', () {
      bool rangeCheck(int value) => value > 0 && value < 100 ? true : false;
      expect(isOptionalElementFunction(new Optional.of(rangeCheck)), isTrue);
    });
  });

  group('isElementFunction: \t', () {
    test('Should return true if element is a function.', () {
      expect(isElementFunction(isElementType), isTrue);
    });

    test('Should return false if element is not a funciton.', () {
      expect(isElementFunction(bool), isFalse);
    });
  });

  group('areElementsTypeMatched: \t', () {
    test('Should return true when the type of both elements are the same.', () {
      expect(areElementsTypeMatched('this is a string', 'so is this'), isTrue);
      expect(areElementsTypeMatched(bool, String), isTrue);
      expect(areElementsTypeMatched(true, false), isTrue);
    });

    test('Should return false when the types are not the same.', () {
      expect(areElementsTypeMatched(bool, true), isFalse);
      expect(areElementsTypeMatched(true, 'Hello World'), isFalse);
      expect(areElementsTypeMatched(3434, int), isFalse);
    });
  });

  group('areElementsOfType: \t', () {
    test('Should return true when the elements are the type specified', () {
      expect(areElementsOfType(bool, [true, false, true]), isTrue);
      expect(areElementsOfType(String, ['Hello World']), isTrue);
    });

    test('Should return false when one element does not match type.', () {
      expect(areElementsOfType(int, [902, 202, 383, 38.2]), isFalse);
    });
  });

  group('areElementsValueMatched: \t', () {
    test('Should return true if elements same literal value.', () {
      expect(areElementsLiteralMatched('walking dead', 'walking dead'), isTrue);
    });

    test('Should return false if elements not literally same.', () {
      expect(areElementsLiteralMatched('kl', 'sky'), isFalse);
    });
  });

  group('areElementsFunctionallyTrue: \t', () {
    test('Should return true of the function returns true.', () {
      bool rangeCheck(int value) => value > 0 && value < 100 ? true : false;
      expect(areElementsFunctionallyTrue(rangeCheck, 52), isTrue);
    });

    test('Should return false if the function returns false.', () {
      bool rangeCheck(int value) => value > 0 && value < 100 ? true : false;
      expect(areElementsFunctionallyTrue(rangeCheck, 150), isFalse);
    });

    test('Should return errors.', () {
      bool rangeCheck(int value) => throw new UnimplementedError('bad luck');
      expect(() => areElementsFunctionallyTrue(rangeCheck, 25),
          throwsUnimplementedError);
    });
  });

  group('areElementsFunctionallyMatched: \t', () {
    bool rangeCheck(int value) => value > 0 && value < 100 ? true : false;
    bool rangerChecker(int value) => value > 20 && value < 80 ? true : false;

    var inVar = rangeCheck;

    test('Should return true for the same function.', () {
      expect(areElementsFunctionallyMatched(rangeCheck, rangeCheck), isTrue);
      expect(areElementsFunctionallyMatched(rangeCheck, inVar), isTrue);
    });

    test('Should return false for different funcitons.', () {
      expect(
          areElementsFunctionallyMatched(rangeCheck, rangerChecker), isFalse);
    });
  });

  group('areElementsOptionallyMatched:\t', () {
    test('Should return true when element is of type specified.', () {
      expect(
          areElementsOptionallyMatched(new Optional.of(String), 'Hello Word'),
          isTrue);
      expect(areElementsOptionallyMatched(new Optional.absent(), 343), isTrue);
    });

    test('Should return true when element is a value match.', () {
      expect(areElementsOptionallyMatched(new Optional.of('horse'), 'horse'),
          isTrue);
    });

    test('Should return false when element is not of specified type.', () {
      expect(areElementsOptionallyMatched(new Optional.of(bool), 'hello'),
          isFalse);
      expect(
          areElementsOptionallyMatched(new Optional.of(Object), true), isFalse);
    });

    test('Should execute function and return functions results.', () {
      bool rangeCheck(int value) => value > 0 && value < 100 ? true : false;
      expect(areElementsOptionallyMatched(new Optional.of(rangeCheck), 50),
          isTrue);
      expect(areElementsOptionallyMatched(new Optional.of(rangeCheck), 150),
          isFalse);
    });

    test('Should throw error when frist agrument is not Optional', () {
      expect(() => areElementsOptionallyMatched(String, 'hello'),
          throwsArgumentError);
    });
  });

  group('areElementsInCollectionMatched:\t', () {
    test('Should return true if two list are the same.', () {
      List list1 = ['Cat', false, 303, 93.2, Tuple, String];
      List list2 = ['Cat', false, 303, 93.2, Tuple, String];
      expect(areElementsInCollectionMatched(list1, list2), isTrue);
    });

    test('Should return false when two list are not the same',(){
      List list1 = ['Cat', true, 303, 93.2, Tuple, String, 'rabbit'];
      List list2 = ['Cat', false, 303, 93.2, Tuple, String];
      expect(areElementsInCollectionMatched(list1, list2), isFalse);
    });

    test('Should return true if two maps are the same.',(){
       Map map1 = {'key1': true, 'key2': 30430, 'key3': 'Just a String'};
       Map map2 = {'key1': true, 'key2': 30430, 'key3': 'Just a String'};
      expect(areElementsInCollectionMatched(map1, map2), isTrue);
    });

    test('Should return false if two maps are not the same.',(){
      Map map1 = {'key1': true, 'key2': 30430, 'key3': 'Just a String', 'key4': 0.232};
      Map map2 = {'key1': true, 'key2': 30430, 'key3': 'Just a String'};
      expect(areElementsInCollectionMatched(map1, map2), isFalse);
    });

    test('Should return true if two sets are the same.',(){
       Set set1 = new Set.from(['dog', 'cat', 930, String, 'horse', true]);
       Set set2 = new Set.from(['dog', 'cat', 930, String, 'horse', true]);
      expect(areElementsInCollectionMatched(set1, set2), isTrue);
    });

    test('Should return false if two sets are not the same.',(){
      Set set1 = new Set.from(['dog', 'cat', 232, String, 'horse', true]);
      Set set2 = new Set.from(['dog', 'cat', 930, int, 'horse', false]);
      expect(areElementsInCollectionMatched(set1, set2), isFalse);
    });

    test('Should return true if the values in a list match value in map.',(){
      List list1 = ['Cat', true, 303, 93.2, Tuple, String, 'rabbit'];
      Map map1 = {'key0': 'Cat', 'key1': true, 'key2': 303, 'key3': 93.2, 'key4': Tuple, 'key5': String, 'key6':'rabbit'};
      expect(areElementsInCollectionMatched(list1, map1), isTrue);
    });

    test('Should return true if map values match those in list.',(){
      List list1 = ['Cat', true, 303, 93.2, Tuple, String, 'rabbit'];
      Map map1 = {'key0': 'Cat', 'key1': true, 'key2': 303, 'key3': 93.2, 'key4': Tuple, 'key5': String, 'key6':'rabbit'};
      expect(areElementsInCollectionMatched(map1, list1), isTrue);
      expect(areElementsInCollectionMatched(list1, map1), isTrue);
    });

    test('Should return false if the values in list do not match map.',(){
      List list1 = ['Cat', true, 303, 93.2, Tuple];
      Map map1 = {'key0': 'Cat', 'key1': true, 'key2': 303, 'key3': 93.2, 'key4': Tuple, 'key5': String, 'key6':'rabbit'};
      expect(areElementsInCollectionMatched(list1, map1), isFalse);
      expect(areElementsInCollectionMatched(map1, list1), isFalse);
    });

    test('Should return true if the values in list do  match set.',(){
      List list1 = ['Cat', true, 303, 93.2, Tuple];
      Set set = new Set.from(list1);
      expect(areElementsInCollectionMatched(list1, set), isTrue);
      expect(areElementsInCollectionMatched(set, list1), isTrue);
    });

    test('Should return false if values in list do not match set.',(){
       List list = ['Cat', 'Cat', true, 39, false];
      Set set = new Set.from(list);
      expect(areElementsInCollectionMatched(list, set), isFalse);
      expect(areElementsInCollectionMatched(set, list), isFalse);
    });

    test('Should return true if value from map and set match.',(){
      Map map = {'k1': true, 'k2': 'Dog', 'k3':203094};
      Set set = new Set.from([true,'Dog', 203094]);
      expect(areElementsInCollectionMatched(map, set), isTrue);
      expect(areElementsInCollectionMatched(set, map), isTrue);
    });

    test('Should return false if value from map and set do not match.',(){
      Map map = {'k1': true, 'k2': 'Dog', 'k3':203094};
      Set set = new Set.from([false,'Dog', 203094]);
      expect(areElementsInCollectionMatched(map, set), isFalse);
      expect(areElementsInCollectionMatched(set, map), isFalse);
    });


  });
}
