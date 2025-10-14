import 'dart:io';

void main() {
  print("Number of student: ");
  int n = int.parse(stdin.readLineSync()!);
  List<Map<String, dynamic>> students = [];

  for (int i = 1; i <= n; i++) {
    print("Student $i name and score (separate by ' '): ");
    List<String> studentInfo = stdin.readLineSync()!.split(' ');
    Map<String, dynamic> student = {
      'name': studentInfo[0],
      'score': double.parse(studentInfo[1]),
    };
    students.add(student);
  }

  List<Map<String, dynamic>> highScores = students
      .where((s) => s['score'] >= 8.0)
      .toList();
  highScores.sort((a, b) => b['score'].compareTo(a['score']));

  print('List of high score students: ');
  for (int i = 0; i < highScores.length; i++) {
    print(
      "${i + 1}. Name: ${highScores[i]['name']}, score: ${highScores[i]['score']}",
    );
  }
}
