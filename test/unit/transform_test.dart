library darpule.test.transfom;

import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_optional/optional.dart';
import 'package:test/test.dart';
import 'dart:async';

main() {
  group('Misused and Abuse:\t', () {
    test('Should return same tuple if criteria has no optionals', () async {
      Tuple criteria = new Tuple([String, bool, int]);
      Tuple subject = new Tuple(['Hello', true, 54]);
      injectMissingOptionals(criteria, subject).then((Tuple result) {
        expect(identical(subject, result), isTrue);
      });
    });

    test('Should return same tuple with present optional untouched.', () {
      Tuple criteria = new Tuple([int, String, new Optional.of(bool), double]);
      Tuple subject = new Tuple([30, 'String', true, 30.0]);
      expect(isMissingOptionalPossible(criteria, subject), isFalse);
      injectMissingOptionals(criteria, subject).then((Tuple result) {
        expect(identical(subject, result), isTrue);
      });
    });
  });

  group('One element insert:\t', () {
    test('Should return new tuple with an int inserted at the start.',
        () async {
      Tuple criteria = new Tuple([new Optional.of(int), String, bool]);
      Tuple subject = new Tuple(['Example String', false]);
      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.triple));
        expect(modSubject[0] is int, isTrue, reason: 'int ${modSubject[0]}');
        expect(modSubject[1] is String, isTrue, reason: 'string');
        expect(modSubject[2] is bool, isTrue, reason: 'bool');
      });
    });

    test('Should return new Tuple with bool as second element.', () async {
      Tuple criteria = new Tuple([String, new Optional.of(bool), String, int]);
      Tuple subject = new Tuple(['Example String', 'Another', 83]);
      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.quadruple));
        expect(modSubject[0] is String, isTrue);
        expect(modSubject[1] is bool, isTrue);
        expect(modSubject[2] is String, isTrue);
        expect(modSubject[3] is int, isTrue);
      });
    });

    test('Should return new Tuple with string as thrid position.', () async {
      Tuple criteria =
          new Tuple([bool, int, new Optional.of(String), int, int]);
      Tuple subject = new Tuple([true, 343, 34, 12]);
      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.quintuple));
        expect(modSubject[0] is bool, isTrue);
        expect(modSubject[1] is int, isTrue);
        expect(modSubject[2] is String, isTrue);
        expect(modSubject[3] is int, isTrue);
        expect(modSubject[4] is int, isTrue);
      });
    });

    test('Should return new Tuple with double in last position.', () async {
      Tuple criteria = new Tuple([bool, int, String, new Optional.of(double)]);
      Tuple subject = new Tuple([true, 343, 'Hello World']);
      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.quadruple));
        expect(modSubject[0] is bool, isTrue);
        expect(modSubject[1] is int, isTrue);
        expect(modSubject[2] is String, isTrue);
        expect(modSubject[3] is double, isTrue);
      });
    });

    test('Should return new Tuple when optional.absent is used.', () async {
      Tuple criteria = new Tuple([bool, int, String, new Optional.absent()]);
      Tuple subject = new Tuple([true, 343, 'Hello World']);
      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.quadruple));
        expect(modSubject[0] is bool, isTrue);
        expect(modSubject[1] is int, isTrue);
        expect(modSubject[2] is String, isTrue);
        expect(modSubject[3], isNotEmpty);
      });
    });

    test('Should return new Tuple with Optional is another Tuple.', () async {
      Tuple criteria = new Tuple([bool, int, String, new Optional.of(Tuple)]);
      Tuple subject = new Tuple([true, 343, 'Hello World']);
      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.quadruple));
        expect(modSubject[0] is bool, isTrue);
        expect(modSubject[1] is int, isTrue);
        expect(modSubject[2] is String, isTrue);
        expect(modSubject[3] is Tuple, isTrue);
      });
    });
  });

  group('Multi Element insert:\t', () {
    test('Should return tuple inject with multiple options.', () {
      Tuple criteria = new Tuple(
          [bool, new Optional.of(int), bool, new Optional.of(String)]);
      Tuple subject = new Tuple([true, false]);
      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.quadruple));
        expect(modSubject[0] is bool, isTrue);
        expect(modSubject[1] is int, isTrue);
        expect(modSubject[2] is bool, isTrue);
        expect(modSubject[3] is String, isTrue);
      });
    });

    test('Should return a tuple injected when each element is optional.', () {
      Tuple criteria = new Tuple([
        new Optional.of(int),
        new Optional.of(bool),
        new Optional.of(String),
        new Optional.of(double),
        new Optional.of(Tuple),
        new Optional.absent()
      ]);

      Tuple subject = new Tuple([]);

      injectMissingOptionals(criteria, subject).then((Tuple modSubject) {
        expect(identical(modSubject, subject), isFalse, reason: 'Not Modified');
        expect(modSubject.type, equals(TupleType.sextuple), reason: 'CountOff');
        expect(modSubject[0] is int, isTrue);
        expect(modSubject[1] is bool, isTrue);
        expect(modSubject[2] is String, isTrue);
        expect(modSubject[3] is double, isTrue);
        expect(modSubject[4] is Tuple, isTrue);
        expect(modSubject[5], isNotEmpty);
      });
    });
  });

  group('Some Optional Elements Present:\t', () {
    test('Should not inject and leave untouched.', () {
      Tuple criteria = new Tuple([int, String, new Optional.of(bool), double]);
      Tuple subject = new Tuple([30, 'String', true, 30.0]);
      expect(isMissingOptionalPossible(criteria, subject), isFalse);
    });

    test('Should not see this situation when injecting.', () {
      Tuple criteria =
          new Tuple([int, new Optional.of(int), new Optional.of(bool), String]);
      Tuple subject = new Tuple([23, 34, true, 'hello', 'goodnight']);
      expect(isMissingOptionalPossible(criteria, subject), isFalse);
    });

    test('Should only inject what is required to met tuple length.', () {
      // Required element[1] is a mismatch.
      Tuple criteria4 = new Tuple(
          [int, new Optional.of(String), bool, new Optional.of(int), int]);
      Tuple subject4 = new Tuple([34, true, true, 03]); // (1)
      injectMissingOptionals(criteria4, subject4).then((Tuple result) {
        expect(result.type, equals(TupleType.quintuple));
        expect(result[0] is int, isTrue);
        expect(result[1] is String, isTrue);
        expect(result[2] is bool, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is int, isTrue);
      });
    });

    test('Should not inject if the element already matches the optional type.',
        () {
      Tuple criteria1 = new Tuple(
          [int, new Optional.of(int), bool, new Optional.of(String), bool]);
      Tuple subject1 = new Tuple([34, 54, false, true]); // (1) _,_,_,*String
      injectMissingOptionals(criteria1, subject1).then((Tuple result) {
        expect(result.type, equals(TupleType.quintuple));
        expect(result[0] is int, isTrue, reason: 'int');
        expect(result[1] is int, isTrue, reason: 'int');
        expect(result[2] is bool, isTrue, reason: 'bool ${result[2]}');
        expect(result[3] is String, isTrue, reason: 'String');
        expect(result[4] is bool, isTrue, reason: 'bool');
      });
    });

    test('Should return tuple with only the missing optional injected.', () {
      Tuple criteria2 = new Tuple(
          [int, new Optional.of(int), int, String, new Optional.of(bool)]);
      Tuple subject2 = new Tuple([38, 03, 'Hello', true]); // (1) _,_,_,_,_
      injectMissingOptionals(criteria2, subject2).then((Tuple result) {
        expect(result.type, equals(TupleType.quintuple));
        expect(result[0] is int, isTrue, reason: 'int 0 ${result[0]}');
        expect(result[1] is int, isTrue, reason: 'int 1 ${result[1]}');
        expect(result[2] is int, isTrue, reason: 'int 2 ${result[2]}');
        expect(result[3] is String, isTrue, reason: 'String');
        expect(result[4] is bool, isTrue, reason: 'bool');
      });
    });

    test('Should replace two optional next to each other.', () {
      Tuple criteria3 = new Tuple(
          [String, new Optional.of(bool), new Optional.of(int), bool, int]);
      Tuple subject3 = new Tuple(['Hello', true, 93]); // (2) _,_,_,*int ...
      injectMissingOptionals(criteria3, subject3).then((Tuple result) {
        expect(result.type, equals(TupleType.quintuple));
        expect(result[0] is String, isTrue);
        expect(result[1] is bool, isTrue);
        expect(result[2] is int, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is int, isTrue);
      });
    });

    test('Should inject all three optionals.', () {
      Tuple criteria5 = new Tuple([
        new Optional.of(int),
        String,
        bool,
        new Optional.of(bool),
        new Optional.of(int)
      ]);
      Tuple subject5 = new Tuple(['hello', false]); // (3)  *int,_,_,*bool,*int
      injectMissingOptionals(criteria5, subject5).then((Tuple result) {
        expect(result.type, equals(TupleType.quintuple));
        expect(result[0] is int, isTrue, reason: 'Not Int');
        expect(result[1] is String, isTrue, reason: 'Not String');
        expect(result[2] is bool, isTrue, reason: 'Not bool 1');
        expect(result[3] is bool, isTrue, reason: 'Not bool 2');
        expect(result[4] is int, isTrue, reason: 'Not int');
      });
    });

    test('Should only inject of the options and deregards the other', () {
      Tuple criteria6 = new Tuple([
        String,
        new Optional.of(int),
        new Optional.of(int),
        bool,
        int,
        new Optional.of(int)
      ]);

      Tuple subject6a =
          new Tuple(['String1', 54, true, 34, 54]); // 1 to made check right

      injectMissingOptionals(criteria6, subject6a).then((Tuple result) {
        expect(result.type, equals(TupleType.sextuple));
        expect(result[0] is String, isTrue);
        expect(result[1] is int, isTrue);
        expect(result[2] is int, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is int, isTrue);
        expect(result[5] is int, isTrue);
      });
    });

    test('Should inject all three optionals', () {
      Tuple criteria6 = new Tuple([
        String,
        new Optional.of(int),
        new Optional.of(int),
        bool,
        int,
        new Optional.of(int)
      ]);
      Tuple subject6b =
          new Tuple(['String1', true, 34]); // 3 to make - all to assigned

      injectMissingOptionals(criteria6, subject6b).then((Tuple result) {
        expect(result.type, equals(TupleType.sextuple));
        expect(result[0] is String, isTrue);
        expect(result[1] is int, isTrue);
        expect(result[2] is int, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is int, isTrue);
        expect(result[5] is int, isTrue);
      });
    });

    test('*** Should only inject two of the optionals.', () {
      Tuple criteria6 = new Tuple([
        String,
        new Optional.of(int),
        new Optional.of(int),
        bool,
        int,
        new Optional.of(int)
      ]);
      Tuple subject6c =
          new Tuple(['string', true, 34, 92]); // 2 to make - right check
      injectMissingOptionals(criteria6, subject6c).then((Tuple result) {
        expect(result.type, equals(TupleType.sextuple));
        expect(result[0] is String, isTrue);
        expect(result[1] is int, isTrue);
        expect(result[2] is int, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is int, isTrue);
        expect(result[5] is int, isTrue);
      });
    });

    test('Should only..', () {
      Tuple criteria6 = new Tuple([
        String,
        new Optional.of(int),
        new Optional.of(int),
        bool,
        int,
        new Optional.of(int)
      ]);
      Tuple subject6d =
          new Tuple(['String', 39, true]); //2 to make, right check
      injectMissingOptionals(criteria6, subject6d).then((Tuple result) {
        expect(result.type, equals(TupleType.sextuple));
        expect(result[0] is String, isTrue, reason: 'String');
        expect(result[1] is int, isTrue, reason: 'int');
        expect(result[2] is int, isTrue, reason: 'int');
        expect(result[3] is bool, isTrue, reason: 'bool ${result[3]}');
        expect(result[4] is int, isTrue, reason: 'int');
        expect(result[5] is int, isTrue, reason: 'int');
      });
    });

    test('Should insert five..', () {
      Tuple criteria7 = new Tuple([
        new Optional.of(String),
        int,
        new Optional.of(bool),
        new Optional.of(bool),
        bool,
        new Optional.of(int),
        bool,
        String,
        new Optional.of(String)
      ]);
      Tuple subject7a = new Tuple([12, false, false, 'String']); // 5 to make

      injectMissingOptionals(criteria7, subject7a).then((Tuple result) {
        expect(result.type, equals(TupleType.nonuple));
        expect(result[0] is String, isTrue, reason: 'String');
        expect(result[1] is int, isTrue);
        expect(result[2] is bool, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is bool, isTrue);
        expect(result[5] is int, isTrue);
        expect(result[6] is bool, isTrue);
        expect(result[7] is String, isTrue);
        expect(result[8] is String, isTrue);
      });
    });

    test('Should insert three..', () {
      Tuple criteria7 = new Tuple([
        new Optional.of(String),
        int,
        new Optional.of(bool),
        new Optional.of(bool),
        bool,
        new Optional.of(int),
        bool,
        String,
        new Optional.of(String)
      ]);
      Tuple subject7b =
          new Tuple(['string', 38, true, false, false, 'String']); // 3
      injectMissingOptionals(criteria7, subject7b).then((Tuple result) {
        expect(result.type, equals(TupleType.nonuple));
        expect(result[0] is String, isTrue, reason: 'String');
        expect(result[1] is int, isTrue);
        expect(result[2] is bool, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is bool, isTrue);
        expect(result[5] is int, isTrue);
        expect(result[6] is bool, isTrue);
        expect(result[7] is String, isTrue);
        expect(result[8] is String, isTrue);
      });
    });

    test('Should insert three..', (){
      Tuple criteria7 = new Tuple([
        new Optional.of(String),
        int,
        new Optional.of(bool),
        new Optional.of(bool),
        bool,
        new Optional.of(int),
        bool,
        String,
        new Optional.of(String)
      ]);
      Tuple subject7c =
      new Tuple(['String', 93, true, true, 'string2', 'String3']); // 3
      injectMissingOptionals(criteria7, subject7c).then((Tuple result) {
        expect(result.type, equals(TupleType.nonuple));
        expect(result[0] is String, isTrue, reason: 'String');
        expect(result[1] is int, isTrue);
        expect(result[2] is bool, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is bool, isTrue);
        expect(result[5] is int, isTrue);
        expect(result[6] is bool, isTrue);
        expect(result[7] is String, isTrue);
        expect(result[8] is String, isTrue);
      });
    });

    test('Should insert 4...', (){
      Tuple criteria7 = new Tuple([
        new Optional.of(String),
        int,
        new Optional.of(bool),
        new Optional.of(bool),
        bool,
        new Optional.of(int),
        bool,
        String,
        new Optional.of(String)
      ]);
      Tuple subject7d = new Tuple([39, false, 349, true, 'String']); // 4
      injectMissingOptionals(criteria7, subject7d).then((Tuple result) {
        expect(result.type, equals(TupleType.nonuple));
        expect(result[0] is String, isTrue, reason: 'String');
        expect(result[1] is int, isTrue);
        expect(result[2] is bool, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is bool, isTrue);
        expect(result[5] is int, isTrue);
        expect(result[6] is bool, isTrue);
        expect(result[7] is String, isTrue);
        expect(result[8] is String, isTrue);
      });
    });

    test('Should insert 4...',(){
      Tuple criteria7 = new Tuple([
        new Optional.of(String),
        int,
        new Optional.of(bool),
        new Optional.of(bool),
        bool,
        new Optional.of(int),
        bool,
        String,
        new Optional.of(String)
      ]);
      Tuple subject7e =
      new Tuple([39, true, 'error wrong type', false, 'Required string']); //4
      injectMissingOptionals(criteria7, subject7e).then((Tuple result){
        expect(result.type, equals(TupleType.nonuple));
        expect(result[0] is String, isTrue, reason: 'String');
        expect(result[1] is int, isTrue);
        expect(result[2] is bool, isTrue);
        expect(result[3] is bool, isTrue);
        expect(result[4] is bool, isTrue);
        expect(result[5] is int, isTrue);
        expect(result[6] is bool, isTrue);
        expect(result[7] is String, isTrue);
        expect(result[8] is String, isTrue);
      });
    });

  });
}
