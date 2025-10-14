import 'dart:io';

void main() {
  print("Input name list (separate by space ' '): ");
  List<String> names = stdin.readLineSync()!.split(' ');
  List<String> ascending = List.from(names)..sort();
  List<String> descending = List.from(names)..sort((a, b) => b.compareTo(a));

  print("List: ${names.join(", ")}");
  print("Ascending: ${ascending.join(", ")}");
  print("Descending: ${descending.join(", ")}");
}
