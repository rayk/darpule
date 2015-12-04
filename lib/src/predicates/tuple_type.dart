part of Predicates;

/// Predicate that returns [true] when the [Tuple] contains exactly ten elements.
///
/// Can be negated with [!] operator.
bool isDecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.decuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly twelve elements.
///
/// Can be negated with [!] operator.
bool isDuodecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.duodecuple.index ? true : false;


/// Predicate that returns [true] when the [Tuple] contains exactly eleven elements.
///
/// Can be negated with [!] operator.
bool isHendecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.hendecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly one elements.
///
/// Can be negated with [!] operator.
bool isMonuple(Tuple tuple) =>
    tuple.elementCount == TupleType.monuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly nine elements.
///
/// Can be negated with [!] operator.
bool isNonuple(Tuple tuple) =>
    tuple.elementCount == TupleType.nonuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly zero elements.
///
/// Can be negated with [!] operator.
bool isNulluple(Tuple tuple) =>
    tuple.elementCount == TupleType.nulluple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly eight elements.
///
/// Can be negated with [!] operator.
bool isOctuple(Tuple tuple) =>
    tuple.elementCount == TupleType.octuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly two elements.
///
/// Can be negated with [!] operator.
bool isPairple(Tuple tuple) =>
    tuple.elementCount == TupleType.pairple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly four elements.
///
/// Can be negated with [!] operator.
bool isQuadruple(Tuple tuple) =>
    tuple.elementCount == TupleType.quadruple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly fourteen elements.
///
/// Can be negated with [!] operator.
bool isQuattuordecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.quattuordecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly fifteen elements.
///
/// Can be negated with [!] operator.
bool isQuindecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.quindecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly five elements.
///
/// Can be negated with [!] operator.
bool isQuinTuple(Tuple tuple) =>
    tuple.elementCount == TupleType.quintuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly seven elements.
///
/// Can be negated with [!] operator.
bool isSepTuple(Tuple tuple) =>
    tuple.elementCount == TupleType.septuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly sixteen elements.
///
/// Can be negated with [!] operator.
bool isSexdecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.sexdecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly six elements.
///
/// Can be negated with [!] operator.
bool isSexTuple(Tuple tuple) =>
    tuple.elementCount == TupleType.sextuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly thirteen elements.
///
/// Can be negated with [!] operator.
bool isTredecuple(Tuple tuple) =>
    tuple.elementCount == TupleType.tredecuple.index ? true : false;

/// Predicate that returns [true] when the [Tuple] contains exactly three elements.
///
/// Can be negated with [!] operator.
bool isTriple(Tuple tuple) =>
    tuple.elementCount == TupleType.triple.index ? true : false;
