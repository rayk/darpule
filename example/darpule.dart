// Copyright (c) 2015, Ray King. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library darpule.example;

import 'package:darpule/src/predicate.dart';
import 'package:darpule/src/tuple.dart';

main() {
  /// Created very ad-hoc.

  List resultFromSomeWhere = ['Longhaul', 382, 982.23, false];

  Tuple payload = new Tuple(resultFromSomeWhere);

  assert(payload is Tuple);
  assert(payload.type == TupleType.quadruple);
  assert(payload.elementCount == 4);

  /// Tuple can hold anything.
  Tuple collective = new Tuple([
    true,
    new Tuple([343, false]),
    new DateTime.now()
  ]);

  assert(collective is Tuple);
  assert(collective.type == TupleType.triple);

  /// Hash and Equals behaviour

  assert(collective != payload);

  Tuple sameContent1 = new Tuple([3902, 'happy']);
  Tuple sameContent2 = new Tuple([3902, 'happy']);

  assert(sameContent1 == sameContent2); // They have same elements.
  assert(identical(sameContent1, sameContent2) == false); // But are unique.

  Tuple notSameContent = new Tuple([8827, 'sad']);

  Tuple deepLikeness = new Tuple(['skindeep', sameContent1]);
  Tuple deeperLikeness = new Tuple(['skindeep', sameContent1]);
  Tuple downDeep = new Tuple(['skindeep', notSameContent]);

  assert(deepLikeness == deeperLikeness);
  assert(downDeep != deepLikeness);

  /// Tuple is Immutable, trying results in an programming error.

  try {
    payload.add('WantToAddElement');
  } catch (error) {
    assert(error is MutabilityError);
  }

  try {
    payload.addAll(['doctor', 'drugs']);
  } catch (error) {
    assert(error is MutabilityError);
  }

  try {
    payload.removeAt(0);
  } catch (error) {
    assert(error is MutabilityError);
  }

  /// Ways to get a tuple elements

  assert(collective[0] == true); // Using element position number.

  List tupleContent = notSameContent(); // Call your tuple like a function.

  assert(tupleContent[0] == 8827 && tupleContent[1] == 'sad');

  tupleContent.add('Now we can mutate the resulting list');

  Tuple notSameContentWithMore = new Tuple(tupleContent); // Back to a tuple.

  assert(notSameContentWithMore is Tuple);
  assert(notSameContent.type == TupleType.pairple);
  assert(notSameContentWithMore.type == TupleType.triple);

  Tuple payloadElementTypes = elementTypesOf(payload);

  assert(payloadElementTypes[0] == String);
  assert(payloadElementTypes[1] == int);
  assert(payloadElementTypes[2] == double);
  assert(payloadElementTypes[3] == bool);

  /// Predicate can help you answer some questions about the Tuple.

  assert(isSepTuple(payload) == false); // No it does not have 7 elements.
  assert(isQuadruple(payload) == true); // Yes it does have 4 elements
  assert(isSexdecuple(payload) == false); // No it does not have 16 elements.
  assert(isLeaf(deepLikeness) == false); // No one of elements is a Tuple.
  assert(isLeaf(sameContent1) == true); // Yes, no other tuple are inside.

  /// Looking inside for a pattern.

  Tuple strictPattern = new Tuple([String, int, double, bool]);
  Tuple loosePattern = new Tuple([String, Object, double, Object]);

  assert(isTupleTypeMatched(payload, strictPattern) == true);
  assert(isTupleTypeMatched(payload, loosePattern) == true);

  /// Sometimes you don't get what you want.

  Tuple expectedTuplePattern = new Tuple([String, int, int, bool]);
  assert(isTupleTypeMatched(payload, expectedTuplePattern) == false);

  /// Sometimes you don't get enough of what you want.

  Tuple veryLoosePattern = new Tuple([Object, Object, Object, Object, Object]);
  assert(isTupleTypeMatched(payload, veryLoosePattern) == false);

  /// Real life is fuzzy

  Tuple acceptableStandard =
      new Tuple([String, int, double, Object, new Optional.of(bool)]);
  assert(isTupleTypeMatched(payload, acceptableStandard) == true);

  Tuple lowerStandard = new Tuple([String, new Optional.of(int), double, bool]);
  assert(isTupleTypeMatched(payload, lowerStandard) == true);

  Tuple differentStandard =
  new Tuple([new Optional.of(String), int, double, bool]);
  assert(isTupleTypeMatched(payload, differentStandard) == true);
}
