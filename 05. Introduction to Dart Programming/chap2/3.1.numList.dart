import 'dart:io';

void main() {
  print("Number list (separate by ' '): ");
  List<int> numbers = stdin
      .readLineSync()!
      .split(' ')
      .map((e) => int.parse(e))
      .toList();

  int max = numbers[0];
  int min = numbers[0];
  int sum = 0;
  int prime = 0;

  for (int n in numbers) {
    if (n > max) max = n;
    if (n < min) min = n;
    sum += n;
    if (n < 2)
      continue;
    else {
      bool flag = true;
      for (int i = 2; i <= n / 2; i++) {
        if (n % i == 0) {
          flag = false;
          break;
        }
      }
      if (flag) prime++;
    }
  }

  print("List: $numbers");
  print("Max: $max");
  print("Min: $min");
  print("Average: ${(sum / numbers.length).toStringAsFixed(2)}");
  print("Prime: $prime");
}
