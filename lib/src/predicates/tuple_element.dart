part of predicate;

/// Returns true if a list has been specified in a criteria element;
bool isCollectionTypeList(var element) => element == List ? true : false;

/// Returns true if a Map has been specified in a criteria element;
bool isCollectionTypeMap(var element) => element == Map ? true : false;

/// Returns true if a Set has been specified in a criteria element;
bool isCollectionTypeSet(var element) => element == Set ? true : false;

/// Returns true if the element contain an instance of a list.
bool isCollectionValueList(var element) => element is List ? true : false;

/// Returns true if the element contains an instance of a Map.
bool isCollectionValueMap(var element) => element is Map ? true : false;

/// Returns true if the element contain an instance of a Set.
bool isCollectionValueSet(var element) => element is Set ? true : false;

/// Returns true when element is of type function or an actual function.
bool isFunction(var element) => element is Function ? true : false;

bool isMandatoryCriterion(var element) {
  return (!isTypeOptional(element) && !isValueOptional(element)) ? true : false;
}

/// Returns true if the optional does specify a literal value.
bool isOptionalValued(var element) {
  if (element == Optional) {
    return false;
  } else {
    element as Optional;
    return element.isPresent && !isType(element.value) ? true : false;
  }
}

/// Returns true if the optional does not specify any subsequent values or type.
bool isOptionalWild(var element) {
  if (element == Optional) {
    return true;
  } else {
    element as Optional;
    return element.isPresent ? false : true;
  }
}

/// Return true when the element is an RegExp instance.
bool isPattern(var element) {
  return element is RegExp ? true : false;
}

/// Returns true when element is of the type [Type].
bool isType(var element) => element is Type ? true : false;

/// Returns true when the element is a [Type] and it is a Set, List or Map.
bool isTypeCollection(var element) =>
    element == List || element == Map || element == Set ? true : false;

bool isTypeFunction(Type element) => element == Function;

/// Returns true when element is typed optional or is instance of optional.
bool isTypeOptional(var element) {
  if (element is Optional) {
    return element.isPresent && element.value is Type ? true : false;
  } else {
    return false;
  }
}

/// Returns true when element is of type [Type] and that type is Tuple.
bool isTypeTuple(Type element) => element == Tuple;

/// Returns true when element contains a type of [Object], used as a mandatory wild.
bool isTypeWild(var element) => element is Object ? true : false;

bool isTypeWildMandatory(var element) {
  return element == Type ? true : false;
}

bool isTypeWildOptionally(var element) {
  return element is Optional && element.isPresent && element.value == Type
      ? true
      : false;
}

/// Returns true when the element is a value instance
bool isValue(var element) {
  return !isType(element);
}

/// Returns true when contains an instance of a collection.
bool isValueCollection(var element) =>
    element is List || element is Set || element is Map ? true : false;

bool isValueOptional(var element) {
  return element is Optional && element.isPresent && isValue(element.value)
      ? true
      : false;
}

/// Returns true when element requires some execution like a function or some RegExp
bool isValueRunnable(var element) =>
    element is RegExp || element is Function ? true : false;

/// Returns true when contains an instance of a tuple.
bool isValueTuple(var element) => element is Tuple ? true : false;

bool isValueWildMandatory(var element) {
  return element is Object &&
      element == Object &&
      !isTypeOptional(element) &&
      !isValueOptional(element) &&
      element != Optional ? true : false;
}

bool isValueWildOptionally(var element) {
  return element is Optional && element.isPresent && element.value == Object
      ? true
      : false;
}
