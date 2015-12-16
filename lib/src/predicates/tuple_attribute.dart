part of predicate;

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

/// Returns true if the length of the subject maybe a match for criteria
/// accounting for any Optional types is criteria.
bool isTupleLengthComparable(Tuple criteria, Tuple subject) {
  int subjectElements = subject.elementCount;
  int criteriaMinLength = criteria.elementCount;
  int criteriaMaxLength = criteria.length;

  return subjectElements >= criteriaMinLength &&
      subjectElements <= criteriaMaxLength ? true : false;
}
