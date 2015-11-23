# Darpule

_Lightweight, Robust Immutable Tuple Implementation._

The [tuple](https://en.wikipedia.org/wiki/Tuple) has been knocking around for a long time, with implementations in Python, Lisp, Scala, Linda and many other languages it is the workhorse for sling data around between functions.

Immutability certain helps with persistence and being able to send it to an Isolate without the serialising and marshalling is handy.

This package addresses the base use case, which is the passing of multiple parameters and results in a clean, structured way, via a Tuple. The implementation wraps all the Dart Goodness to deliver lightweight implementation was possible.  

### Usage Examples

_The code below can be run from examples/darpule.dart._

One easy way to create an immutable tuple with _n_ elements. Using a single generative constructor, development time type checking was deliberately traded off. Insteadof using generics to parametrise multiple Tuple types, functional predicates where used for dynamic runtime type checking.

```dart
    /// Created in a very ad-hoc.
    
    List resultFromSomeWhere = ['Longhaul', 382, 982.23, false];
    
    Tuple payload = new Tuple(resultFromSomeWhere);
    
    assert(payload is Tuple);
    assert(payload.type == TupleType.quadruple);
    assert(payload.elementCount == 4);
    
    /// Tuple can hold anything.
    Tuple collective = new Tuple([
      true,
      new Tuple([343, false]),
      new DateTime.now()
    ]);
    
    assert(collective is Tuple);
    assert(collective.type == TupleType.triple);
    
```

So as not to reinvent the wheel the Tuple type just extends Dart's [UnmodifiableListView](https://api.dartlang.org/134830/dart-collection/UnmodifiableListView-class.html), which has a reasonably small footprint. This provides the iterator goodness for locating stuff.

You can also just call the Tuple instance, and it returns a list of its elements that you can modify in any way. When ready, pass that list back into a Tuple constructor, and we have a new immutable Tuple.

```dart
    /// Ways to get a tuple elements
    
    Tuple notSameContent = new Tuple([8827, 'sad']);

    assert(collective[0] == true); // Using element position number.
    
    List tupleContent = notSameContent(); // Call your tuple like a function.
    
    assert(tupleContent[0] == 8827 && tupleContent[1] == 'sad');
    
    tupleContent.add('Now we can mutate the resulting list');
    
    Tuple notSameContentWithMore = new Tuple(tupleContent); // Back to a tuple.
    
    assert (notSameContentWithMore is Tuple);
    assert (notSameContent.type == TupleType.pairple);
    assert (notSameContentWithMore.type == TupleType.triple);
```

Beside UnmodifiableList View not supporting mutations, we have introduced an [MutabilityError] just so you can blow up when something attempts mutate your tuple.
```dart
    /// Tuple is Immutable, trying results in an programming error.
  
    try {
      payload.add('WantToAddElement');
    } catch (error) {
      assert(error is MutabilityError);
    }
  
    try {
      payload.addAll(['doctor', 'drugs']);
    } catch (error) {
      assert(error is MutabilityError);
    }
  
    try {
      payload.removeAt(0);
    } catch (error) {
      assert (error is MutabilityError);
    }
```
 
Equal is based upon the content and structure of the tuple.

```dart
    /// Hash and Equals behaviour

    assert(collective != payload);
    
    Tuple sameContent1 = new Tuple([3902, 'happy']);
    Tuple sameContent2 = new Tuple([3902, 'happy']);
    
    assert(sameContent1 == sameContent2); // They have same elements.
    assert(identical(sameContent1, sameContent2) == false); // But are unique.
    
    Tuple notSameContent = new Tuple([8827, 'sad']);
    
    Tuple deepLikeness = new Tuple(['skindeep', sameContent1]);
    Tuple deeperLikeness = new Tuple(['skindeep', sameContent1]);
    Tuple downDeep = new Tuple(['skindeep', notSameContent]);
    
    assert(deepLikeness == deeperLikeness);
    assert(downDeep != deepLikeness);
```

This is all very nice and neat, but the only type we have is 'Tuple'. This is where predicates come into play. It easily to become a Tupleholic and when you end up with functions that accept any Tuple, a real mess can appear overnight, so probably best to keep them away from the surface areas of API's. To afford some protection at runtime there is the Predicate library, given a Tuple is a glorified list of typed elements, functions can be composed together to achieve anything.

Without importing the predicate library, you can use the [elementTypesOf(Tuple tuple)] to get the [Type] of each of the elements.

```dart
    /// Finding out what the elements are at runtime.

    Tuple typesInPayload = elementTypesOf(payload);
    
    assert(typesInPayload[0] == String );
    assert(typesInPayload[1] == int);
    assert(typesInPayload[2] == double);
    assert(typesInPayload[3] == bool);
```

By importing the predicate library, you can start do a few more things. All the Predicates evaluate to True or False, True being yes and False being no.
```dart
    /// Predicate can help you answer some questions about the Tuple.

    assert(isSepTuple(payload) == false); // No it does not have 7 elements.
    assert(isQuadruple(payload) == true); // Yes it does have 4 elements
    assert(isSexdecuple(payload) == false); // No it does not have 16 elements.
    assert(isLeaf(deepLikeness) == false); // No one of elements is a Tuple.
    assert(isLeaf(sameContent1) == true); // Yes, no other tuple are inside.
    
```

Unfortunately life is never that clean, sometimes we want to partial match some elements in the Tuple and not be too fussed about the other types as long as they are present. To achieve this we use [Object] as a wildcard place holder.
 
```dart
   /// Looking inside for a pattern.
     
   Tuple strictPattern = new Tuple ([String, int, double, bool]);
   Tuple loosePattern = new Tuple ([String, Object, double, Object]);
   
   assert (isTupleTypeMatched(payload, strictPattern) == true);
   assert (isTupleTypeMatched(payload, loosePattern) == true);
   
   /// Sometimes you don't get what you want.
   
   Tuple expectedTuplePattern = new Tuple ([String, int, int, bool]);
   assert(isTupleTypeMatched(payload, expectedTuplePattern) == false);
   
   /// Sometimes you don't get enough of what you want.
   
   Tuple veryLoosePattern = new Tuple ([Object, Object, Object, Object, Object]);
   assert(isTupleTypeMatched(payload, veryLoosePattern) == false); 
```

Things also have a way of being odd shaped, fuzzy around the edges or just not complete but we can live with it. To cater for this we bring [Optional] into play, it allows the element to be present or not present. Conditionally if it is present it can ensure that it is of a certain type. Both the wildcard and optional can be used in any position of in the pattern tuple.

```dart
   /// Real life is fuzzy
   
   Tuple acceptableStandard =
       new Tuple([String, int, double, Object, new Optional.of(bool)]);
   assert(isTupleTypeMatched(payload, acceptableStandard) == true);
   
   Tuple lowerStandard = new Tuple([String, new Optional.of(int), double, bool]);
   assert(isTupleTypeMatched(payload, lowerStandard) == true);
   
   Tuple differentStandard = new Tuple([new Optional.of(String), int, double, bool]);
   assert(isTupleTypeMatched(payload, differentStandard) == true);
```

#### Using Optional

[Optional](https://www.dartdocs.org/documentation/quiver_optional/1.0.0-dev.1/quiver.optional/Optional-class.html) is from dart Quiver Library, it denotes an optional element. The semantics of this is expected to change
  when [NNBD (Non-null Types & Non-null By Default)](https://github.com/chalin/DEP-non-null) lands in dart. At that time Optional is expected to be deprecated from Quiver. Until then
  we use optional in a pattern tuple to represent and element that may or not be present (it is optional!). We further use Optional.absent()
  if we don't really care about the type or value when the element is present.
    
  Using optional.of(T value) we can express the rule that states, the element does not have to be in the tuple, but if it include it must
  be of T value.
    
  Should you expect to use this heavily it is worth understanding the [migration strategies](https://github.com/chalin/DEP-non-null/blob/master/doc/dep-non-null-AUTOGENERATED-DO-NOT-EDIT.md#part-migration) being currently being proposed. 
    

### Limitations & Alternatives

- This Package is not designed to deliver a collection of Tuple nor a classic tuple space.
- [tuple](https://pub.dartlang.org/packages/tuple) provides stronger type implementation, has nice way to layer a tuple within a tuple.
- [duty](https://pub.dartlang.org/packages/duty) provides more then a Tuple but does have type safe containers for a Monuple, Pairple and Triple.
- [vacuum_persistent] (https://pub.dartlang.org/packages/vacuum_persistent) provide a complete persistence with immutable data structures.

If a packages should be on this list and is not, just add it via a pull request or rise an [issue](https://github.com/rayk/darpule/issues/new).