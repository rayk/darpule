library criteriaMatch;

import 'package:darpule/matcher.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';



import 'package:darpule/src/matchers/criteria/combiner/combine.dart';

part 'matrix_projection.dart';

/// Contains a  matcher for each element in a CriteriaTuple, by passing in a element it
/// returns true if the element matches the criterion for the specified subject
/// element position, in the criteriaTuple.          criteria
typedef bool CriteriaMatrix(int elementPosition, var elementValue);



/// Generate a matrix of all the possible sequence of matchers.
///
/// This is only done once at when a criteria matcher is created.
Map generateMatchMatrix(Tuple criteria) {

  Map matrix = new Map();
  List matcherSequence = selectMatchers(criteria);
  List<int> mandatories = mandatoryCriterionPositions(criteria);
  List<int> viableLengths = viableSubjectLengths(criteria);

  for (int i = 0; i < viableLengths.length; i++) {
    List<int> matchingCombination =
        combine(viableLengths[i], criteria, mandatories);
    matrix.addAll({viableLengths[i]: matchingCombination});
  }

  matrix.addAll({'matchers': matcherSequence});

  return matrix;
}

/// Returns true if the subject is a match to one of the criteria sequences within
/// the matrix.
///
/// Returns as soon as possible. Break and fail early.
bool subjectMatchesCriteria(Map matrix, Tuple subject) {
  bool subjectMatches = false;

  assert(matrix.keys.length >= 2);

  if (matrix.containsKey(subject.length)) {
    List<ElementMatcher> criteriaMatchers = matrix['matchers'];
    List<List<int>> matcherCombinations = matrix[subject.length];

    assert(criteriaMatchers.length >= subject.length);

    // Tries one combination at a time.
    for (List combination in matcherCombinations) {
      List<ElementMatcher> matcher = [];

      for (int i = 0; i < combination.length; i++) {
        matcher.add(criteriaMatchers[combination[i]]);
      }

      int matchCounter = 0;

      assert(matcher.length == subject.length);

      // Attempt element by match, breaking on first false.
      for (int m = 0; m < matcher.length; m++) {
        if (!matcher[m](subject[m])) {
          subjectMatches = false;
          break;
        } else {
          matchCounter++;
        }
      }

      // There as many matches as elements in the subject. Stop and breakout.
      if (matchCounter == subject.length) {
        subjectMatches = true;
        break;
      }
    }
  }
  return subjectMatches;
}
