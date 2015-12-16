/// Their two types of matchers those that operator on a single element [ElementMatcher] within
/// a Tuple and those that operate on the tuple [TupleMatcher] as a whole.
///
/// These matcher are often used when iterating a list of tuple or the elements
/// of a particular tuple. To facilitate this they all closure based. Begin by
/// passing into the function what you like to match against. This is the Criterion
/// that the matcher will use to based it [true] or [false].
///
/// The above will return [ElementMatcher] or a [TupleMatcher] primed with your
/// criteria. Then my passing in a Subject Tuple or Subject element a bool will
/// be returned with your match.
library matcher;

export 'src/matchers/matchers.dart';