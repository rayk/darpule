part of criteriaMatch;

/// Returns a list of matchers for each element of  criteriaTuple.
///
///
/// Picking order is used as mutual exclusive criteria is not present. For
/// example String is a Object and Tuple actually implements list, etc. Added
/// to this a criteria can mix and match any criterion types. So we work from
/// most specific to least specific.
List selectMatchers(Tuple criteria) {

  List elementMatchers = [];
  bool matcherNotSelected;

  void addMatcher(Function matcher) {
    matcherNotSelected = false;
    elementMatchers.add(matcher);
  }

  Function selectCollectionMatcher(var criterion) =>
      isCollectionValueList(criterion)
          ? listValueMatcher(criterion as List)
          : isCollectionValueMap(criterion)
              ? mapValueMatcher(criterion as Map)
              : setValueMatcher(criterion as Set);

  Function selectRunnableMatcher(var criterion) => isPattern(criterion)
      ? patternMatcher(criterion as RegExp)
      : functionResultMatcher(criterion as Function);

  Function selectOptionalValueMatcher(var criterion) {
    return isValueWildOptionally(criterion)
        ? wildValueMatcher()
        : valueMatcher(criterion.value);
  }

  Function selectOptionalTypeMatcher(var criterion) =>
      isTypeWildOptionally(criterion)
          ? wildTypeMatcher(criterion.value as Type)
          : typeMatcher(criterion.value as Type);

  Function selectCollectionTypeMatcher(var criterion) =>
      isCollectionTypeList(criterion)
          ? listTypeMatcher(criterion)
          : isCollectionTypeMap(criterion)
              ? mapTypeMatcher(criterion)
              : setTypeMatcher(criterion);


  for (var criterion in criteria) {
    matcherNotSelected = true;

    if (isValueRunnable(criterion) && matcherNotSelected) {
      addMatcher(selectRunnableMatcher(criterion));
    }

    if (isValueCollection(criterion) && matcherNotSelected) {
      addMatcher(selectCollectionMatcher(criterion));
    }

    if (isValueOptional(criterion) && matcherNotSelected) {
      addMatcher(selectOptionalValueMatcher(criterion));
    }

    if (isTypeOptional(criterion) && matcherNotSelected) {
      addMatcher(selectOptionalTypeMatcher(criterion));
    }

    if (isTypeWildMandatory(criterion) && matcherNotSelected) {
      addMatcher(wildValueMatcher());
    }

    if (isValueWildMandatory(criterion) && matcherNotSelected) {
      addMatcher(wildValueMatcher());
    }

    if (isValue(criterion) && matcherNotSelected) {
      addMatcher(valueMatcher(criterion));
    }

    if (isTypeCollection(criterion) && matcherNotSelected) {
      addMatcher(selectCollectionTypeMatcher(criterion));
    }

    if (isAType(criterion) && matcherNotSelected) {
      addMatcher(typeMatcher(criterion as Type));
    }
  }

  assert(elementMatchers.length == criteria.length);

  return elementMatchers;
}

/// returns a list of the element position which are mandatory in the criteria
List<int> mandatoryCriterionPositions(Tuple criteria) {
  List<int> orderedMandatoryPositions = [];

  for (int i = 0; i < criteria.length; i++) {
    if (isMandatoryCriterion(criteria[i])) {
      orderedMandatoryPositions.add(i);
    }
  }

  return orderedMandatoryPositions;
}

/// Returns a list of all the viable subject lengths for the criteria, accounting
/// for optionals.
List<int> viableSubjectLengths(Tuple criteriaTuple) {
  return new List.generate(
      criteriaTuple.length - criteriaTuple.elementCount + 1,
      (idx) => idx + criteriaTuple.elementCount);
}

