# Darpule

_Lightweight, Robust Immutable Tuple Implementation._

The tuple has been knocking around for a long time, with implementation in Python, Lisp, Scala, Linda and many other languages it is the workhorse for sling data around between functions.

Immutability certain helps with persistence and being able to send it to an Isolate without the serialising and marshalling is handy. This package originally contained three major libraries, the tuple itself, a collection of predicates and a Tuple space.  

The latter, shall standalone as __DarpuleBox__ and be will dependent on upon this package. This allows just using the Tuple to sling data around without the overhead of the DarpuleBox.

The base use case this package attempts to address, is the passing of multiple parameters and results in a clean, structured way. 

So firstly we wanted a standard easy creation of an immutable tuple with n elements. Having one type 'Tuple' gives up a lot of the type goodness. Sure we could leverage generics and have  "Tuple3 <T1, T2,T3>",  we decided to attack this differently. See predicates below. 

```dart

    /// Created very ad-hoc.
    
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

So as not to reinvent the wheel the Tuple type just extends UnmodifiableListView, which has a reasonably some footprint. This provides the iterator goodness for locating stuff. Just no modification after construction.

You can also just call the Tuple instance, and it returns a list of its elements that you can modify in any way. When ready pass that list back into a Tuple constructor, and we have a new immutable Tuple.

```dart
 /// Ways to get a tuple elements

  assert(collective[0] == true); // Using element position number.

  List tupleContent = notSameContent(); // Call your tuple like a function.

  assert(tupleContent[0] == 8827 && tupleContent[1] == 'sad');

  tupleContent.add('Now we can mutate the resulting list');

  Tuple notSameContentWithMore = new Tuple(tupleContent); // Back to a tuple.

  assert (notSameContentWithMore is Tuple);
  assert (notSameContent.type == TupleType.pairple);
  assert (notSameContentWithMore.type == TupleType.triple);
```

Beside UnmodifiableList View not support mutations, we have introduced an [MutabilityError] just you can blow up something attempts mutate your tuple.
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

This is all very nice and neat, but the only type we have it is 'Tuple'. This where predicates come into play. It easily to become a Tupleholic and when you end up with functions that accept any Tuple, a real mess can appear overnight. Hence the Predicate library, given that we have a list of typed elements within the tuple we may as well see what funky, functional things we can do.

Without importing the predicate library, you can use the [elementTypesOf(Tuple tuple)] to get a tuple of the element types as [Type].

```dart

/// Finding out what the elements are at runtime.

  Tuple typesInPayload = elementTypesOf(payload);

  assert(typesInPayload[0] == String );
  assert(typesInPayload[1] == int);
  assert(typesInPayload[2] == double);
  assert(typesInPayload[3] == bool);

```

By importing the predicate library, you can start do a few more things. All the Predicates evaluate to True or False, True being yes and false being no.
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

Things also have a way of being odd shaped, fuzzy around the edges or just not complete but we live it. So we bring [Optional] into play, it allows the element to be present or not present. Conditionally if it is present it we can ensure that is of a certain type.

```dart
   /// Real life is fuzzy
   
     Tuple acceptableStandard =
         new Tuple([String, int, double, Object, new Optional.of(bool)]);
     assert(isTupleTypeMatched(payload, acceptableStandard) == true);
```