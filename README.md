# Darpule

_Lightweight, Robust Immutable Tuple Implementation._

The tuple has been knocking around for a long time, with implementation in Python, Lisp, Scala, Linda and many other languages it is the workhorse for sling data around between functions.

Immutability certain helps with persistence and being able to send it to an Isolate without the serialising and marshalling is handy. This package originally contained three major libraries, the tuple itself, a collection of predicates and a Tuple space.  

The latter, shall standalone as __DarpuleBox__ and be will dependent on upon this package. This allows just using the Tuple to sling data around without the overhead of the DarpuleBox.

The base use case this package attempts to address is the passing of multiple parameters and results in a clean, structured way. 

So firstly we wanted a standard easy creation of an immutable tuple with n elements. Having one type 'Tuple' gives up a lot of the type goodness. Sure we could leverage generics and have 'Tuple3<T1, T2,T3>',  we decided to attack this differently. See predicates below. 

```dart
/// Creating a Tuple

    Function tempCheck = isTempAcceptable(double high, double low) {.....}
    Function messageSender = sendMsg(String message) {....}
    Tuple supplies = new Tuple(['Compass', 'Ground Sheet', 'Maps', 'FireStarters', 'Ground Tarp']);
    Tuple goConditions = new Tuple([34.5, 25.5, 'Go Message' 'No Go Message', true, 30]);
    Tuple event = new Tuple ([supplies, goConditions, tempCheck, messageSender]) 


```

So as not to reinvent the wheel the Tuple type just extends UnmodifiableListView, which has a reasonably some footprint. This provides the iterator goodness for locating stuff. Just no modification after construction.

You can also just call the Tuple instance, and it returns a list of its elements that you can modify in any way. When ready pass that list back into a Tuple constructor, and we have a new immutable Tuple.

```dart
/// Creating a Tuple


```

We also did not want lightweight to mean just a 'Bag of Types.' So there are some features that give it some self-awareness.

```dart
/// Creating a Tuple


```

This is all very nice and neat, but the only type we have it is 'Tuple' where is this where predicates come into play. It easily to become a Tupleholic and when you end up with functions that accept any Tuple, a real mess can appear overnight. Hence the Predicate library, given that we have a list of typed elements within the tuple we may as well see what funky, functional things we can do.

```dart
/// Creating a Tuple


```

So the Predicate library is a collection of functions that anyone can use to composite rules and transforms on Tuples. The Tuple itself has no dependency on the predicate, so again there is no particular need to import it if a tuple is all that is needed.