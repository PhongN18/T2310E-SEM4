import 'dart:io';
import 'dart:math';

void main() {
  print("Quadratic equation ax^2 + bx + c = 0");
  print("a = ");
  double a = double.parse(stdin.readLineSync()!);
  print("b = ");
  double b = double.parse(stdin.readLineSync()!);
  print("c = ");
  double c = double.parse(stdin.readLineSync()!);

  if (a == 0) {
    if (b == 0) {
      print("${c == 0 ? "Infinite solutions" : "No solutions"}");
    } else {
      print("x = ${-c / b}");
    }
    return;
  }

  double delta = b * b - 4 * a * c;
  if (delta < 0) {
    print("No solutions");
  } else if (delta == 0) {
    print("x = ${-b / (2 * a)}");
  } else {
    print("x1 = ${(-b + sqrt(delta)) / (2 * a)}");
    print("x2 = ${(-b - sqrt(delta)) / (2 * a)}");
  }
}
