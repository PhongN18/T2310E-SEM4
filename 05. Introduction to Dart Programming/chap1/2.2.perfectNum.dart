void main() {
  int n = 28;
  int divisorSum = 0;

  for (int i = 1; i <= n / 2; i++) {
    if (n % i == 0) {
      divisorSum += i;
    }
  }

  print("$n ${n == divisorSum ? "" : "không phải "}là số hoàn hảo");
}
