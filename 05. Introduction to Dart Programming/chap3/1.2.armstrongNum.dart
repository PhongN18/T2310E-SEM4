import 'dart:io';
import 'dart:math';

bool checkArmstrongNumber(int n) {
  if (n <= 0)
    return false;
  else if (n < 10)
    return true;
  int k = 0;
  int total = 0;
  int temp = n;
  List<int> digits = [];
  while (temp > 0) {
    digits.add(temp % 10);
    temp = temp ~/ 10;
    k++;
  }

  for (int i in digits) {
    total += pow(i, k).toInt();
  }

  return total == n;
}

void main() {
  print("Enter a number: ");
  int n = int.parse(stdin.readLineSync()!);
  print("$n is ${checkArmstrongNumber(n) ? "" : "not "}an Armstrong number.");
}
