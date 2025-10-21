import 'dart:io';

int sumList(List<int> numbers, [bool onlyPositive = false]) {
  int sum = 0;
  for (int i in numbers) {
    if (onlyPositive) {
      if (i > 0) sum += i;
    } else
      sum += i;
  }

  return sum;
}

void main() {
  print("Enter list(separate by ' '): ");
  List<int> numbers = stdin
      .readLineSync()!
      .split(" ")
      .map((e) => int.parse(e))
      .toList();
  print("Sum: ${sumList(numbers)}");
  print("Positive sum: ${sumList(numbers, true)}");
}
