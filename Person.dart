//Define a class representing a simple "Person" with properties like name and age. Create an object of this class and print its properties. 

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void displayInfo() {
    print('Name: $name, Age: $age');
  }
}

void main() {
  Person person = Person('Bob', 20);
  person.displayInfo();

  LifeStagePerson lifeStagePerson = LifeStagePerson('Alice', 15);
  print('${lifeStagePerson.name} is a ${lifeStagePerson.getLifeStage()}');
}

//Extend Person class and write a function that takes a person's age as input and returns a string indicating their life stage (e.g., "Child," "Teenager," "Adult”). 

class LifeStagePerson extends Person {
  LifeStagePerson(String name, int age) : super(name, age);

  String getLifeStage() {
    if (age < 13) {
      return 'Child';
    } else if (age < 20) {
      return 'Teenager';
    } else return 'Adult';
    
  }
}