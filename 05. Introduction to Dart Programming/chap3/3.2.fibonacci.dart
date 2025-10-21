import 'dart:io';

List<int> fibonacciList(int n) {
  if (n <= 0) return [];
  List<int> fib = [0, 1];
  if (n == 1) return [0];
  for (int i = 2; i < n; i++) {
    fib.add(fib[i - 1] + fib[i - 2]);
  }
  return fib;
}

bool checkFib(int n) {
  if (n < 0) return false;
  int a = 0, b = 1;
  while (a <= n) {
    if (a == n || b == n) return true;
    int temp = a + b;
    a = b;
    b = temp;
  }
  return false;
}

void main() {
  print("1. Generate Fibonacci list");
  print("2. Check if number in Fibonacci list");
  print("Select task (1-2): ");
  int c = int.parse(stdin.readLineSync()!);

  switch (c) {
    case 1:
      print("Fibonacci list size: ");
      int n = int.parse(stdin.readLineSync()!);
      List<int> fib = fibonacciList(n);
      if (fib.length == 0) {
        print("Invalid input");
        return;
      }
      print(fib.join(", "));
      break;

    case 2:
      print("Input number:");
      int n = int.parse(stdin.readLineSync()!);
      print("$n is${checkFib(n) ? "" : " not"} in Fibonacci list");
      break;
  }
}
