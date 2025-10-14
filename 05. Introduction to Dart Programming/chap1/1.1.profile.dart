void main() {
  String name = "Phong Nguyen";
  int age = 23;
  String hobbies = "Gaming, Badminton, Football";
  List<String> hobbiesList = hobbies.split(',');

  print("Hồ sơ cá nhân");
  print("--------------------------");
  print("Họ và tên: $name");
  print("Tuổi: $age");
  print("Sở thích: ${hobbiesList.join(',')}");
}
