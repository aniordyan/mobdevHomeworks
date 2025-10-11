import 'dart:io';

void main() {
  movieList();

  strManipulations();

  movieMap();

  print(signOfNumber(90));
  print(signOfNumber(-5));
  print(signOfNumber(0));
  print(signOfNumber(-100));

  userGreeting();

  divide(10, 2);
  divide(10, 0);

  printCurrentDateTime();
  printEvens();
}

/*
Create a program that stores a list of your top 3 favorite movie names 
and a fixed set of their release years. Print both the movie titles and 
their corresponding years.

*/

void movieList(){
  List<String> movies = ['Game of Thrones', 'Interstellar', 'The Godfather'];
  List<int> years = [2011, 2014, 1972];

  for(int i = 0; i < movies.length; i++){
    print(movies[i] + ' ' + years[i].toString());
  }
}

/*
Create a string variable and perform various string manipulations such as 
concatenation, substring extraction, and changing case, then print the 
modified string.
*/
void strManipulations() {
  String name = "Ani Ordyan";

  String greeting = "Hello, " + name + "! Nice to meet you";
  String firstName = name.substring(0, 3);

  String upperCaseName = name.toUpperCase();
  String lowerCaseName = name.toLowerCase();

  print(greeting);
  print("First name: $firstName");
  print("Name in uppercase: $upperCaseName");
  print("Name in lowercase: $lowerCaseName");

}


/*Declare a map with key-value pairs and iterate through it to 
print both keys and values.
*/

void movieMap() {
  Map<String, int> movieYears = {
    'Game of Thrones': 2011,
    'Interstellar': 2014,
    'The Godfather': 1972
  };

  movieYears.forEach((key, value) => print('$key: $value') );
}

//Write a function that takes an integer as input and returns a 
//string indicating whether it's positive, negative, or zero. 
//Call this function with different integer inputs and print the results.

String? signOfNumber(int n){
   switch(n){
    case > 0:
      return 'Positive';
    case < 0:
      return 'Negative';
    case 0:
      return 'Zero';
  }


}


/*Create a program that asks the user for their name and age, then prints a 
personalized greeting with their name and a message based on their age.
*/

void userGreeting() {
  stdout.write('Enter your name: ');
  String? name = stdin.readLineSync();

  stdout.write('Enter your age: ');
  String? ageInput = stdin.readLineSync();
  int age = int.tryParse(ageInput ?? '') ?? 0;

  String ageMessage;


  switch(age){
    case < 18:
      ageMessage = 'hey!';
      break;
    case < 65:
      ageMessage = 'hello!';
      break;
    default:
      ageMessage = 'my greetings to you';
  }

  print('$ageMessage, $name');
}

/*
Write a function that takes two numbers as input and divides them. 
Implement error handling to handle division by zero and print an 
appropriate message.
*/
int divide(int a, int b) {
  try {
    return a ~/ b;
  } catch (e) {
    print('Division by zero is not allowed');
  }
  return 0;
}

//Get the current date and time, format it, and print it.

void printCurrentDateTime() {
  DateTime now = DateTime.now();
  print("Current date and time: $now");
  
  print("Year: ${now.year}");
  print("Month: ${now.month}");
  print("Day: ${now.day}");
  print("Hour: ${now.hour}");
  print("Minute: ${now.minute}");
  print("Second: ${now.second}");
  print("");
  
  
  String formattedDate = 
      "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  String formattedTime = 
      "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  
  print("Date and Time: $formattedDate $formattedTime");
  
  // another way
  print("Date: ${now.toString().substring(0, 10)}");
  print("Time: ${now.toString().substring(11, 19)}");

}

/*
Declare a list of integers and use a lambda function to 
filter and print only the even numbers from the list. 
*/

void printEvens(){
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> evenNumbers = numbers.where((number) => number % 2 == 0).toList();
  
  print("Original list: $numbers");
  print("Even numbers: $evenNumbers");
}








