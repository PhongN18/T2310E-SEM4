void main() {
  int a = 1;
  int b = 100;
  List<int> numbers = [];
  int sum = 0;

  for (int i = a; i <= b; i++) {
    if (i % 3 == 0 && i % 5 == 0) {
      numbers.add(i);
      sum += i;
    }
  }

  if (numbers.length == 0)
    print("No numbers in range from $a to $b divisible by 3 and 5");
  else {
    print("Numbers between $a and $b divisible by 3 and 5: ");
    print(numbers.join(', '));
    print("Sum = $sum");
  }
}
