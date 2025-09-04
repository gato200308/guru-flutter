import 'product.dart';

class Cart {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addProduct(Product product) {
    _items.add(product);
  }

  void removeProduct(Product product) {
    _items.remove(product);
  }

  double get total =>
      _items.fold(0, (sum, item) => sum + item.price);
}
