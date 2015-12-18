library darpule.test.matchers.criteria.search;

import 'package:darpule/src/matchers/criteria/criteria_matcher.dart';
import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:quiver_optional/optional.dart';

main() {
  group('Simple No Optional Match:\t', () {
    test('Should return true for positive and false for negative (2 Elements).',
        () {
      Tuple criteria = new Tuple([bool, String]);
      Tuple positiveSubject = new Tuple([true, 'part 53']);
      Tuple negativeSubject1 = new Tuple([true, true]);
      Tuple negativeSubject2 = new Tuple([true, 823, 938, true, false]);

      Map matrix = generateMatchMatrix(criteria);
      bool positiveResult = subjectMatchesCriteria(matrix, positiveSubject);
      expect(positiveResult, isTrue, reason: 'Should be true');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSubject1);
      expect(negativeResult1, isFalse, reason: 'Should be false');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSubject2);
      expect(negativeResult2, isFalse, reason: 'Shold be false');
    });

    test('Should return true for positive and false for negative (3 Elements).',
        () {
      Tuple criteria = new Tuple([bool, int, String]);
      Tuple positiveSubject = new Tuple([true, 343, 'hello']);
      Tuple negativeSubject = new Tuple([823, 938, true]);

      Map matrix = generateMatchMatrix(criteria);
      bool positiveResult = subjectMatchesCriteria(matrix, positiveSubject);
      expect(positiveResult, isTrue,
          reason: 'This have been a positive result');

      bool negativeResult = subjectMatchesCriteria(matrix, negativeSubject);
      expect(negativeResult, isFalse, reason: 'Should be False');
    });

    test('Should return true for positive and false for negative (4 Elements).',
        () {
      Tuple criteria = new Tuple([bool, bool, int, String]);
      Tuple positiveSubject = new Tuple([true, true, 3209328, 'world']);
      Tuple negativeSubject1 =
          new Tuple(['hello', 'world', 'four', 'elements']);
      Tuple negativeSubject2 = new Tuple([true, true]);

      Map matrix = generateMatchMatrix(criteria);
      bool positiveResult = subjectMatchesCriteria(matrix, positiveSubject);
      expect(positiveResult, isTrue, reason: 'Should be a match');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSubject1);
      expect(negativeResult1, isFalse, reason: 'Should not be a match');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSubject2);
      expect(negativeResult2, isFalse, reason: 'Too short to match');
    });

    test('Should return true for positive and false for negative (5 Elements).',
        () {
      Tuple criteria = new Tuple([bool, bool, int, bool, double]);
      Tuple positiveSubject = new Tuple([true, true, 3209328, false, 9.39393]);
      Tuple negativeSubject1 =
          new Tuple(['hello', 'world', 'four', 'elements', 3.33333]);
      Tuple negativeSubject2 = new Tuple([true, true, true, true, true, true]);
      Tuple negativeSubject3 = new Tuple([false, true, 343, false]);

      Map matrix = generateMatchMatrix(criteria);
      bool positiveResult = subjectMatchesCriteria(matrix, positiveSubject);
      expect(positiveResult, isTrue, reason: 'Should be a match');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSubject1);
      expect(negativeResult1, isFalse, reason: 'Should not be a match');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSubject2);
      expect(negativeResult2, isFalse, reason: 'Too Long to match');

      bool negativeResult3 = subjectMatchesCriteria(matrix, negativeSubject3);
      expect(negativeResult3, isFalse, reason: 'Too short to match');
    });
  });

  group('Matching with options:\t',(){

    test('Should return true for positive and false for negative (1 Optional).',(){
       Tuple criteria = new Tuple([bool, new Optional.of(int), bool, String]);
      Tuple positiveSub1 = new Tuple([false, 3843, true, 'happy']);
      Tuple positiveSub2 = new Tuple([true,false,'hello']);
      Tuple negativeSub1 = new Tuple([true, true, true, 'water']);
      Tuple negativeSub2 = new Tuple([192,false]);
      Tuple negativeSub3 = new Tuple([false, 93834, true, 'lakes', false]);

      Map matrix = generateMatchMatrix(criteria);

      bool positiveResult1 = subjectMatchesCriteria(matrix, positiveSub1);
      expect(positiveResult1, isTrue, reason: 'Should a positive match');

      bool positiveResult2 = subjectMatchesCriteria(matrix, positiveSub2);
      expect(positiveResult2, isTrue, reason: 'should be positive with optional');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSub1);
      expect(negativeResult1, isFalse, reason: 'Should be negative match');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSub2);
      expect(negativeResult2, isFalse, reason: 'Too short to match');

      bool negativeResult3 = subjectMatchesCriteria(matrix, negativeSub3);
      expect(negativeResult3, isFalse, reason: 'Too long to match');
    });

    test(
        'Should return true for positive and false for negative (2 Optional).', () {
      Tuple criteria = new Tuple([bool, new Optional.of(int), bool, String, new Optional.of(bool)]);
      Tuple positiveSub1 = new Tuple([false, 3843, true, 'happy', true]);
      Tuple positiveSub2 = new Tuple([true, false, 'hello',false]);
      Tuple negativeSub1 = new Tuple([true, true, true, 'water', 34343]);
      Tuple negativeSub2 = new Tuple([192, false, 3434]);
      Tuple negativeSub3 = new Tuple([false, 93834, true, 'lakes', false, 3434, false]);

      Map matrix = generateMatchMatrix(criteria);

      bool positiveResult1 = subjectMatchesCriteria(matrix, positiveSub1);
      expect(positiveResult1, isTrue, reason: 'Should a positive match');

      bool positiveResult2 = subjectMatchesCriteria(matrix, positiveSub2);
      expect(
          positiveResult2, isTrue, reason: 'should be positive with optional');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSub1);
      expect(negativeResult1, isFalse, reason: 'Should be negative match');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSub2);
      expect(negativeResult2, isFalse, reason: 'Too short to match');

      bool negativeResult3 = subjectMatchesCriteria(matrix, negativeSub3);
      expect(negativeResult3, isFalse, reason: 'Too long to match');
    });

    test(
        'Should return true for positive and false for negative (3 Optional).', () {
      Tuple criteria = new Tuple(
          [new Optional.of(bool), new Optional.of(int), bool, String, new Optional.of(bool)]);
      Tuple positiveSub1 = new Tuple([false, 3843, true, 'happy', true]);
      Tuple positiveSub2 = new Tuple([true, false, 'hello', false]);
      Tuple negativeSub1 = new Tuple([true, true, true, 'water', 34343]);
      Tuple negativeSub2 = new Tuple([192, false, 3434]);
      Tuple negativeSub3 = new Tuple(
          [false, 93834, true, 'lakes', false, 3434, false]);

      Map matrix = generateMatchMatrix(criteria);

      bool positiveResult1 = subjectMatchesCriteria(matrix, positiveSub1);
      expect(positiveResult1, isTrue, reason: 'Should a positive match');

      bool positiveResult2 = subjectMatchesCriteria(matrix, positiveSub2);
      expect(
          positiveResult2, isTrue, reason: 'should be positive with optional');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSub1);
      expect(negativeResult1, isFalse, reason: 'Should be negative match');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSub2);
      expect(negativeResult2, isFalse, reason: 'Too short to match');

      bool negativeResult3 = subjectMatchesCriteria(matrix, negativeSub3);
      expect(negativeResult3, isFalse, reason: 'Too long to match');
    });

    test(
        'Should return true for positive and false for negative (4 Optional).', () {
      Tuple criteria = new Tuple(
          [
            new Optional.of(bool),
            new Optional.of(int),
            bool,
            new Optional.of(String),
            String,
            new Optional.of(bool)
          ]);
      Tuple positiveSub1 = new Tuple([false, 3843, true, 'happy','cave', true]);
      Tuple positiveSub2 = new Tuple([true, false, 'hello', false]);
      Tuple positiveSub3 = new Tuple([834, false, 'water','happy']);
      Tuple negativeSub1 = new Tuple([true, true, true, 'water', 34343,false]);
      Tuple negativeSub2 = new Tuple([192, false, 3434]);
      Tuple negativeSub3 = new Tuple(
          [false, 93834, true, 'lakes', false, 3434, false, 834.3]);

      Map matrix = generateMatchMatrix(criteria);

      bool positiveResult1 = subjectMatchesCriteria(matrix, positiveSub1);
      expect(positiveResult1, isTrue, reason: 'Should a positive match');

      bool positiveResult2 = subjectMatchesCriteria(matrix, positiveSub2);
      expect(
          positiveResult2, isTrue, reason: 'should be positive with optional');

      bool positiveResult3 = subjectMatchesCriteria(matrix, positiveSub3);
      expect(positiveResult3, isTrue, reason: 'First optional not considered');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSub1);
      expect(negativeResult1, isFalse, reason: 'Should be negative match');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSub2);
      expect(negativeResult2, isFalse, reason: 'Too short to match');

      bool negativeResult3 = subjectMatchesCriteria(matrix, negativeSub3);
      expect(negativeResult3, isFalse, reason: 'Too long to match');
    });

    test(
        'Should return true for positive and false for negative (5 Optional).', () {
      Tuple criteria = new Tuple(
          [
            new Optional.of(bool),
            new Optional.of(int),
            bool,
            new Optional.of(String),
            new Optional.of(String),
            String,
            bool,
            new Optional.of(bool)
          ]);
      Tuple positiveSub1 = new Tuple(
          [false, 3843, true, 'happy', 'cave','raining',true, false]);
      Tuple positiveSub2 = new Tuple([true, 'cat', 'dog', false]);
      Tuple positiveSub3 = new Tuple([true,false, 'rain', 'framer', true]);
      Tuple negativeSub1 = new Tuple([true, 152454, true, 'water', 34343, false]);
      Tuple negativeSub2 = new Tuple([192, false, 3434]);
      Tuple negativeSub3 = new Tuple(
          [false, 93834, true, 'lakes', false, 3434, false, 834.3, false]);

      Map matrix = generateMatchMatrix(criteria);

      bool positiveResult1 = subjectMatchesCriteria(matrix, positiveSub1);
      expect(positiveResult1, isTrue, reason: 'Should a positive match');

      bool positiveResult2 = subjectMatchesCriteria(matrix, positiveSub2);
      expect(
          positiveResult2, isTrue, reason: 'should be positive with optional');

      bool positiveResult3 = subjectMatchesCriteria(matrix, positiveSub3);
      expect(positiveResult3, isTrue, reason: 'First optional not considered');

      bool negativeResult1 = subjectMatchesCriteria(matrix, negativeSub1);
      expect(negativeResult1, isFalse, reason: 'Should be negative match');

      bool negativeResult2 = subjectMatchesCriteria(matrix, negativeSub2);
      expect(negativeResult2, isFalse, reason: 'Too short to match');

      bool negativeResult3 = subjectMatchesCriteria(matrix, negativeSub3);
      expect(negativeResult3, isFalse, reason: 'Too long to match');
    });

  });
}
