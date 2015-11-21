// Copyright (c) 2015, Ray King. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Public API.
library Predicate;

import 'tuple.dart';
import 'package:quiver_optional/optional.dart';

/// Collection of the most basic predicates.
///
/// This can be composed together to come up with criteria or rules that suit
/// characterises of the subject which is important.

/// Predicate that returns [true] when the [Tuple] contains exactly ten elements.
///
/// Can be negated with [!] operator.
bool isDecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.decuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly twelve elements.
///
/// Can be negated with [!] operator.
bool isDuodecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.duodecuple.index ? true : false;

/// Predicate that returns [true] when both tuple 1 and tuple 2 contains the same number of elements.
///
/// This is based upon calling [elementCount] on the [Tuple], hence
/// it is not a comparison on length.
bool isElementCountEqual(Tuple tuple1, Tuple tuple2) {
  return tuple1.elementCount == tuple2.elementCount ? true : false;
}

/// Test if a tuple element matches the pattern element or wildcard [Object]
bool isElementTypeMatch(Type tupleElement, Type patternElement) {
  return tupleElement == patternElement ||
      patternElement == Object ||
      patternElement == Optional ? true : false;
}

/// Predicate that returns [true] when the [Tuple] contains exactly eleven elements.
///
/// Can be negated with [!] operator.
bool isHendecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.hendecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] does not contain another tuple.
bool isLeaf(Tuple tuple) => tuple.any((e) => isTuple(e)) ? false : true;

/// Predicate that returns [true] when the [Tuple] contains exactly one elements.
///
/// Can be negated with [!] operator.
bool isMonuple(Tuple tuple) =>
    tuple.elementCount == TupleType.monuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly nine elements.
///
/// Can be negated with [!] operator.
bool isNonuple(Tuple tuple) =>
    tuple.elementCount == TupleType.nonuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly zero elements.
///
/// Can be negated with [!] operator.
bool isNulluple(Tuple tuple) =>
    tuple.elementCount == TupleType.nulluple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly eight elements.
///
/// Can be negated with [!] operator.
bool isOctuple(Tuple tuple) =>
    tuple.elementCount == TupleType.octuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly two elements.
///
/// Can be negated with [!] operator.
bool isPairple(Tuple tuple) =>
    tuple.elementCount == TupleType.pairple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly four elements.
///
/// Can be negated with [!] operator.
bool isQuadruple(Tuple tuple) =>
    tuple.elementCount == TupleType.quadruple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly fourteen elements.
///
/// Can be negated with [!] operator.
bool isQuattuordecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.quattuordecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly fifteen elements.
///
/// Can be negated with [!] operator.
bool isQuindecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.quindecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly five elements.
///
/// Can be negated with [!] operator.
bool isQuinTuple(Tuple tuple) =>
    tuple.elementCount == TupleType.quintuple.index ? true : false;

/// Returns [true] if every element in subject is of the runtime sequence specified.
///
/// Treats [Object] as a wildcard. Errors when subject and pattern
/// do not have same number of elements, except in the case where one or more
/// elements in [pattern] is an [Optional] object type.
bool isEachElementMatched(Tuple subject, Tuple pattern) {
  Tuple mutableSubject = subject;

  if (pattern.contains(Optional)) {
    Iterable optElements = pattern.where((e) => e.runtimeType == Optional);
    List optionalElements = optElements.toList(growable: false);
    for (var option in optionalElements) {
      mutableSubject.insert(optionalElements.indexOf(option), Object);
    }
  }
  return mutableSubject.every(
      (e) => isElementTypeMatch(e.runtimeType, pattern[subject.indexOf(e)]));


}

/// Predicate that returns [true] when the [Tuple] contains exactly seven elements.
///
/// Can be negated with [!] operator.
bool isSepTuple(Tuple tuple) =>
    tuple.elementCount == TupleType.septuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly sixteen elements.
///
/// Can be negated with [!] operator.
bool isSexdecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.sexdecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly six elements.
///
/// Can be negated with [!] operator.
bool isSexTuple(Tuple tuple) =>
    tuple.elementCount == TupleType.sextuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly thirteen elements.
///
/// Can be negated with [!] operator.
bool isTredecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.tredecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly three elements.
///
/// Can be negated with [!] operator.
bool isTriple(Tuple tuple) =>
    tuple.elementCount == TupleType.triple.index ? true : false;

/// Predicate that returns [true] when the passed in element is a Tuple.
bool isTuple(var element) => element is Tuple ? true : false;

/// Predicate returns [true] if subject tuple elements matches the element type definition in the pattern tuple.
///
/// A subject tuple is considered a match against the pattern tuple when both following conditions are true:
///
/// 1. When subject contains the same number elements as pattern _(The Optional types in pattern are not counted, Object wildcard is counted)_.
///
/// 2. When each elements type in subject matches the type defined in pattern. _(Absent optional element are considered to be present with correct type)_
///
/// The wildcard [Object] in a pattern means the element must be present in the subject, its type does not matter.
/// Whereas [Optional] means the element does not have to present to match, yet if it is present it's type is evaluated.
///
/// The tail condition of [Optional] can be negated by specifying the type of the optional is actually a wildcard, hence [Object]. This will cause any type in an optional to match.
bool isTupleTypeMatched(Tuple subject, Tuple pattern) {
  return isElementCountEqual(subject, pattern)
      ? isEachElementMatched(subject, pattern) ? true : false
      : false;
}

/// Determines if the subject tuple needs enchantment.
bool _subjectRequiresInjection(Tuple subject, Tuple pattern) {
  return false;
}


