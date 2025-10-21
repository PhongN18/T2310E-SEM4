class Student {
  String name;
  int age;
  double grade;

  Student(this.name, this.age, this.grade);

  String getGrade() {
    if (grade >= 8.5) return "A";
    if (grade >= 7) return "B";
    if (grade >= 5) return "C";
    if (grade >= 4) return "D";
    return "F";
  }
}

void main() {
  List<Student> students = [
    Student("An", 20, 8.7),
    Student("Bình", 21, 7.2),
    Student("Cường", 19, 4.5),
  ];

  for (Student student in students) {
    print(
      "Student: ${student.name}, Age: ${student.age}, Grade: ${student.grade} => ${student.getGrade()}",
    );
  }
}
