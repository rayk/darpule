part of Predicates;

bool areElementsFunctionallyMatched(var element1, var element2) {
  if (isElementFunction(element1) && isElementFunction(element2)) {
    return element1 == element2 ? true : false;
  } else {
    throw new ArgumentError('Both elements should be funcitons.');
  }
}

bool areElementsFunctionallyTrue(Function function, var element) {
  try {
    return function(element) == true ? true : false;
  } catch (e) {
    throw e;
  }
}

bool areElementsLiteralMatched(var element1, var element2) {
  if (isElementLiteral(element1) && isElementLiteral(element2)) {
    return element1 == element2 ? true : false;
  } else {
    throw new ArgumentError('Both element should be literals');
  }
}

bool areElementsOfType(Type type, Iterable elements) =>
    elements.where((e) => e.runtimeType == type).length == elements.length
        ? true
        : false;

bool areElementsOptionallyMatched(var optionalSpec, var subjectElement) {
  if (isElementOptional(optionalSpec)) {
    return isOptionalElementTyped(optionalSpec) &&
            optionalSpec.value == subjectElement.runtimeType ||
        isOptionalElementValued(optionalSpec) &&
            optionalSpec.value == subjectElement ||
        isOptionalElementFunction(optionalSpec) &&
            areElementsFunctionallyTrue(optionalSpec.value, subjectElement) ||
        isOptionalElementWild(optionalSpec) &&
            subjectElement != null ? true : false;
  } else {
    throw new ArgumentError('The frist argument must be an optional');
  }
}

bool areElementsInCollectionMatched(var collect1, var collect2) {
  List _mapToList(Map map) => new List.from(map.values, growable: false);

  List _setToList(Set set) => set.toList(growable: false);

  if (isElementCollection(collect1) && isElementCollection(collect2)) {
    if (collect1 is List && collect2 is List) {
      return listsEqual(collect1, collect2);
    }
    if (collect1 is List && collect2 is Set) {
      return listsEqual(collect1, _setToList(collect2));
    }
    if (collect1 is List && collect2 is Map) {
      return listsEqual(collect1, _mapToList(collect2));
    }

    if (collect1 is Map && collect2 is Map) {
      return mapsEqual(collect1, collect2);
    }
    if (collect1 is Map && collect2 is List) {
      return listsEqual(_mapToList(collect1), collect2);
    }
    if (collect1 is Map && collect2 is Set) {
      return listsEqual(_mapToList(collect1), _setToList(collect2));
    }

    if (collect1 is Set && collect2 is Set) {
      return setsEqual(collect1, collect2);
    }
    if (collect1 is Set && collect2 is Map) {
      return listsEqual(_setToList(collect1), _mapToList(collect2));
    }
    if (collect1 is Set && collect2 is List) {
      return listsEqual(_setToList(collect1), collect2);
    }
  } else {
    throw new ArgumentError('Do not understand these collection types.');
  }
}

bool areElementsTypeMatched(var element1, var element2) =>
    element1.runtimeType == element2.runtimeType ? true : false;

bool isElementFunction(var element) => element is Function ? true : false;

bool isElementLiteral(var element) => (element is! Type) ? true : false;

bool isElementCollection(var element) =>
    (element is List || element is Map || element is Set) ? true : false;

bool isElementOptional(var element) => (element is Optional) ? true : false;

bool isElementPattern(var element) => (element is RegExp) ? true : false;

bool isElementTuple(var element) => (element is Tuple) ? true : false;

bool isElementType(var element) => element is Type ? true : false;

bool isOptionalElementTyped(Optional element) =>
    (element.isPresent && isElementType(element.value)) ? true : false;

bool isOptionalElementValued(Optional element) =>
    (element.isPresent && isElementLiteral(element.value)) ? true : false;

bool isOptionalElementWild(Optional element) =>
    !isOptionalElementValued(element) && !isOptionalElementTyped(element)
        ? true
        : false;

bool isOptionalElementFunction(Optional element) =>
    (element.isPresent && isElementFunction(element.value)) ? true : false;
