// Composed file contains predicates which are dependent on the base predicates.
part of Predicate;

// Predicate returns [true] if subject tuple elements matches the element type definition in the pattern tuple.
/// Returns [true] if every element in subject is of the runtime sequence specified.
///
/// Treats [Object] as a wildcard. Errors when subject and pattern
/// do not have same number of elements, except in the case where one or more
/// elements in [pattern] is an [Optional] object type.
///
/// Where [pattern] contains optional and each element false a type match.
///
bool isEachElementMatched(Tuple subject, Tuple pattern) {
  bool matchingResults = false;

  subject.every((e) {
          var subjectElement = e.runtimeType;

          return isElementTypeMatched(
              subjectElement, pattern[subject.indexOf(e)]);
        })
      ? matchingResults = true
      : isMatchedWithInjection(subject, pattern)
          ? matchingResults = true
          : matchingResults = false;

  return matchingResults;
}

/// Test if a the given tuple element type matches the typeCriterion or
/// wildcard [Object] or [Optional] with a type give or [Optional] without a
/// type specified.
///
/// typeCriterion is matched on the runtimeType of the elementValue.
bool isElementTypeMatched(var typeCriterion, var elementValue) {
  if (isExplicitlyTypeMatched(typeCriterion, elementValue)) {
    return true;
  } else {
    return typeCriterion is Optional
        ? isOptionalTypeMatch(typeCriterion, elementValue)
        : false;
  }
  return false;
}

/// Returns [true] if injecting the optional value type into pattern causes the
/// subject elements to match the pattern.
///
/// Handles turning the optional into a concrete so the element that is present
/// can be compared against it.
bool isMatchedWithInjection(Tuple subject, Tuple pattern) {
  if (isFirstElementOptional(pattern)) {
    List modifiedPattern = pattern();
    var convertedType = convertOptionalToType(pattern[0]);
    modifiedPattern.replaceRange(0, 0, [convertedType]);
    return isEachElementMatched(subject, new Tuple(modifiedPattern));
  } else {
    return false;
  }
}

/// Matches a tuple against the criteria given in the first tuple.
///
/// A criteria can be a runtime type a value or function. A match
/// if when each element within the tuple are considered equals. The matching
/// is recursive and descends into a tuple that is embedded in the element
/// of a another tuple.
///
/// The matcher is layer fast fail checker of the tuple.
///
/// Layer 1: isMatchPossible - Given the length of the criteria and subject is
/// match even possible, accounting for the use of optionals in the criteria.
///
/// Layer 2a: isMandatoryPresent - As defined by the criteria are mandatory
/// matching elements present. Those criteria containing optionals are not
/// excluded from this check.
Future<bool> isTupleMatching(Tuple criteria, Tuple subject) async {
  return isMatchPossible(criteria, subject)
      ? await isEachElementMatching(criteria, subject)
      : false;
}

/// Return True if each element of the subject Tuple matches it corresponding
/// criteria element.
///
/// Where the criteria element contains a tuple [isTupleMatching] is called for that
/// element.
Future<bool> isEachElementMatching(Tuple criteria, Tuple subject) async {
  List elementMatchingResult = new List(criteria.length);
  Tuple subjectToMatch;

  isMissingOptionalPossible(criteria, subject)
      ? subjectToMatch = await injectMissingOptionals(criteria, subject)
      : subjectToMatch = new Tuple(subject());

  for (int i = 0; i < criteria.length; i++) {
    var criterion = criteria[i];
    var element = subjectToMatch[i];

    criterion is Tuple
        ? elementMatchingResult[i] = await isTupleMatching(criteria, subject)
        : elementMatchingResult[i] =
            await isElementMatching(criterion, element);
  }

  return elementMatchingResult.contains(false) ? false : true;

}

/// Determines how are particular element should be matched against it's specified
/// criteria.
///
/// Determines which match should be used.
Future<bool> isElementMatching(var criterion, var element) async {
  if (criterion is Type || criterion is Optional) {
    return isElementTypeMatched(criterion, element);
  }

  if (criterion is Function) {
    throw new UnimplementedError('Function Matching not implemented yet!');
  }

  if (criterion is Pattern && element is String) {
    throw new UnimplementedError('Pattern Matching not implemented yet!');
  }

  return criterion == element ? true : false;
}
