import 'dart:io';

List<String> processNames(
  List<String> names,
  String Function(String) processor,
) {
  return names.map(processor).toList();
}

void main() {
  print("Enter names(separate by ' ')");
  List<String> names = stdin.readLineSync()!.split(" ").toList();
  var uppercaseNames = processNames(names, (name) => name.toUpperCase());
  var prefixedNames = processNames(names, (name) => 'Mr./Ms. $name');

  print("Uppercase: ${uppercaseNames.join(', ')}");
  print("Prefix: ${prefixedNames.join(', ')}");
}
