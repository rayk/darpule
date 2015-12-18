library darpule.matchers.combiner;

import 'package:darpule/tuple.dart';

// Clean up needed..

List combine(int sequenceLength, Tuple criteria, List mandatoryElements) {
  assert(mandatoryElements.length <= criteria.length);
  List result = [];
  List criteriaElements =
      new List.generate(criteria.length, (int element) => element++);
  var allCombinations = new Combinations(sequenceLength, criteriaElements);

  assert(allCombinations.length > 0);

  for (int i = 0; i < allCombinations.length; i++) {
    List selectedCombination = new List.from(allCombinations[i]);
    assert(selectedCombination.length == sequenceLength);
    int mandatoryCounter = 0;

    for (int c = 0; c < mandatoryElements.length; c++) {
      if (selectedCombination.contains(mandatoryElements[c])) {
        mandatoryCounter++;
      }
    }

    if (mandatoryCounter == mandatoryElements.length) {
      result.add(selectedCombination);
    }
  }

  return result;
}

abstract class _Combinatorics {
  List _elements;
  int _length;

  /// The list from which the objects are selected
  List get elements => new List.from(_elements, growable: false);

  /// The number of arrangements "contained" in this pseudo-list.
  int get length => _length;

  /// The kth arrangement.
  List operator [](int k);

  /**
   * Returns a range of arrangements.
   *
   * The arrangements "stored" in this pseudo-list from index `[from]`
   * up to but not including `[to]`.
   *
   */
  List range([int from = 0, int to = -1]) {
    if (to == -1) to = length;
    return new List.generate(to - from, (int i) => this[from + i]);
  }
}

class Combinations extends _Combinatorics {
  int _r;

  /// The number of items taken from [elements].
  int get r => _r;

  Combinations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _nCr(elements.length, r);
  }

  @override List operator [](int k) =>
      _combination(_adjustedIndex(k, length), r, elements);

  @override String toString() =>
      "Pseudo-list containing all $length $r-combinations of items from $elements.";
}

Map<int, int> _factCache = {};

int _fact(int n) => _factCache.containsKey(n)
    ? _factCache[n]
    : (n < 2 ? 1 : _factCache[n] = n * _fact(n - 1));

int _nPr(int n, int r) => _fact(n) ~/ _fact(n - r);

int _nCr(int n, int r) => _nPr(n, r) ~/ _fact(r);

List _combination(int k, int r, List elements) {
  int n = elements.length, position = 0, d = _nCr(n - position - 1, r - 1);

  while (k >= d) {
    k -= d;
    ++position;
    d = _nCr(n - position - 1, r - 1);
  }

  if (r == 0)
    return [];
  else {
    List tail = elements.sublist(position + 1);
    return [elements[position]]..addAll(_combination(k, r - 1, tail));
  }
}

int _adjustedIndex(int k, int n) {
  while (k < 0) k += n;
  k %= n;
  return k;
}
