part of Predicates;

/// Returns [true] if the tuple contains one or more optionals.
///
/// Iterates the tuple looking for an element which contains an instance
/// of [Optional].
bool isOptionalPresent(Tuple tuple) {
  return tuple.length - tuple.elementCount == 0 ? false : true;
}

/// Returns [true] if any the [Tuple] elements contains another tuple.
bool isTupleLeaf(Tuple tuple) {
  return (tuple.where((e) => e is Tuple).length) > 0 ? false : true;
}

/// Returns [true] is any of the [Tuple] elements contains a wildcard
