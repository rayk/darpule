# Darpule

_Lightweight, Robust Immutable Tuple Implementation._

The [tuple](https://en.wikipedia.org/wiki/Tuple) has been knocking around for a long time, with implementations in Python, Lisp, Scala, Linda and many other languages it is the workhorse for sling data around between functions.

Immutability certain helps with persistence and being able to send it to an Isolate without the serialising and marshalling is handy.

This package attempts to address the base use case, which is the passing of multiple parameters and results in a clean, structured way, via a Tuple. The implementation wraps all the Dart Goodness to deliver lightweight implementation was possible.  

### Usage Examples

_The code before can be run from examples/darpule.dart._

Just one easy way to create an immutable tuple with _n_ elements. Using a single generative constructor, development time type checking was deliberately traded off. Insteadof using generics to parametrise multiple Tuple types, functional predicates where used for dynamic runtime type checking.

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

So as not to reinvent the wheel the Tuple type just extends Dart's UnmodifiableListView, which has a reasonably small footprint. This provides the iterator goodness for locating stuff. Just no modification after construction.

You can also just call the Tuple instance, and it returns a list of its elements that you can modify in any way. When ready pass that list back into a Tuple constructor, and we have a new immutable Tuple.

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

This is all very nice and neat, but the only type we have it is 'Tuple'. This is where predicates come into play. It easily to become a Tupleholic and when you end up with functions that accept any Tuple, a real mess can appear overnight. Hence the Predicate library, given that we have a list of typed elements within the tuple we may as well see what funky, functional things we can do.

Without importing the predicate library, you can use the [elementTypesOf(Tuple tuple)] to get a tuple of the element types as [Type].

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
    assert(isLeaf(deepLikeness) == false); // No one of elements is a Tuple.
    assert(isLeaf(sameContent1) == true); // Yes, no other tuple are inside.
```

Unfortunately life is never that clean, sometimes we want to partial match some elements and we happy if other are are whatever type. To achieve this we use [Object] as a wildcard place holder.
 
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

Things also have a way of being odd shaped, fuzzy around the edges or just not complete but we can live with it. So we bring [Optional] into play, it allows the element to be present or not present. Conditionally if it is present it we can ensure that is of a certain type.

```dart
   /// Real life is fuzzy
   
   Tuple acceptableStandard =
       new Tuple([String, int, double, Object, new Optional.of(bool)]);
   assert(isTupleTypeMatched(payload, acceptableStandard) == true);
```

### Limitations & Alternatives

- This Package is not designed to deliver a collection of Tuple nor a classic tuple space.
- [tuple](https://pub.dartlang.org/packages/tuple) provides stronger type implementation, has nice way to layer a tuple within a tuple.
- [duty](https://pub.dartlang.org/packages/duty) provides more then a Tuple but does have type safe containers for a Monuple, Pairple and Triple.
- [vacuum_persistent] (https://pub.dartlang.org/packages/vacuum_persistent) provide a complete persistence with immutable data structures.

If a packages should be on this list and is not, just add it via a pull request or rise an [issue](https://github.com/rayk/darpule/issues/new).