part of criteriaMatch;

/// Returns all the possible combination of matchers that would be valid for
/// the criteria.
///
/// A Criteria Tuple can contains optionals, which by their nature could
/// vary the length and ordering of what is considered a subject tuple match.

matcherCombinations(Tuple criteriaTuple, CriteriaMatrix matchers) {
  List combinationLengths = new List.generate(
      criteriaTuple.length - criteriaTuple.elementCount + 1,
      (idx) => idx + criteriaTuple.elementCount);
}


