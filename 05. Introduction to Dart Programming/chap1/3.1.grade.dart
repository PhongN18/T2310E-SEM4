import 'dart:io';

void main() {
  print("Math grade: ");
  double? math = double.parse(stdin.readLineSync()!);
  print("Physics grade: ");
  double? phy = double.parse(stdin.readLineSync()!);
  print("Chemistry grade: ");
  double? chem = double.parse(stdin.readLineSync()!);

  if (math < 0 || math > 10 || phy < 0 || phy > 10 || chem < 0 || chem > 10) {
    print("Invalid grade!");
    return;
  }

  double avg = (math + phy + chem) / 3;
  String grade;
  if (avg >= 9.0) {
    grade = "Xuất sắc";
  } else if (avg >= 8.0) {
    grade = "Giỏi";
  } else if (avg >= 6.5) {
    grade = "Khá";
  } else if (avg >= 5.0) {
    grade = "Trung bình";
  } else {
    grade = "Yếu";
  }

  print("Điểm trung bình: $avg");
  print("Xếp loại: $grade");
}
