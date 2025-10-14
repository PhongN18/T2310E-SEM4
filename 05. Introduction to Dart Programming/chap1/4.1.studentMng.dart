import 'dart:io';

void main() {
  print("Name: ");
  String? name = stdin.readLineSync();
  print("Age: ");
  int age = int.parse(stdin.readLineSync()!);
  print("Score: ");
  double score = double.parse(stdin.readLineSync()!);
  print("Activities (0-5): ");
  int activities = int.parse(stdin.readLineSync()!);

  if (age < 10 || score < 0 || score > 10 || activities < 0 || activities > 5) {
    print("Invalid data");
    return;
  }

  double bonus = activities * 0.5;
  if (bonus > 2.0) bonus = 2.0;
  double finalScore = score + bonus;
  String grade;
  if (finalScore >= 9.0)
    grade = "Xuất sắc";
  else if (finalScore >= 8.0)
    grade = "Giỏi";
  else if (finalScore >= 6.5)
    grade = "Khá";
  else if (finalScore >= 5.0)
    grade = "Trung bình";
  else
    grade = "Yếu";

  print("Hồ sơ học sinh");
  print("-------------------------------");
  print("Tên: $name");
  print("Tuổi: $age");
  print("Điểm trung bình: $score");
  print("Điểm thưởng: $bonus");
  print("Điểm tổng kết: $finalScore");
  print("Xếp loại: $grade");
}
