library darpule.test.matchers.individual;

import 'package:test/test.dart';
import 'package:darpule/matcher.dart';

main() {
  group('Runtime TypeMatch:    \t', () {
    test('Should return a function that matches against specified type.', () {
      Function stringMatcher = typeMatcher(String);
      expect(stringMatcher("Hello world"), isTrue);
      expect(stringMatcher(false), isFalse);
      expect(stringMatcher(String), isFalse);

      Function boolMatcher = typeMatcher(bool);
      expect(boolMatcher(true), isTrue);
      expect(boolMatcher('false'), isFalse);
      expect(boolMatcher(bool), isFalse);
      expect(boolMatcher(Object), isFalse);
      expect(boolMatcher(Type), isFalse);

      Function dateMatcher = typeMatcher(DateTime);
      var now = new DateTime.now();
      expect(dateMatcher(now), isTrue);
      expect(dateMatcher('23/10/2010'), isFalse);
      expect(dateMatcher(Object), isFalse);
      expect(dateMatcher(DateTime), isFalse);
    });
  });

  group('Runtime ValueMatcher:  \t', () {
    test('Should return a function that matches a given number value.', () {
      Function priceMatcher = valueMatcher(23.34);
      expect(priceMatcher(23.34), isTrue);
      expect(priceMatcher(23.3400), isTrue);
      expect(priceMatcher(0.232), isFalse);
      expect(priceMatcher(34.23 + 394.23), isFalse);
      expect(priceMatcher(384), isFalse);
      expect(priceMatcher(0), isFalse);
      expect(priceMatcher(double), isFalse);
      expect(priceMatcher(null), isFalse);
      expect(priceMatcher(Object), isFalse);
    });

    test('Should return true on an int', () {
      Function numberMatcher = valueMatcher(9309403);
      expect(numberMatcher(9309403), isTrue);
      expect(numberMatcher(3049039), isFalse);
    });

    test('Should return a function that matches a given string value.', () {
      Function helloMatcher = valueMatcher('hello world');
      expect(helloMatcher('hello world'), isTrue);
      expect(helloMatcher('hello' + 'world'), isFalse);
      expect(helloMatcher('See you later'), isFalse);
      expect(helloMatcher(String), isFalse);
      expect(helloMatcher(null), isFalse);
      expect(helloMatcher(Type), isFalse);
    });

    test('Should return a function that matches bool values.', () {
      Function helloMatcher = valueMatcher('hello world');
      Function boolMatcher = valueMatcher(true);
      expect(boolMatcher(true), isTrue);
      expect(boolMatcher(5 > 1), isTrue);
      expect(boolMatcher(1 > 5), isFalse);
      expect(boolMatcher(true == true), isTrue);
      expect(boolMatcher(helloMatcher('hello world')), isTrue);
      expect(boolMatcher(helloMatcher('wrong')), isFalse);
      expect(boolMatcher('false'), isFalse);
      expect(boolMatcher(bool), isFalse);
      expect(boolMatcher(null), isFalse);
    });
  });

  group('Runtime FuncitonMatcher: \t', () {
    test('Should return a function that returns result of enclosed function.',
        () {
      bool acceptableNumber(int number) {
        return number * 3 > 200 ? true : false;
      }
      Function functionExecutor = functionResultMatcher(acceptableNumber);
      expect(functionExecutor(3), isFalse);
      expect(functionExecutor(100), isTrue);
    });
  });

  group('Runtime RegExp:        \t', () {
    test('Should return a function that evaluates regexp.', () {
      Function regExpMatcher = patternMatcher(new RegExp(r"(\w+)"));
      expect(regExpMatcher('OneWord'), isTrue);
      expect(regExpMatcher('Many words will work'), isTrue);
      expect(regExpMatcher('?? //// '), isFalse);
    });
  });

  group('List Value Matcher:      \t', () {
    test('Should return a function that matches two list.', () {
      List testList = ['water', true, 343, 'rain'];
      Function myListMatcher = listValueMatcher(testList);
      expect(myListMatcher([true, false]), isFalse);
      expect(myListMatcher(['water', true, 343, 'rain']), isTrue);
    });
  });

  group('Map Value Matcher:      \t', () {
    test('Should return a function thta matches the value in two maps.', () {
      Map testMap = {'k1': true, 'k3': 'rabbit', 'k4': 3934};
      Function myMapMatcher = mapValueMatcher(testMap);
      expect(myMapMatcher({'k1': true, 'k3': 'rabbit', 'k4': 3934}), isTrue);
      expect(myMapMatcher({'k1': true, 'k3': 'Mountain', 'k4': 3934}), isFalse);
    });
  });

  group("Set Value Matcher:       \t", () {
    test('Should retrun a function that matches the value in two sets.', () {
      Set testSet = new Set.from([true, 'walker', 383, 0.34]);
      Set subjectSet = new Set.from([false, 'billy', 'john', 'stone']);
      Set correctSet = new Set.from([true, 'walker', 383, 0.34]);
      Function mySetMatcher = setValueMatcher(testSet);
      expect(mySetMatcher(subjectSet), isFalse);
      expect(mySetMatcher(correctSet), isTrue);
    });
  });
}
