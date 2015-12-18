// Copyright (c) 2015, Ray King. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library darpule.example;

import 'package:darpule/tuple.dart';
import 'package:darpule/matcher.dart';
import 'package:darpule/predicate.dart';

main() {
  /// Easy ad-hoc creation, fill them as you like.
  Tuple signal01 = new Tuple([2837, 283.23, true, '934893-23XA', false]),
      signal02 =
      new Tuple([true, new DateTime.now(), 49893, 'saber3903', false, 401.34]),
      signal03 = new Tuple([]),
      signal04 = new Tuple([3043.398, true, true, false, 'black', 90934, true]),
      signal05 = new Tuple([
    'SouthPort',
    true,
    [394, 3403, 3493, 2303]
  ]);

  assert(signal01 is Tuple && signal01.type == TupleType.quintuple);
  assert(signal02 is Tuple && signal02.type == TupleType.sextuple);
  assert(signal03 is Tuple && signal03.type == TupleType.nulluple);
  assert(signal04 is List && signal04.type == TupleType.septuple);
  assert(signal05 is Tuple && signal05.type == TupleType.triple);

  assert(signal01[0] == 2837);

  /// No changes on the down low.
  try {
    signal01.removeAt(0);
  } catch (e) {
    assert(e is MutabilityError);
  }

  /// Nothing has change.
  assert(signal01.type == TupleType.quintuple);

  /// Adding is also a change
  try {
    signal03.addAll([0, true, 'hello']);
  } catch (e) {
    assert(e is MutabilityError);
  }

  /// Grab the content leaving the original untouched.

  int signal04BeforeHash = signal04.hashCode;
  var signal04Contents = signal04(); // Call it like a function and it dumps
  assert(signal04Contents is List);
  assert(signal04Contents.length == signal04.length);
  assert(signal04.every((e) => signal04Contents.contains(e)));
  assert(signal04Contents.every((e) => signal04.contains(e)));
  int signal04AfterHash = signal04.hashCode;
  assert(signal04AfterHash == signal04BeforeHash);

  /// Each Tuple plays well with others.

  assert(signal01 != signal02);
  assert(signal05.toString() ==
      'TupleType.triple - [SouthPort, true, [394, 3403, 3493, 2303]]');
  assert(signal05.hashCode == signal05.hashCode);
  assert(signal01.iterator.moveNext());
  var inTheTuple = signal01.iterator;
  assert(inTheTuple is TupleIterator);
  assert(inTheTuple.moveNext() == true);
  assert(inTheTuple.current == 2837);
  assert(inTheTuple.moveNext() == true);
  assert(inTheTuple.current == 283.23);
  assert(inTheTuple.movePrevious() == true);
  assert(inTheTuple.current == 2837);
  assert(inTheTuple.index == 0);

  /// Inserting and Appending with picking and counting

  Tuple signalPartA =
      new Tuple(['38493-23XJ', 34034, false, 382.34, 'counter-service']),
      signalPartB = new Tuple(['south', 384, 823, 399, true]);

  Tuple completedSignal1 = signalPartA.intoSplice(signalPartB, isValueBoolean);

  print(completedSignal1.toString());

  Tuple completedSignal2 =
      signalPartA.intoSplice(signalPartB, isValueBoolean, before: false);

  print(completedSignal2.toString());

  /// Append and wash away it's identity.

  Tuple completedSignal3 = signalPartA.concatWith(signalPartB);

  print(completedSignal3.toString());

  /// Equals is not skin deep.

  Tuple signal06 = new Tuple([true, 23984, false]),
      signal07 = new Tuple([true, 23984, false]),
      signal08 = new Tuple([signal04, signal06]),
      signal09 = new Tuple([
    new Tuple([3043.398, true, true, false, 'black', 90934, true]),
    new Tuple([true, 23984, false])
  ]),
      signal10 = new Tuple([
    new Tuple([3043.398, true, false, false, 'black', 90934, true]),
    new Tuple([true, 999999, false])
  ]),
      signal11 =
      new Tuple([true, new DateTime.now(), 49893, 'saber3903', false, 401.34]);

  assert(signal06 == signal07);
  assert(!identical(signal06, signal07));
  assert(signal08 == signal09);
  assert(signal10 != signal09);

  /// We need to be discerning about our tuple, lets define a criteria.

  Tuple validGateSignalCriteria = new Tuple([int, double, bool, String, bool]);

  TupleMatcher isValidGateSignal = criteriaMatcher(validGateSignalCriteria);

  assert(isValidGateSignal(signal01));
  assert(!isValidGateSignal(signal09));

  /// Sometime Types are not enough and some literals appears.

  Tuple packageTrackingCriteria =
      new Tuple([double, bool, bool, bool, 'black', int, bool]);

  TupleMatcher isPackageTrackable = criteriaMatcher(packageTrackingCriteria);

  assert(isPackageTrackable(signal04));
  assert(!isPackageTrackable(signal09));

  /// Other times it could a threshold that triggers thing off.

  Function thresholdTrigger(double limit) {
    bool matcher(double value) => value > limit ? true : false;
    return matcher;
  }

  Tuple trackingTemperatureTrigger =
      new Tuple([bool, DateTime, int, String, bool, thresholdTrigger(399.00)]);

  TupleMatcher isTrackableTempOverRange =
      criteriaMatcher(trackingTemperatureTrigger);

  assert(isTrackableTempOverRange(signal02));
  assert(!isPackageTrackable(signal11));

  /// When things become conditional using optional can get you out of hole.

  Tuple trackCriteria = new Tuple(
      [String, new Optional.of(int), new Optional.of(true), bool, double]);

  Tuple signal12_trackable = new Tuple(['3892-X8349', false, 393.00]),
      signal13_trackable = new Tuple(['90234-Y83', 34948, true, 84.23]),
      signal14_trackable = new Tuple(['34901-B39', 323, true, false, 23.32]),
      signal15_notTrackage = new Tuple(['29023-12', false, true, 30.23]),
      signal16_notTrackage = new Tuple(['230-OU3', 23, false, true, 23.23]);

  TupleMatcher isTrackable = criteriaMatcher(trackCriteria);

  assert(isTrackable(signal12_trackable));
  assert(isTrackable(signal13_trackable));
  assert(isTrackable(signal14_trackable));
  assert(!isTrackable(signal15_notTrackage));
  assert(!isTrackable(signal16_notTrackage));
}
