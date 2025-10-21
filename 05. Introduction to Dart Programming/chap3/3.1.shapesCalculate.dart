import 'dart:io';
import 'dart:math';

double rectangleArea(double width, double height) {
  if (width <= 0 || height <= 0) return -1;
  return width * height;
}

double rectanglePerimeter(double width, double height) {
  if (width <= 0 || height <= 0) return -1;
  return (width + height) * 2;
}

double circleArea(double radius) {
  if (radius <= 0) return -1;
  return pi * radius * radius;
}

double circlePerimeter(double radius) {
  if (radius <= 0) return -1;
  return 2 * pi * radius;
}

double triangleArea(double a, double b, double c) {
  if (a <= 0 || b <= 0 || c <= 0 || a + b <= c || a + c <= b || b + c <= a)
    return -1;
  double s = (a + b + c) / 2;
  return sqrt(s * (s - a) * (s - b) * (s - c));
}

double trianglePerimeter(double a, double b, double c) {
  if (a <= 0 || b <= 0 || c <= 0 || a + b <= c || a + c <= b || b + c <= a)
    return -1;
  return a + b + c;
}

void main() {
  print("1. Rectangle");
  print("2. Circle");
  print("3. Triangle");
  print("Select a shape (1-3):");
  int n = int.parse(stdin.readLineSync()!);

  switch (n) {
    case 1:
      print("Enter width, height: ");
      List<double> sizes = stdin
          .readLineSync()!
          .split(' ')
          .map((e) => double.parse(e))
          .toList();
      double area = rectangleArea(sizes[0], sizes[1]);
      double perimeter = rectanglePerimeter(sizes[0], sizes[1]);
      if (area < 0 || perimeter < 0) {
        print("Invalid data");
        return;
      }
      print("Area = ${area.toStringAsFixed(2)}");
      print("Perimeter = ${perimeter.toStringAsFixed(2)}");
      break;

    case 2:
      print("Enter radius: ");
      double radius = double.parse(stdin.readLineSync()!);
      double area = circleArea(radius);
      double perimeter = circlePerimeter(radius);
      if (area < 0 || perimeter < 0) {
        print("Invalid data");
        return;
      }
      print("Area = ${area.toStringAsFixed(2)}");
      print("Perimeter = ${perimeter.toStringAsFixed(2)}");
      break;

    case 3:
      print("Enter 3 sides: ");
      List<double> sides = stdin
          .readLineSync()!
          .split(' ')
          .map((e) => double.parse(e))
          .toList();
      double area = triangleArea(sides[0], sides[1], sides[2]);
      double perimeter = trianglePerimeter(sides[0], sides[1], sides[2]);
      if (area < 0 || perimeter < 0) {
        print("Invalid data");
        return;
      }
      print("Area = ${area.toStringAsFixed(2)}");
      print("Perimeter = ${perimeter.toStringAsFixed(2)}");
      break;
  }
}
