library darpule.test.matchers.criteria;

import 'package:darpule/src/matchers/criteria/criteria_matcher.dart';
import 'package:darpule/tuple.dart';
import 'package:test/test.dart';
import 'package:quiver_optional/optional.dart';

main() {
  group('Matcher List for Types:   \t', () {
    test('Should pick matchers for type criterion.', () {
      Tuple criteria = new Tuple([String, int, bool, double]);
      List matchers = selectMatchers(criteria);
      expect(matchers is List, isTrue);
      expect(matchers[0]('happy days'), isTrue);
      expect(matchers[1](38393), isTrue);
      expect(matchers[2](false), isTrue);
      expect(matchers[3](0.34), isTrue);
      expect(matchers[3](23), isFalse);
      expect(matchers[0](String), isFalse);
      expect(matchers[1](int), isFalse);
      expect(matchers[2](bool), isFalse);
    });

    test('Should pick matchers for optional criterion.', () {
      Tuple criteria = new Tuple([int, new Optional.of(bool), String]);
      List matchers = selectMatchers(criteria);
      expect(matchers[0](34), isTrue, reason: 'Did not match int');
      expect(matchers[1](true), isTrue, reason: 'Did not match bool');
      expect(matchers[2]("Hello"), isTrue, reason: 'Did not match string');
      expect(matchers[0]("hello"), isFalse, reason: 'Should only match int');
      expect(matchers[1](34), isFalse, reason: 'Should only match bool');
      expect(matchers[2](true), isFalse, reason: 'Should only match string');
    });

    test('Should pick matchers for optional wild.', () {
      Tuple criteria = new Tuple([bool, new Optional.of(Type), int]);
      List matchers = selectMatchers(criteria);
      expect(matchers[0](false), isTrue);
      expect(matchers[1]("Word"), isTrue);
      expect(matchers[1](234), isTrue);
      expect(matchers[1](34.23), isTrue);
      expect(matchers[1](String), isFalse);
    });

    test('Should pick matchers for mandatory yet wild.', () {
      Tuple criteria = new Tuple([double, Type, int]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0](93.2), isTrue, reason: 'Did not match double');
      expect(matcher[1]('Car'), isTrue, reason: 'Did not match mandatory wild');
      expect(matcher[2](32), isTrue, reason: 'Did not match int');
      expect(matcher[0](Object), isFalse, reason: 'Should only match int');
      expect(matcher[1](String), isFalse, reason: 'Should only match value');
    });

    test('Should pick matchers for collection existen.', () {
      Tuple criteria = new Tuple([List, Map, Set]);
      List myList = new List();
      Map myMap = new Map();
      Set mySet = new Set();
      List matcher = selectMatchers(criteria);
      expect(matcher[0](myList), isTrue);
      expect(matcher[1](myMap), isTrue);
      expect(matcher[2](mySet), isTrue);
      expect(matcher[0](List), isFalse);
      expect(matcher[1](Map), isFalse);
      expect(matcher[2](Set), isFalse);
    });

    test('Should pick matchers for Tuple existen.', () {
      Tuple criteria = new Tuple([bool, Tuple]);
      Tuple nullpule = new Tuple([]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0](true), isTrue);
      expect(matcher[1](nullpule), isTrue);
    });

    test('Should pick matchers for highly mixed criteria.', () {
      Tuple criteria = new Tuple([
        int,
        new Optional.of(bool),
        Type,
        new Optional.of(Type),
        String,
        double
      ]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0](34), isTrue, reason: 'Did not match int');
      expect(matcher[1](false), isTrue, reason: 'Did not match bool');
      expect(matcher[2]('Anything'), isTrue, reason: 'Did not match any wild');
      expect(matcher[3](4903), isTrue, reason: 'Did not match optional wild');
      expect(matcher[4]('Hello'), isTrue, reason: 'Did not match String');
      expect(matcher[5](23.32), isTrue, reason: 'Did not match double');
      expect(matcher[1]('Anything'), isFalse, reason: 'Should only match bool');
      expect(matcher[2](String), isFalse,
          reason: 'Wild Type should match value');
      expect(matcher[3](Type), isFalse, reason: 'Wild Type should match value');
      expect(matcher[3](Object), isFalse,
          reason: 'Wild Type should match value');
      expect(matcher[2](null), isFalse, reason: 'null dont get to play');
    });
  });



  group('Matcher List for Runnable: \t', () {
    test('Should execute a function using the value from the subject.', () {
      Function acceptablePressure(double pressure, double tolerance) {
        bool pressureOK(double element) {
          bool varianceWithinRange(double element) {
            double variance = ((element - pressure) / pressure).abs();
            return variance <= tolerance ? true : false;
          }
          return varianceWithinRange(element);
        }
        return pressureOK;
      }

      Function calculation = acceptablePressure(192.30, .05);

      Tuple criteria = new Tuple([calculation, calculation, calculation]);
      List matcher = selectMatchers(criteria);

      expect(matcher[0](181.4), isFalse);
      expect(matcher[0](185.9), isTrue);
      expect(matcher[0](192.30), isTrue);
      expect(matcher[0](200.00), isTrue);
      expect(matcher[0](320.00), isFalse);

      expect(matcher[1](181.4), isFalse);
      expect(matcher[1](185.9), isTrue);
      expect(matcher[1](192.30), isTrue);
      expect(matcher[1](200.00), isTrue);
      expect(matcher[1](320.00), isFalse);

      expect(matcher[2](181.4), isFalse);
      expect(matcher[2](185.9), isTrue);
      expect(matcher[2](192.30), isTrue);
      expect(matcher[2](200.00), isTrue);
      expect(matcher[2](320.00), isFalse);
    });

    test('Should match with regExp from criteria wiht value from subject', () {
      RegExp shouldContainWord = new RegExp(r"(\w+)");
      RegExp shouldContainNumber = new RegExp(r"(\d+)");

      Tuple criteria = new Tuple([shouldContainWord, shouldContainNumber]);

     List matcher = selectMatchers(criteria);
      expect(matcher[0]('Hello'), isTrue);
      expect(matcher[0]('Hello World'), isTrue);
      expect(matcher[0]('//////&&&&&'), isFalse);

      expect(matcher[1]('Hello'), isFalse);
      expect(matcher[1]("230940"), isTrue);
      expect(matcher[1]('////()^%*&^%'), isFalse);
    });
  });

  group('Matcher List for Collection:\t', () {
    test('Should match a list collection instance.', () {
      List criterion1 = [3434, 2394, 093];
      List criterion2 = [true, false, 834];
      Tuple criteria = new Tuple([criterion1, criterion2]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0]([3434, 2394, 093]), isTrue);
      expect(matcher[0](['cat', 2394, 094]), isFalse);
      expect(matcher[1]([true, false, 834]), isTrue);
      expect(matcher[1]([9384, 093, 123]), isFalse);
    });

    test('Should match a map collection instance.', () {
      Map criterion1 = {'k1': 'Cat', 'k2': true, 'k3': 90823};
      Map criterion2 = {'k1': false, 'k2': 3903, 'k3': 'dog', 'k4': true};
      Tuple criteria = new Tuple([criterion1, criterion2]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0]({'k1': 'Cat', 'k2': true, 'k3': 90823}), isTrue);
      expect(matcher[0]({'k1': 'dog', 'k2': false, 'k3': 90823}), isFalse);
      expect(matcher[1]({'k1': false, 'k2': 3903, 'k3': 'dog', 'k4': true}),
          isTrue);
      expect(matcher[1]({'k1': false, 'k2': 3903}), isFalse);
    });
  });

  group('Matcher List for Values:  \t', () {
    test('Should match direct value nothing wild.', ()  {
      Tuple criteria = new Tuple(['roger', 30934, true, 'model', false]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0]('roger'), isTrue);
      expect(matcher[1](30934), isTrue);
      expect(matcher[2](true), isTrue);
      expect(matcher[3]('model'), isTrue);
      expect(matcher[4](false), isTrue);
      expect(matcher[0]('Roger'), isFalse);
      expect(matcher[1](934), isFalse);
      expect(matcher[2](3434), isFalse);
      expect(matcher[3](false), isFalse);
      expect(matcher[4]('dog'), isFalse);
    });

    test('Should match direct value with mandatory wild.', () async {
      Tuple criteria = new Tuple(['model3940', Object, Object, Object]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0]('model3940'), isTrue);
      expect(matcher[1]('anything'), isTrue);
      expect(matcher[2](340), isTrue);
      expect(matcher[3](true), isTrue);
      expect(matcher[0](String), isFalse);
      expect(matcher[1](String), isFalse);
      expect(matcher[2](int), isFalse);
      expect(matcher[3](bool), isFalse);
    });
  });

  group('Mixed Critieria:  \t', () {
    test('Should match criteria with types and values.', () {
      Tuple criteria = new Tuple([bool, 'model9034', int, String, true, bool]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0](true), isTrue);
      expect(matcher[1]('model9034'), isTrue);
      expect(matcher[2](34023), isTrue);
      expect(matcher[3]('dog'), isTrue);
      expect(matcher[4](true), isTrue);
      expect(matcher[5](false), isTrue);
      expect(matcher[0](bool), isFalse);
      expect(matcher[1](String), isFalse);
      expect(matcher[2](int), isFalse);
      expect(matcher[3](String), isFalse);
      expect(matcher[4](bool), isFalse);
      expect(matcher[5](bool), isFalse);
    });

    test('Should match all things combined.', () {
      Tuple criteria = new Tuple([
        Object,
        new Optional.of(int),
        new Optional.of(9309403),
        bool,
        false,
        new Optional.of(Type)
      ]);
      List matcher = selectMatchers(criteria);
      expect(matcher[0]('dog'), isTrue, reason: 'Wild card');
      expect(matcher[0](true), isTrue, reason: 'Wild card');
      expect(matcher[1](459), isTrue, reason: 'Should match int');
      expect(matcher[2](9309403), isTrue, reason: 'Should match number value.');
      expect(matcher[3](true), isTrue, reason: 'Should match a bool');
      expect(matcher[4](false), isTrue, reason: 'should match value false');
      expect(matcher[5](true), isTrue,
          reason: 'should match a value of anytype');
    });
  });
}
