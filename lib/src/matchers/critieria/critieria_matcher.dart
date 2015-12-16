library criteriaMatch;

import 'package:darpule/matcher.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';

part 'projection.dart';
part 'matrix_projection.dart';

/// Contains a  matcher for each element in a CriteriaTuple, by passing in a element it
/// returns true if the element matches the criterion for the specified subject
/// element position, in the criteriaTuple.          criteria
typedef bool CriteriaMatrix(int elementPosition, var elementValue);

generateMatchMatrix(criteria) {
  Map matrix = new Map();

  /// Get a full set of projected matchers.
  /// Corresponding list of Mandatory and optional based on elements of matchers
  /// Generate mandatory List.
  /// call combined for each sequence length and build map.

  return matrix;
}

bool subjectMatchForCriteria(Map matrix, Tuple subject) {
  /// Min & Max Length from matrix.
  /// Check if subject is that range, if not reject.
  /// Check the subject against each of the matching sequences, early exit
  /// Matching sequence, early exit returning true;

  return false;
}
