class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() => print("I'm $name, $age years old");
}

class Student extends Person {
  double grade;

  Student(String name, int age, this.grade) : super(name, age);

  @override
  void introduce() => print("Student: $name, $age years old, grade: $grade");
}

class Teacher extends Person {
  String subject;

  Teacher(String name, int age, this.subject) : super(name, age);

  @override
  void introduce() => print("Teacher $name, $age years old, teaches $subject");
}

void main() {
  List<Person> people = [
    Student('An', 20, 8.5),
    Student('Bình', 21, 7.0),
    Teacher('Cường', 355, 'Toán'),
  ];

  for (var person in people) {
    person.introduce();
  }
}
