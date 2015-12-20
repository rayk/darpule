# Darpule

_Lightweight, Robust Immutable Tuple Implementation._

[![Build Status](https://travis-ci.org/rayk/darpule.svg?branch=release)](https://travis-ci.org/rayk/darpule) [![codecov.io](https://codecov.io/github/rayk/darpule/coverage.svg?branch=master)](https://codecov.io/github/rayk/darpule?branch=master)   

The [Tuple] is nothing new, natively implemented in some languages like Python, Lisp, Scala and the list continues.

It is a workhorse data structure, which helps reduce the number of transient classes, long parameter list and unstructured buckets of data swishing around between functions, methods, and isolates. 

Using it with the predicates and matchers lifts your code abstraction level.

This package provides a lightweight implementation of a Tuple. Based upon the native Dart List, with immutability and a bidirectional iterator added, making it  a very functional style of a Tuple. By also importing the predicate and matcher libraries we also start to reason about the tuple.

## Usage Examples

A running version of these example can be found in the example/darpule.dart. Refer to that and the test suite for a complete understanding.

_Creatable in a quick ad-hoc fashion._

```dart
 /// Easy ad-hoc creation, fill them as you like.
 
  Tuple
    signal01 = new Tuple([2837, 283.23, true, '934893-23XA', false]),
    signal02 = new Tuple([true, new DateTime.now(), 49893, 'saber3903', false, 401.34]),
    signal03 = new Tuple([]),
    signal04 = new Tuple([3043.398, true, true, false, 'black', 90934, true]),
    signal05 = new Tuple(['SouthPort', true, [394, 3403, 3493, 2303]]);

  assert(signal01 is Tuple && signal01.type == TupleType.quintuple);
  assert(signal02 is Tuple && signal02.type == TupleType.sextuple);
  assert(signal03 is Tuple && signal03.type == TupleType.nulluple);
  assert(signal04 is List && signal04.type == TupleType.septuple);
  assert(signal05 is Tuple && signal05.type == TupleType.triple);

  assert(signal01[0] == 2837);
```

The immutability comes from Dart's UnmodifiableListView, which has a small reasonably footprint. We can place anything we like into our Tuple.  While still having access to Darts functional goodness.

Attempting to change the tuple does not go unnoticed.

```dart
/// No changes on the down low.

  try{
    signal01.removeAt(0);
  } catch(e) {
    assert(e is MutabilityError);
  }
  /// Nothing has change.
  assert(signal01.type == TupleType.quintuple);

  /// Adding is also a change
  try{
    signal03.addAll([0,true,'hello']);
  } catch(e){
    assert(e is MutabilityError);
  }
```


Tuple immutable comes into play once the Tuple become instantiated. After which time attempting to change the Tuple is considered a programming error, greeted with a MutabilityError.

Immutability can be mind-bender at first but starts feeling very natural very quickly. The [concat] method returns a new Tuple; with the content of, another Tuple. Whereas the [splice] method produces a new Tuple, based on the elements of another tuple that has had content injected at a precise location. The original Tuples are never modified new Tuples reflect the changes.

```dart
   /// Inserting and Appending with picking and counting
  
    Tuple
      signalPartA = new Tuple(['38493-23XJ', 34034, false,  382.34, 'counter-service']),
      signalPartB = new Tuple(['south', 384, 823, 399, true]);
  
    Tuple completedSignal1 = signalPartA.intoSplice(signalPartB, isValueBoolean);
  
    print (completedSignal1.toString());
```

_Gives us_ 

```bash
 TupleType.sextuple - [38493-23XJ, 34034, TupleType.quintuple - [south, 384, 823, 399, true], false, 382.34, counter-service]
```

_Oh partB should be after the `bool`._

```dart
    Tuple completedSignal2 = signalPartA.intoSplice(signalPartB, isValueBoolean, before: false);

    print (completedSignal2.toString());
```

_This should be better_

```bash
   TupleType.sextuple - [38493-23XJ, 34034, false, TupleType.quintuple - [south, 384, 823, 399, true], 382.34, counter-service]
```

The original two Tuples are left untouched. When you just need to put to Tuples together, losing the type of second one, you can [concat] them together. 

```dart
   Tuple completedSignal3 = signalPartA.concatWith(signalPartB);
   
   print(completedSignal3.toString());
```

_Gives Us_

```bash
    TupleType.decuple - [38493-23XJ, 34034, false, 382.34, counter-service, south, 384, 823, 399, true]
```

_The content and structure of the Tuple define its equality._

```dart
 /// Grab the content leaving the original untouched.

  int signal04BeforeHash = signal04.hashCode;
  var signal04Contents = signal04(); // Call it like a function and it dumps
  assert(signal04Contents is List);
  assert(signal04Contents.length == signal04.length);
  assert(signal04.every((e) => signal04Contents.contains(e)));
  assert(signal04Contents.every((e) => signal04.contains(e)));
  int signal04AfterHash = signal04.hashCode;
  assert(signal04AfterHash == signal04BeforeHash);

```

_Behaviours like any other object._

```dart
  /// Each Tuple plays well with others.

  assert(signal01 != signal02);
  assert(signal05.toString() == 'TupleType.triple - [SouthPort, true, [394, 3403, 3493, 2303]]');
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
  
```

Distinguishing different Tuple instances with the same content is achieved with the identical function. As equality is not only skin deep,  a Tuple within a Tuple within a Tuple are automatically considered for equality and matching.

```dart
 /// Equals is not skin deep.

  Tuple
    signal06 = new Tuple([true, 23984, false]),
    signal07 = new Tuple([true, 23984, false]),
    signal08 = new Tuple([signal04, signal06]),
    signal09 = new Tuple([new Tuple([3043.398, true, true, false, 'black', 90934, true]), new Tuple([true, 23984, false])]),
    signal10 = new Tuple([new Tuple([3043.398, true, false, false, 'black', 90934, true]),new Tuple([true, 999999, false])]),
    signal11 = new Tuple([true, new DateTime.now(), 49893, 'saber3903', false, 401.34]);


  assert (signal06 == signal07);
  assert (!identical(signal06, signal07));
  assert (signal08 == signal09);
  assert (signal10 != signal09);
  
```

The predicate and matcher library make things rather simple when you want to look inside a Tuple and check it for compliance with to a criterion.

Criteria can be as simple or complex as required.

```dart
 /// We need to be discerning about our tuple, lets define a criteria.

  Tuple validGateSignalCriteria = new Tuple([int, double, bool, String, bool]);

  TupleMatcher isValidGateSignal = criteriaMatcher(validGateSignalCriteria);

  assert(isValidGateSignal(signal01));
  assert(!isValidGateSignal(signal09));
```

_Not just Type limited_

```dart
 /// Sometime Types are not enough and some literals appears.

  Tuple packageTrackingCriteria = new Tuple([double, bool, bool, bool, 'black', int, bool]);

  TupleMatcher isPackageTrackable = criteriaMatcher(packageTrackingCriteria);

  assert(isPackageTrackable(signal04));
  assert(!isPackageTrackable(signal09));
```

_The use case of don't know the threshold until it arrives is another tuple_

```dart
/// Other times it could a threshold that triggers thing off.

  Function thresholdTrigger (double limit){
    bool matcher(double value)=> value > limit ? true : false;
    return matcher;
  }

  Tuple trackingTemperatureTrigger = new Tuple([bool, DateTime, int, String, bool, thresholdTrigger(399.00)]);

  TupleMatcher isTrackableTempOverRange = criteriaMatcher(trackingTemperatureTrigger);

  assert(isTrackableTempOverRange(signal02));
  assert(!isPackageTrackable(signal11));
  
```
The Criteria Tuple is like any other Tuple:  it is the actual Matcher that interprets the Criteria when attempting to match it with a subject Tuple.  Criteria can be deep, complex structure that mixes values, types and functions.Criteria can be deep, complex structure that mixes values, types and functions.

The Matcher is aware of [Optional] from the Quiver Library. The matcher interprets the Optional as meaning that the element does have to present on in the subject. When present the element needs to match the value or type specified in the Optional.

```dart
 /// When things become conditional using optional can get you out of hole.

  Tuple trackCriteria = new Tuple ([String, new Optional.of(int), new Optional.of(true), bool, double]);

  Tuple
    signal12_trackable = new Tuple(['3892-X8349', false, 393.00]),
    signal13_trackable = new Tuple(['90234-Y83', 34948, true, 84.23]),
    signal14_trackable = new Tuple(['34901-B39', 323, true, false, 23.32]),
    signal15_notTrackage = new Tuple (['29023-12', false, true, 30.23]),
    signal16_notTrackage = new Tuple (['230-OU3', 23, false, true, 23.23]);

  TupleMatcher isTrackable = criteriaMatcher(trackCriteria);

  assert(isTrackable(signal12_trackable));
  assert(isTrackable(signal13_trackable));
  assert(isTrackable(signal14_trackable));
  assert(!isTrackable(signal15_notTrackage));
  assert(!isTrackable(signal16_notTrackage));

```

### Limitations
_"So Many Where Do We Start"_

- A embedded criteria Tuple within a Criteria, not bullet proof yet... _This is top property._ 
- No 'Persistence' focused features like 'Atoms', coming in a separate package.
- No Fake Tuple Data Generator, coming in a separate package.
- No performance optimisation and benchmarks yet.
- Can use RegExp in criteria, but no pre-built matchers for things like social-security-number, phone, email, etc.. 

### Alternatives
- [tuple](https://pub.dartlang.org/packages/tuple) provides stronger type implementation, has nice way to layer a tuple within a tuple.
- [duty](https://pub.dartlang.org/packages/duty) provides more then a Tuple but does have type safe containers for a Monuple, Pairple and Triple.
- [vacuum_persistent] (https://pub.dartlang.org/packages/vacuum_persistent) provide a complete persistence with immutable data structures.
- [built_collection] (https://pub.dartlang.org/packages/built_collection) achieves immutability across all the Dart Data Structures via the use of builders.

If a packages should be on this list and is not, just add it via a pull request or rise an [issue](https://github.com/rayk/darpule/issues/new).

[Tuple](https://en.wikipedia.org/wiki/Tuple)
[UnmodifiableListView](https://api.dartlang.org/134830/dart-collection/UnmodifiableListView-class.html)
[Optional](https://www.dartdocs.org/documentation/quiver_optional/1.0.0-dev.1/quiver.optional/Optional-class.html)
[NNBD (Non-null Types & Non-null By Default)](https://github.com/chalin/DEP-non-null)
[migration strategies](https://github.com/chalin/DEP-non-null/blob/master/doc/dep-non-null-AUTOGENERATED-DO-NOT-EDIT.md#part-migration)