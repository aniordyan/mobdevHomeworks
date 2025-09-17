void main() {
  var data = [
    1,
    [2, 3, 4],
    {'a': 5, 'b': ["ab", 7]},
    (first: 8, second: "c"),
    {'c': (first: 10, second: ["xy", 12])},
    "z",
    13.5,
    [14, {'d': 15, 'e': (first: "p", second: 17)}]
  ];

  var result = sumNested(data);

  print(result);
  
}



int sumNested(dynamic obj){
  int result = 0;
  switch(obj){
    case (int n): result += n; break;
    case (double n): result += n.floor(); break;
    case (String s): result += sumAscii(s); break;
    case List<dynamic> list:
      return sumSpecialList(list);

    case Map<dynamic, dynamic> map:
      return map.values.fold(0, (total, value) => total + sumNested(value));

  
    case (var x, var y):
      return sumPair((x, y));

    case (first: var x, second: var y):
      return sumPair((first: x, second: y));

    default:
      return 0;


  }

  return result;
}

//helper

int sumAscii(String s){
  int result = 0;

  for(int i = 0; i < s.length; i++){
    result += s.codeUnitAt(i);
  }

  return result;
}

int sumPair(Record rec) {
  switch (rec) {
    
    case (first: var a, second: var b):
      return sumNested(a) + sumNested(b);
    case (var a, var b):
      return sumNested(a) + sumNested(b);
    default:
      return 0;
  }
}



int sumSpecialList(List<dynamic> l) {
  switch (l) {
    case []:
      return 0;

    case [int head, ...var tail]:
      return head + sumSpecialList(tail);

    case [double head, ...var tail]:
      return head.floor() + sumSpecialList(tail);

    case [String head, ...var tail]:
      return sumAscii(head) + sumSpecialList(tail);

    case [var head, ...var tail]:
      return sumNested(head) + sumSpecialList(tail);

    default:
      return 0;
  }
}

