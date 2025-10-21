import 'dart:io';
import 'dart:math';

double calculateCircleArea(double r) {
  if (r <= 0) {
    print("Radius must be larger than 0");
    return 0;
  }
  return pi * r * r;
}

void main() {
  print("Circle radius: ");
  double r = double.parse(stdin.readLineSync()!);
  double area = calculateCircleArea(r);
  if (area > 0) print("Area = ${area.toStringAsFixed(2)}");
}
