// Transforms used as part of predicates.
part of Predicate;

/// Returns a new [Tuple] that has it's missing optional elements injected.
///
/// The original Tuple is returned in the event that no injection is called for.
///
/// The injection is made in the position and of Optional.value. The following
/// rule are observed when injecting.
/// 1. Only inject as many elements that are missing. (Not all Optionals are injected)
/// 2. If the element in the intended position is the same as injection.
Future<Tuple> injectMissingOptionals(Tuple criteria, Tuple subject) async {
  // Early Exist.
  if (isOptionalPresent(criteria) && (criteria.length == subject.length) ||
      !isOptionalPresent(criteria)) {
    return subject;
  }
  int injectionsRequired = criteria.length - subject.elementCount;

  // Base of return tuple.
  List injectTarget;
  subject.type == TupleType.nulluple
      ? injectTarget = new List(criteria.length)
      : injectTarget = subject();

  // Injection into fixed and variable length List
  void injectIntoTarget(int position, var value) {
    try {
      injectTarget.insert(position, value);
    } catch (UnsupportedError) {
      injectTarget[position] = value;
    } finally {
      injectionsRequired--;
    }
  }

  // Lookup injection value for Type.
  injectionValue(Type type) {
    Map typeValue = {
      int: 343,
      String: "String",
      double: 0.00,
      bool: true,
      Tuple: new Tuple([])
    };
    return typeValue[type];
  }
  ;

  // Actual type criterion for the element position
  Type criterionType(int elementPosition) {
    if (criteria[elementPosition] is Optional) {
      return criteria[elementPosition].isPresent
          ? criteria[elementPosition].value
          : Object;
    }
    return criteria[elementPosition];
  }

  /// Returns true if passed in element appears to contains the optional value
  bool isOptionalValuePresent(int elementPosition) {
    // Optional is for a position not existing in subject.
    bool isElementBeyondSubjectLength(int pos) =>
        (pos) >= subject.length ? true : false;

    // If there is element for the criterion does the type match.
    bool isElementCriterionMatch(int position) =>
        isElementBeyondSubjectLength(position)
            ? false
            : subject[position].runtimeType == criterionType(position)
                ? true
                : false;

    bool isAdjacentCriterion(int adjacentPosition) =>
        adjacentPosition <= criteria.length ? true : false;

    bool isCriterionOptional(int position) =>
        criteria[position] is Optional ? true : false;

    /// Heuristic A: If the element type matches that of the criterion and there is
    /// mandatory neighbouring criterion for same type. Assume the element present
    /// was intended to match that mandatory, therefore report the optional value
    /// as not present.
    if (isElementCriterionMatch(elementPosition) &&
        isAdjacentCriterion(elementPosition + 1) &&
        !isCriterionOptional(elementPosition + 1) &&
        criterionType(elementPosition) == criterionType(elementPosition + 1)) {
      return false;
    }

    /// Heuristic B: If the element type matches that of the criterion and there
    /// is a optional neighbouring criterion's look pass those for a matching
    /// mandatory which does not have matching element type. Assuming here that
    /// as the optionals are inserted, the current type will match the mandatory.
    /// Hence we will report the optional vale as not present.
    if(isElementCriterionMatch(elementPosition) && isAdjacentCriterion(elementPosition + 1)){
      if (subject[elementPosition].runtimeType == criterionType(elementPosition + 2)) {
        return false;
      } else {
        return true;
      }
    }

    /// Final Heuristic: All other heuristic not being applicable and the element
    /// type matches that specified by the optional. Assume the element present
    /// was intended to the optional, therefore report the optional value a present.
    if (isElementCriterionMatch(elementPosition)) {
      return true;
    }

    return false;
  }

  bool isInjectionDiscardable(int i) =>
      injectionsRequired > (criteria.length - i) ? true : false;

  for (int i = 0; i < criteria.length; i++) {
    if (injectionsRequired > 0 &&
        criteria[i] is Optional &&
        criteria[i].isPresent) {
      if (isOptionalValuePresent(i)) {
        if (isInjectionDiscardable(i)) {
          injectionsRequired--;
        }
      } else {
        injectIntoTarget(i, injectionValue(criteria[i].value));
      }
    } else {
      if (injectionsRequired > 0 &&
          criteria[i] is Optional &&
          !criteria[i].isPresent) {
        injectIntoTarget(i, 'Untyped Optional Value');
      }
    }
  }

  return new Tuple(injectTarget);
}
