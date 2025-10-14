import 'dart:io';

void main() {
  print("Input number: ");
  int n = int.parse(stdin.readLineSync()!);
  int temp = n;
  int result = 0;

  int factorial(a) {
    if (a == 0 || a == 1) return 1;
    if (a == 2) return 2;
    int result = 1;
    for (int i = 2; i <= a; i++) {
      result *= i;
    }
    return result;
  }

  while (n > 0) {
    result += factorial(n % 10);
    n = n ~/ 10;
  }

  if (temp == result)
    print("Strong");
  else
    print("Not strong");
}
