import 'package:darpule/predicate.dart';

import 'package:darpule/tuple.dart';
import 'package:quiver/collection.dart';
import 'dart:async';

main() async {
  Tuple layer0,
      layer1TypeA,
      layer1TypeB,
      layer1TypeC,
      layer2TypeA,
      layer2TypeB,
      layer2TypeC,
      layer2TypeD,
      layer3TypeA,
      layer3TypeB,
      layer3TypeC,
      layer3TypeD,
      layer3TypeE,
      layer4TypeA,
      layer4TypeB,
      layer4TypeC,
      layer4TypeD,
      layer4TypeE,
      layer4TypeF;

  Optional optionalString,
      optionalBool,
      optionalInt,
      optionalDouble,
      optionalWild;
  optionalString = new Optional.of(String);
  optionalBool = new Optional.of(bool);
  optionalInt = new Optional.of(int);
  optionalDouble = new Optional.of(double);
  optionalWild = new Optional.absent();

  layer4TypeF = new Tuple([bool, String, int, double, int]);
  layer4TypeE = new Tuple([int, bool, String, int, double]);
  layer4TypeD = new Tuple([double, int, bool, String, int]);
  layer4TypeC = new Tuple([int, double, int, bool, String]);
  layer4TypeB = new Tuple([String, int, double, int, bool]);
  layer4TypeA = new Tuple([Object, Object, optionalBool, bool]);

  layer3TypeE = new Tuple([layer4TypeE, bool, layer4TypeF]);
  layer3TypeD = new Tuple([Tuple, Object, optionalBool, int, layer4TypeD]);
  layer3TypeC = new Tuple([int, bool, layer4TypeC]);
  layer3TypeB = new Tuple([optionalWild, int, bool, layer4TypeB]);
  layer3TypeA = new Tuple([double, optionalBool, int, int, layer4TypeA]);

  layer2TypeD = new Tuple([String, layer3TypeE, int, layer3TypeD]);
  layer2TypeC =
      new Tuple([int, int, Object, optionalString, bool, layer3TypeC]);
  layer2TypeB = new Tuple([bool, optionalBool, String, int, layer3TypeB]);
  layer2TypeA = new Tuple([int, String, bool, layer3TypeA]);

  layer1TypeC =
      new Tuple([Object, String, bool, optionalWild, layer2TypeA, layer2TypeB]);
  layer1TypeB = new Tuple([bool, double, Object, optionalString, layer2TypeC]);
  layer1TypeA =
      new Tuple([String, String, Object, int, double, bool, layer2TypeD]);

  layer0 = new Tuple([layer1TypeA, layer1TypeB, layer1TypeC, String, Tuple]);

  Tuple l1TA,
      l1TB,
      l1TC,
      l2TA,
      l2TB,
      l2TC,
      l2TD,
      l3TA,
      l3TB,
      l3TC,
      l3TD,
      l3TE,
      l4TA,
      l4TB,
      l4TC,
      l4TD,
      l4TE,
      l4TF,
      tup1,
      tup2,
      tup3;

  tup1 = new Tuple(['Anything', 'will work here', 934]);
  tup2 = new Tuple([9384, true, false, 23]);
  tup3 = new Tuple(['Anything will work', true, true, true]);
  l4TF = new Tuple([true, 'layer4TypeF String', 3902, 0.323, 232]);
  l4TE = new Tuple([32323, false, 'layer4TypeE String', 3928, 12.23]);
  ;
  l4TD = new Tuple([9384.027, 382, true, 'Sting for l4TD', 123]);
  l4TC = new Tuple([23, 834.23, 337, true, 'l4tc String']);
  l4TB = new Tuple(['String l4tB', 292, 384.016, 3993, false]);
  l4TA = new Tuple([false, 38494.01, true, true]);
  l3TE = new Tuple([l4TE, true, l4TF]);
  l3TD = new Tuple([tup2, 3434, false, 9384, l4TD]);
  l3TC = new Tuple([203, false, l4TC]);
  l3TB = new Tuple([tup1, 39, true, l4TB]);
  l3TA = new Tuple([931.002, true, 23423, 34, l4TA]);
  l2TD = new Tuple(['Message System String', l3TE, l3TD, 728, l3TD]);
  l2TC = new Tuple([234, 34, 23.92, 'Optional String', true, l3TC]);
  l2TB = new Tuple([true, false, 'String for l2TB', 23, l3TB]);
  l2TA = new Tuple([23, 'String for l2TA', false, l3TA]);
  l1TC = new Tuple([
    'l1TC object',
    'Defined String',
    true,
    'Anything not type checked',
    l2TA,
    l2TB
  ]);

  l1TB = new Tuple([false, 9384.23, 'ObjectWild', 839, 9282.34, true, l2TC]);
  l1TA = new Tuple(
      ['rockets', 'fountains', 'wild object string', 2829, 92.34, false, l2TD]);
  Tuple subjectRoot = new Tuple([l1TA, l1TB, l1TC, 'String of words', tup3]);

  Tuple criteria = new Tuple([String, int, bool, Tuple]);
  Tuple subject = new Tuple(['String Element', 3838, true, tup3]);

  isTupleMatching(criteria, subject).then((bool result) {
    print(result);
  });
}

Future<bool> isTupleMatching(Tuple criteria, Tuple subject) async {
  print('- isTupleMatching called for  ${subject.toString()}');

  return isElementCountEqual(criteria, subject)
      ? await isEachElementMatching(criteria, subject)
      : false;
}

Future<bool> isEachElementMatching(Tuple criteria, Tuple subject) async {

  print("- isEachElement Matching was given $subject");

  List elementTestResults = new List(subject.length);

  bool notCompleted() => elementTestResults.contains(null) ? true : false;

  bool misMatchNotFound() => elementTestResults.contains(false) ? false : true;


    for (int i = 0; i < subject.length; i++) {
      var criterion = criteria[i];
      var element = subject[i];

      if (isTuple(criterion)) {
        print('- Tuple Element Detected');
        elementTestResults[i] = await isTupleMatching(criterion, element);
      } else {
        print('- Matchable Element Detected ${criterion}');
        elementTestResults[i] = await isElementMatching(criterion, element);
      }
    }


  return elementTestResults.contains(false) ? false : true;
}

/// Takes care of the matching of a single element.
Future<bool> isElementMatching(var criterion, var element) async {



  if (criterion is Type) {
    return criterion == element.runtimeType ? true : false;
  }

  if (criterion is Function) {
    return criterion(element) ? true : false;
  }

  if (criterion is Pattern && element is String) {
    Iterable<Match> matches = element.allMatches(criterion);
    return matches.isNotEmpty ? true : false;
  }

  return criterion == element ? true : false;
}
