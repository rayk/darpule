library Tuple;

import 'package:collection/wrappers.dart';
import 'package:quiver_collection/collection.dart';
import 'package:quiver_hashcode/hashcode.dart';


/// Return a [Tuple] with the types of each element of the [subjectTuple].
///
/// This function is used in in pattern matching types in a tuple.
Tuple elementTypesOf(Tuple subjectTuple) {
  List typeList = [];
  for (var elements in subjectTuple) {
    typeList.add(elements.runtimeType);
  }
  return new Tuple(typeList);
}

/// Error that is thrown when code try to modify a tuple.
class MutabilityError implements Error {
  static const message = 'Tuple is immutable! It can not be changed.';

  MutabilityError();

  external StackTrace get stackTrace;

  @override
  toString() {
    return message;
  }
}

/// The immutable class that handles all the tuple types.
///
/// Implementation is based upon extending [UnmodifiableListView] as a backing
/// List, which is created as fixed size and immutable. The write operations and
/// methods have been override as a tuple can not be extended or changed in anyway.
///
/// Calling [call()] the this class as a function returns a copy of the tuple in a list which
/// is mutable.
class Tuple<E> extends UnmodifiableListView<E> {
  /// Generative constructor for the tuple.
  Tuple(Iterable sourceElements)
      : super(new List.from(sourceElements, growable: false));

  /// Returns the number of elements in this tuple.
  /// As [Optional] is not consider to be present until it is not absent
  /// it is not included in the elementCount. This means element != length, in
  /// the event of the tuple including one or more [Optional] elements.
  int get elementCount {
    return this.length - _optionalElementCount();
  }

  @override
  int get hashCode {
    return hashObjects(this.call());
  }

  // Return number of optional types in tuple so they can excluded
  // from the element count.
  TupleIterator get iterator {
    return new TupleIterator(this);
  }

  /// Returns the enumerated type name of the tuple.
  TupleType get type => TupleType.values[elementCount];

  /// Returns a new Tuple with passed in Tuple spliced into this Tuple.
  ///
  /// Preserving the passed Tuple type.
  Tuple intoSplice(Tuple otherTuple, Function insertionPosition,
      {bool before: true}) {
    int insertPoint =
        this.indexOf(this.firstWhere((e) => insertionPosition(e)));
    List thisContent = this();
    List splice = otherTuple();
    thisContent.insert(
        (before ? insertPoint : insertPoint + 1), new Tuple(splice));
    return new Tuple(thisContent);
  }

  /// Returns a new tuple with the content from the tuple append to the end
  /// of this tuple. The pass in Tuple is not preserved, we just melt away the
  /// first layer of.
  Tuple concatWith(Tuple otherTuple) {
    Iterable appendContent = otherTuple();
    List thisContent = this();
    thisContent.insertAll(this.length, appendContent);
    return new Tuple(thisContent);
  }

  @override
  bool operator ==(o) {
    return listsEqual(this.call(), o());
  }

  /// Has no effect as a tuple can not be modified or changed.
  @override
  void operator []=(int index, E value) {}

  /// Has no effect as a tuple can not be modified or changed.
  @override
  void add(value) {
    throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void addAll(value) => throw new MutabilityError();

  /// Returns a copy of the elements in this tuple as a mutable list.
  List call() => this.toList();

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  E removeAt(element) {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  E removeLast() {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void removeRange(int start, int end) {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void replaceRange(int start, int end, Iterable<E> iterable) {
    return throw new MutabilityError();
  }

  /// Results in a [MutabilityError], it is programming error to attempt this.
  /// Tuple is immutable, no changes post constructor.
  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    return throw new MutabilityError();
  }

  @override
  toString() {
    StringBuffer strBuf = new StringBuffer();
    strBuf.write(this.type.toString());
    strBuf.write(' - ');
    strBuf.write('${this.call()}');
    return strBuf.toString();
  }

  int _optionalElementCount() {
    var count = this.where((e) => e.runtimeType == Optional);
    return count.length;
  }
}

/// Provides a Tuple element one at time.
class TupleIterator extends BidirectionalIterator {
  var currentElement = null;
  int tupleLength = 0;
  int pointer;
  Tuple subject;

  TupleIterator(Tuple this.subject) {
    tupleLength = subject.length;
    pointer = -1;
  }

  // Returns the index of the current element in the tuple.
  get current => currentElement;

  // Returns the current element from the Tuple.
  int get index => pointer;

  @override
  bool moveNext() => _isPointerAtEnd() ? false : _loadNextElement();

  @override
  bool movePrevious() => _isPointerAtStart() ? false : _loadPreviousElement();

  @override
  String toString() => 'TupleIterator';

  bool _isPointerAtEnd() => pointer == tupleLength - 1 ? true : false;
  bool _isPointerAtStart() => pointer == 0 ? true : false;
  bool _loadNextElement() {
    pointer++;
    currentElement = subject[pointer];
    return true;
  }

  bool _loadPreviousElement() {
    pointer--;
    currentElement = subject[pointer];
    return true;
  }
}

/// Tuple types, enumeration of tuple type names contains zero to sixteen elements.
///
/// Provided are not only the constant types, the ordering is aligned so the index
/// of the enumerated type is relates to the number of elements the tuple holds.
///
/// A nulluple contain zero elements, hence [TupleType.nulluple] has an index of
/// zero.
///
/// _ Note the document generator gets this wrong, hence the index numbers are off +1
/// there are test cases that verify this dependence._
///
enum TupleType {
  /// Tuple with no elements
  nulluple,

  /// Tuple with one and only one elements.
  monuple,

  /// Tuple with two and only two elements.
  pairple,

  /// Tuple with three and only three elements.
  triple,

  /// Tuple with three and only four elements.
  quadruple,

  /// Tuple with five and only five elements.
  quintuple,

  /// Tuple with three and only six elements.
  sextuple,

  /// Tuple with three and only seven elements.
  septuple,

  /// Tuple with eight and only eight elements.
  octuple,

  /// Tuple with nine and only nine elements.
  nonuple,

  /// Tuple with three and only ten elements.
  decuple,

  /// Tuple with three and only eleven elements.
  hendecuple,

  /// Tuple with three and only twelve elements.
  duodecuple,

  /// Tuple with three and only thirteen elements.
  tredecuple,

  /// Tuple with three and only fourteen elements.
  quattuordecuple,

  /// Tuple with three and only fifteen elements.
  quindecuple,

  /// Tuple with three and only sixteen elements.
  sexdecuple,
}
