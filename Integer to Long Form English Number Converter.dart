void main(){
    
  print(numberToWords(0));          // zero
  print(numberToWords(6));          // six
  print(numberToWords(42));         // forty two
  print(numberToWords(123));        // one hundred twenty three
  print(numberToWords(900));        // nine hundred
  print(numberToWords(8379));       // eight thousand three hundred seventy nine
  print(numberToWords(1234567));    // one million two hundred thirty four thousand five hundred sixty seven
  print(numberToWords(1000000));    // one million
  print(numberToWords(999999999));  // nine hundred ninety nine million nine hundred ninety nine thousand nine hundred ninety nine
}
  

  final List<String> units = [
    "",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
    ];
  final List<String> teens = [
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
  ];

  final List<String> tens = [
    "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety",
  ];

  String numberToWords(int number) {
  String words = "";

  if (number == 0) return "zero";

  int millions = number ~/ 1000000;
  if (millions > 0) {
    words += threeDigits(millions) + " million";
    number = number % 1000000;
  }

  int thousand = number ~/ 1000;
  if (thousand > 0) {
    if (words.isNotEmpty) words += " ";
    words += threeDigits(thousand) + " thousand";
    number = number % 1000;
  }

  if (number > 0) {
    if (words.isNotEmpty) words += " ";
    words += threeDigits(number);
  }

  return words;
}

  //helper
  String twoDigits(int number){
    String words = "";

    if (number < 10) words = units[number];
    else if (number < 20) words = teens[number - 10];

    else{
      int firstDigit = number ~/ 10;
      int secondDigit = number % 10;
      String ten = tens[firstDigit];
      String unit = units[secondDigit];

      words = ten + (unit.isNotEmpty ? " " + unit : "");

    }

    return words;
  }

  String threeDigits(int number){
    String words = "";
    int lastTwoDigits  = number % 100;
    String last = twoDigits(lastTwoDigits);
    
    int hundred = number ~/ 100;
    if (hundred > 0){
      words += units[hundred] + " hundred";
      if (lastTwoDigits > 0) words += " ";
    }

    if(lastTwoDigits > 0) words += last;

    return words;
  }


