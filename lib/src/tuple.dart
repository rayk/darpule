// Copyright (c) 2015, Ray King All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Public API.

library Tuple;

import 'package:collection/wrappers.dart';
import 'package:quiver/collection.dart';
import 'package:quiver_hashcode/hashcode.dart';
import 'package:quiver_optional/optional.dart';

/// Return a [Tuple] with the types of each element of the [subjectTuple].
///
/// This function is used in in pattern matching types in a tuple.
Tuple elementTypesOf(Tuple subjectTuple) {
  List typeList = [];
  for (var elements in subjectTuple) {
    typeList.add(elements.runtimeType);
  }
  return new Tuple(typeList);
}

/// Error that is thrown when code try to modify a tuple.
class MutabilityError implements Error {
  static const message = 'Tuple is immutable! It can not be changed.';

  MutabilityError();

  external StackTrace get stackTrace;

  @override
  toString() {
    return message;
  }
}

/// The immutable class that handles all the tuple types.
///
/// Implementation is based upon extending [UnmodifiableListView] as a backing
/// List, which is created as fixed size and immutable. The write operations and
/// methods have been override as a tuple can not be extended or changed in anyway.
///
/// Calling [call()] the this class as a function returns a copy of the tuple in a list which
/// is mutable.
class Tuple<E> extends UnmodifiableListView<E> {
  /// Generative constructor for the tuple.
  Tuple(Iterable sourceElements)
      : super(new List.from(sourceElements, growable: false));

  /// Returns the number of elements in this tuple.
  /// As [Optional] is not consider to be present until it is not absent
  /// it is not included in the elementCount. This means element != length, in
  /// the event of the tuple including one or more [Optional] elements.
  int get elementCount {
    return this.length - _optionalElementCount();
  }

  // Return number of optional types in tuple so they can excluded
  // from the element count.
  @override
  int get hashCode {
    return hashObjects(this.call());
  }

  /// Returns the enumerated type name of the tuple.
  TupleType get type => TupleType.values[elementCount];

  @override
  bool operator ==(o) {
    return listsEqual(this.call(), o());
  }

  /// Has no effect as a tuple can not be modified or changed.
  @override
  void operator []=(int index, E value) {}

  /// Has no effect as a tuple can not be modified or changed.
  @override
  void add(value) {
    throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void addAll(value) => throw new MutabilityError();

  /// Returns a copy of the elements in this tuple as a mutable list.
  List call() => this.toList();

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  E removeAt(element) {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  E removeLast() {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void removeRange(int start, int end) {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void replaceRange(int start, int end, Iterable<E> iterable) {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    return throw new MutabilityError();
  }

  @override
  toString() {
    StringBuffer strBuf = new StringBuffer();
    strBuf.write(this.type.toString());
    strBuf.write(' - ');
    strBuf.write('${this.call()}');
    return strBuf.toString();
  }

  int _optionalElementCount() {
    var count = this.where((e) => e.runtimeType == Optional);
    return count.length;
  }
}

/// Tuple types, enumeration of tuple type names contains zero to sixteen elements.
///
/// Provided are not only the constant types, the ordering is aligned so the index
/// of the enumerated type is relates to the number of elements the tuple holds.
///
/// A nulluple contain zero elements, hence [TupleType.nulluple] has an index of
/// zero.
///
/// _ Note the document generator gets this wrong, hence the index numbers are off +1
/// there are test cases that verify this dependence._
///
enum TupleType {
  /// Tuple with no elements
  nulluple,

  /// Tuple with one and only one elements.
  monuple,

  /// Tuple with two and only two elements.
  pairple,

  /// Tuple with three and only three elements.
  triple,

  /// Tuple with three and only four elements.
  quadruple,

  /// Tuple with five and only five elements.
  quintuple,

  /// Tuple with three and only six elements.
  sextuple,

  /// Tuple with three and only seven elements.
  septuple,

  /// Tuple with eight and only eight elements.
  octuple,

  /// Tuple with nine and only nine elements.
  nonuple,

  /// Tuple with three and only ten elements.
  decuple,

  /// Tuple with three and only eleven elements.
  hendecuple,

  /// Tuple with three and only twelve elements.
  duodecuple,

  /// Tuple with three and only thirteen elements.
  tredecuple,

  /// Tuple with three and only fourteen elements.
  quattuordecuple,

  /// Tuple with three and only fifteen elements.
  quindecuple,

  /// Tuple with three and only sixteen elements.
  sexdecuple,
}
