class Rectangle {
  double _width;
  double _length;

  Rectangle(this._length, this._width) {
    if (_length <= 0 || _width <= 0) throw Exception("Invalid size");
  }

  Rectangle.square(double size) : _length = size, _width = size {
    if (size <= 0) throw Exception("Invalid size");
  }

  double get width => _width;
  double get length => _length;

  set width(double value) {
    if (value <= 0) throw Exception("Invalid width");
    _width = value;
  }

  set length(double value) {
    if (value <= 0) throw Exception("Invalid length");
    _length = value;
  }

  double calculateArea() => _length * _width;
  double calculatePerimeter() => (_length + _width) * 2;
}

void main() {
  var rect = Rectangle(5, 3);
  var square = Rectangle.square(4);

  print("Rectangle: width = ${rect._width}, length = ${rect._length}");
  print(
    "Perimeter = ${rect.calculatePerimeter()}, Area = ${rect.calculateArea()}",
  );
  print("Rectangle: width = ${square._width}, length = ${square._length}");
  print(
    "Perimeter = ${square.calculatePerimeter()}, Area = ${square.calculateArea()}",
  );
}
