import 'dart:io';

void main() {
  print("Number of students: ");
  int n = int.parse(stdin.readLineSync()!);
  List<double> scores = [];

  for (int i = 1; i <= n; i++) {
    print("Student $i marks: ");
    double score = double.parse(stdin.readLineSync()!);
    if (score >= 0 && score <= 10)
      scores.add(score);
    else {
      print("Invalid marks");
      i--;
    }
  }

  int aboveAvg = 0;
  for (double score in scores) {
    if (score >= 5.0) aboveAvg++;
  }

  print("Marks list: ${scores.join(", ")}");
  print("Above average students: $aboveAvg");
}
