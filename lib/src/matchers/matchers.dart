library matchers;

import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';
import 'package:quiver_collection/collection.dart';
import 'critieria/critieria_matcher.dart';

/// Return true if the Subject Tuple is a match against the defined collection of criterion.
///
/// This is complex matcher able to handle [Optional], mandatory and wildcard
/// criterion, hence able to match against various length of subject and workout
/// if the subject is match considering the rules defined in the Criteria tuple.
TupleMatcher criteriaMatcher(Tuple tupleCriteria) {
  Map matchingMatrix = generateMatchMatrix(tupleCriteria);
  bool matcher(Tuple subject){
    subjectMatchForCriteria(matchingMatrix, subject) ? true : false;
    return false;
  };
  return matcher;
}

/// Return true if the criterion evaluates to true.
///
/// Criterion is closed over when the matcher is picked.
ElementMatcher functionResultMatcher(Function functionCriterion) {
  bool matcher(var subjectElement) =>
      functionCriterion(subjectElement) ? true : false;
  return matcher;
}

/// Returns true an instance of the collection is a list, there is no attempt
/// at comparison.
ElementMatcher listTypeMatcher(Type collectionType) {
  bool matcher(var element) {
    return element is List ? true : false;
  }
  return matcher;
}

/// Returns true when the subject list matches that of the criterion.
///
/// Criterion is closed over when the matcher is picked.
ElementMatcher listValueMatcher(List listCriterion) {
  bool matcher(List elementList) => listsEqual(listCriterion, elementList);
  return matcher;
}

/// Returns true if an instance of Map exist, there is no attempt at comparison.
ElementMatcher mapTypeMatcher(Type collectionType) {
  bool matcher(var element) {
    return element is Map ? true : false;
  }
  return matcher;
}

/// Returns true when the subject map matches the values in the criterion map.
///
/// Criterion is closed over when the matcher is picked.
ElementMatcher mapValueMatcher(Map mapCriterion) {
  bool matcher(Map elementMap) => mapsEqual(mapCriterion, elementMap);
  return matcher;
}

/// Returns true when regular express matches one of parts of the subject element.
///
/// Criterion is closed over when the matcher is picked.
ElementMatcher patternMatcher(RegExp patternToMatch) {
  bool matcher(String element) {
    Iterable matches = patternToMatch.allMatches(element);
    return matches.isNotEmpty ? true : false;
  }
  return matcher;
}

/// Return true if an instance of Set exist, there is not attempt at comparison.
ElementMatcher setTypeMatcher(Type collectionType) {
  bool matcher(var element) {
    return element is Set ? true : false;
  }
  return matcher;
}

/// Returns true when subject set matches the values in the criterion set.abstract
///
/// /// Criterion is closed over when the matcher is picked.
ElementMatcher setValueMatcher(Set setCriterion) {
  bool matcher(Set elementSet) => setsEqual(setCriterion, elementSet);
  return matcher;
}

/// Returns true when runtime type of the subject element matches criterion.
///
/// Criterion is closed over when the matcher is picked.
ElementMatcher typeMatcher(Type typeCriterion) {
  bool matcher(var element) =>
      element.runtimeType == typeCriterion ? true : false;
  return matcher;
}

/// Returns true when the value of the element matches that of the criterion.
///
/// Criterion is closed over when the matcher is picked.
ElementMatcher valueMatcher(var valueCriterion) {
  bool matcher(var subjectElement) => subjectElement == valueCriterion;
  return matcher;
}

/// Returns true when subject element contains an Object which is not null.
///
/// Criterion is closed over when the matcher is picked.
ElementMatcher wildTypeMatcher(Type wildType) {
  bool matcher(var element) =>
      element != null && isValue(element) ? true : false;
  return matcher;
}

ElementMatcher wildValueMatcher() {
  bool matcher(var element) =>
      element != null && isValue(element) ? true : false;
  return matcher;
}

/// Returned from a matcher functions which encloses a criterion within this element matcher.
typedef bool ElementMatcher(var element);

/// Matches a whole tuple against a criteria using the interpretations rules given
/// matching Strategy and criteria matrix.
typedef bool TupleMatcher(Tuple subjectTuple);
