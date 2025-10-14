import 'dart:io';

class Product {
  String name;
  int price;
  int inStock;

  Product(this.name, this.price, this.inStock);
}

void main() {
  print("Number of products: ");
  int n = int.parse(stdin.readLineSync()!);
  List<Product> products = [];

  for (int i = 1; i <= n; i++) {
    print("Product $i: ");
    print("Name: ");
    String name = stdin.readLineSync()!;
    print("Price: ");
    int price = int.parse(stdin.readLineSync()!);
    print("In stock: ");
    int inStock = int.parse(stdin.readLineSync()!);

    if (price <= 0 || inStock < 0) {
      print("Invalid data");
      i--;
      continue;
    }

    products.add(Product(name, price, inStock));
  }

  int totalValue = 0;
  int maxIdx = 0;
  int minIdx = 0;

  for (int j = 0; j < products.length; j++) {
    if (products[j].price > products[maxIdx].price) maxIdx = j;
    if (products[j].price < products[minIdx].price) minIdx = j;
    totalValue += products[j].price * products[j].inStock;
  }

  List<Product> lowInStock = products.where((p) => p.inStock < 10).toList();
  lowInStock.sort((a, b) => a.inStock.compareTo(b.inStock));

  print("Total stock value: $totalValue");
  print(
    "Highest price product: ${products[maxIdx].name} - ${products[maxIdx].price}",
  );
  print(
    "Lowest price product: ${products[minIdx].name} - ${products[minIdx].price}",
  );
  print("Low inventory products (<10): ");
  int k = 1;
  for (Product product in lowInStock) {
    print(
      "$k. Name: ${product.name}, Price: ${product.price}, In stock: ${product.inStock}",
    );
  }
}
