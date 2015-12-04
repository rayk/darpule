library darpule.test.areTupleMatched;

import 'package:test/test.dart';
import 'package:darpule/predicate.dart';
import 'package:darpule/tuple.dart';


main(){

  /// Test Data Convention
  ///
  /// criteriaTuple are label A-Z ,subjectTuple have match labels with a suffix.
  /// _x(n) indicates the subject is a match for the criteria, n, as there can many.
  /// _f_i indicates no possible match because of length.
  /// _f_o indicates no match because of incorrect ordering.
  /// _f_t indicates no match because of type mismatch.
  /// _f_v indicates no match because of value mismatch.
  /// _f_p indicates no match because of pattern mismatch.
  /// _f_f indicates no match because of function mismatch.
  ///
  /// As a criteriaTuple is declared a comment is used to describe the pattern.
  Tuple criteriaA, criteriaB, criteriaC, criteriaD, criteriaE, criteriaF, criteriaG, criteriaH, criteriaI;

  Tuple subjectA_x0, subjectA_x1, subjectA_f_i, subjectA_f_o, subjectA_f_t, subjectA_f_p;
  Tuple subjectB_x0, subjectB_x1, subjectB_x2, subjectB_f_i, subjectB_f_o, subjectB_f_t, subjectB_f_f;
  Tuple subjectC_x0, subjectC_x1, subjectC_x2, subjectC_f_i_0, subjectC_f_i_1, subjectC_f_o, subjectC_f_t;
  Tuple subjectD_x0, subjectD_x1, subjectD_f_o;
  Tuple subjectE_x0, subjectE_x1, subjectE_x2, subjectE_x3, subjectE_f_o, subjectE_f_t;
  Tuple subjectF_x0, subjectF_x1, subjectF_x2, subjectF_x3, subjectF_f_i, subjectF_f_o;
  Tuple subjectG_x0, subjectG_x1, subjectG_x2, subjectG_f_i, subjectG_f_o, subjectG_f_t;
  Tuple subjectH_x0, subjectH_x1;
  Tuple subjectI_x0, subjectI_x1, subjectI_f_i;

  /// Embedded Types
  List list1 = [34, 9.3, 'Home', true, 'bears'];
  Map map1 = {'k0':'A', 'k1':12, 'k3':30.34, 'k4':true};
  Tuple tuple1 = new Tuple(['Arc', false, 93.3]);
  RegExp reg1 = new RegExp(r'\W+');
  bool rangeCheck(int number)=> number > 0 && number < 100 ? true : false;

  /// All hard types.
  criteriaA = new Tuple([String, int, bool, double, List, Map, Tuple, RegExp]);
  subjectA_x0 = new Tuple([String, int, bool, double, List, Map, Tuple, RegExp]);
  subjectA_x1 = new Tuple(['Hello', 34, true, 0.3, list1, map1, tuple1, reg1]);
  subjectA_f_i = new Tuple(['Hello', 34, true]);
  subjectA_f_o = new Tuple([reg1, tuple1, map1, list1, 0.3, true, 34, 'Hello']);
  subjectA_f_t = new Tuple(['String', 'dog', true, 1, 'list', reg1, map1, tuple1]);
  subjectA_f_p = new Tuple(['String',1,true,0.2,list1,map1,tuple1,232]);

  /// Wild cards, both types.
  criteriaB = new Tuple([int, bool, new Optional.absent(), Object, Object, String]);
  subjectB_x0 = new Tuple([12, true,'frist obj', 'second obj', 'final string']);
  subjectB_x1 = new Tuple([1, false, 'opti wild', 'first obj', 'second obj', 'final']);
  subjectB_x2 = new Tuple([0, false, 1, 'first obj', 'second obj', 'final']);
  subjectB_f_i = new Tuple([0, false, 1, 1, 'String']);
  subjectB_f_o = new Tuple(['Cats', true,1,0.1,1]);
  subjectB_f_t = new Tuple([true, 23, true, 'String', 'Another', 9.033]);

  /// Optionals with types and wildcards.
  criteriaC = new Tuple([new Optional.of(int), bool, String, Object, double]);
  subjectC_x0 = new Tuple([23,true,'hello', 34, 0.34]);
  subjectC_x1 = new Tuple([false, 'World', true, 0.00]);
  subjectC_x2 = new Tuple([939, true, 'Water', 'Falls', 03.02]);
  subjectC_f_i_0 = new Tuple([true, 'Hole', 39.23]);
  subjectC_f_i_1 = new Tuple([23,false,'word',93,303.03,false,true]);
  subjectC_f_o = new Tuple([39.23, true, 'hello', false, 123]);
  subjectC_f_t = new Tuple([93,false,true,true,'world']);

  /// Palindrome Sequence
  criteriaD = new Tuple([bool,new Optional.of(int),int,bool,Object,Object, bool,int,new Optional.of(int),bool]);
  subjectD_x0 = new Tuple([true,120,84,false,'word','word',true,38,938,false]);
  subjectD_x1 = new Tuple([false,03,false,'race',938.3, false,9993,true]);
  subjectD_f_o = new Tuple([343,93,true,true,false,false,392,092,true,false]);

  ///Adjacent Similar Criteria
  criteriaE = new Tuple([bool,int, new Optional.of(bool), new Optional.of(int),String, double, new Optional.of(String), new Optional.of(double), double, String, double, String]);
  subjectE_x0 = new Tuple([true,2,false,3,'wordA', 3.2, 'wordB', 2.23, 39.2, 'world', 92.2, 'waste']);
  subjectE_x1 = new Tuple([false, 23, 'String', 23.32,12.4, 'landed', 223.3, 'west']);
  subjectE_x2 = new Tuple([false,34,true,'west', 34.23, 'north', 23.93, 123.43,'south',343.1, 'east']);
  subjectE_x3 = new Tuple([true, 34,23,'north', 32.12,'south',12.12,'point', 92.4, 'heat']);
  subjectE_f_o = new Tuple([true,34,'house',29.23,false, 343, 'Water', 32.2, 0.3,'string', 0.3, 'ending']);
  subjectE_f_t = new Tuple([false, 3.2, false, 302.2, 'water', 23, 'land', 93, 93, 'baking', 23.12, 'water']);

  ///Adjacent Similar and limited Type Criteria
  criteriaF = new Tuple([new Optional.of(bool), int, bool, int, new Optional.of(int),int, new Optional.of(bool), new Optional.of(bool), new Optional.of(int), int]);
  subjectF_x0 = new Tuple([true, 93,true,93,93,93,false,true,303,23]);
  subjectF_x1 = new Tuple([93,true,23,23,12]);
  subjectF_x2 = new Tuple([83,true,02,0,3,true,93]);
  subjectF_x3 = new Tuple([true, 23, false, 34,false,int]);
  subjectF_f_i = new Tuple([true, 93, true,23,34,54,true,false,23,54,true, false,930]);
  subjectF_f_o = new Tuple([false,03,false,34,true,false,12,32]);

  ///Repeat pattern optional and required
  criteriaG = new Tuple([new Optional.of(int),new Optional.of(bool),int, bool,new Optional.of(bool), new Optional.of(int),bool, int,new Optional.of(int), new Optional.of(bool)]);
  subjectG_x0 = new Tuple([12, false, 12, true, false, 23, true, 32,9,true]);
  subjectG_x1 = new Tuple([34, false,false,34]);
  subjectG_x2 = new Tuple([34,true,true,34,true]);
  subjectG_f_i = new Tuple([13, true, 039, false, true, true, true, 9, 8, true, 23, true]);
  subjectG_f_o = new Tuple([93,02,true,true,34,false,34,34,34,false]);
  subjectG_f_t = new Tuple([93.92, false, 'String', 92, 'west', 3920, true, false, 'water', false]);

  /// Limited with wild cards
  criteriaH = new Tuple([new Optional.of(int),int, Object, Object, int, String, bool,double,bool, new Optional.of(bool), new Optional.of(double)]);
  subjectH_x0 = new Tuple([23, true, false, 32, 'east', false, 302.2, true]);
  subjectH_x1 = new Tuple([95,53,43,23,23,'water',true , 23.4,true ,true,23.23]);

  /// Match value and Type criteria
  criteriaI = new Tuple([bool, "Station", 32, String, Object, int]);
  subjectI_x0 = new Tuple([true, "Station", 32, "Wet Weather", 30.3, 2]);
  subjectI_x1 = new Tuple([false, "Station", 32, "Dry Mountain", false, 9]);









}