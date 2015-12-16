part of criteriaMatch;

/// Returns a function that can match each element in a subject against a criteriaTuple.
///
/// Each matcher closes over a criterion and is placed in a list with a corresponding
/// criterion element. The returned function takes a subject element and it's position
/// within the subject tuple. Where the elements match the criteria a true is
/// returned else false.
///
/// Picking order is used as mutual exclusive criteria is not present. For
/// example String is a Object and Tuple actually implements list, etc. Added
/// to this a criteria can mix and match any criterion types. So we work from
/// most specific to least specific.
CriteriaMatrix criteriaProjection(Tuple criteriaTuple) {
  List<ElementMatcher> criteriaMatchers = [];
  bool matcherNotSelected;

  void addMatcher(Function matcher) {
    matcherNotSelected = false;
    criteriaMatchers.add(matcher);
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

  for (var criterion in criteriaTuple) {
    matcherNotSelected = true;

    if (isValueTuple(criterion)) {
      addMatcher(criteriaProjection(criterion as Tuple));
    }

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

    if (isType(criterion) && matcherNotSelected) {
      addMatcher(typeMatcher(criterion as Type));
    }
  }

  assert(criteriaMatchers.length == criteriaTuple.length);
  bool matcher(int position, var element) {
    Function elementMatcher = criteriaMatchers[position];
    return elementMatcher(element);
  }

  return matcher;
}

