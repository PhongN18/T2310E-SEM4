void main() {
  double weight = 70.8;
  double height = 1.75;
  double bmi = weight / (height * height);
  String status;

  if (bmi < 18.5) {
    status = "Gầy";
  } else if (18.5 <= bmi && bmi < 25) {
    status = "Bình thường";
  } else if (25 <= bmi && bmi < 30) {
    status = "Thừa cân";
  } else {
    status = "Béo phì";
  }

  print("Chỉ số BMI: ${bmi.toStringAsFixed(2)}");
  print("Tình trạng: $status");
}
