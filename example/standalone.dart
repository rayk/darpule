main(){

  var holder = new List();
  var holder2 = true;
  Type check = List;
  var check2 = bool;

  print(holder.runtimeType == check);
  print(holder2.runtimeType);

  print(check.runtimeType == holder.runtimeType);
  print(check is Type);



}