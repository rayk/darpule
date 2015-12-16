library predicate;

import 'dart:core';
import 'package:quiver_optional/optional.dart';
import 'package:darpule/tuple.dart';



part 'tuple_name.dart';
part 'tuple_element.dart';
part 'tuple_attribute.dart';

/// A predicate which operates over the whole Tuple, testing for a given condition.
typedef bool TuplePredicate(Tuple tuple);

