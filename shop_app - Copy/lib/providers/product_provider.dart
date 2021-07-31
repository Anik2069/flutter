import 'package:flutter/cupertino.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Red Diamond',
      description: 'A nice .',
      price: 107.99,
      imageUrl:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=417&q=80',
    ),
    Product(
        id: 'p3',
        title: 'Dress',
        description: 'A nice .',
        price: 2036.99,
        imageUrl:
            'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
    Product(
        id: 'p4',
        title: 'Wedding Saree',
        description: 'A nice',
        price: 3506.99,
        imageUrl:
            'https://images.shaadisaga.com/shaadisaga_production/photos/pictures/001/004/609/new_large/final_cover_%283%29.jpg?1564407575'),
  ];
  var _showFavouriteOnly = false;

  List<Product> get items {
    // if (_showFavouriteOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  // void showFavoritesOnly() {
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll() {
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    // _items.add(value);
    _items.add(newProduct);
    _items.insert(0, newProduct);
    notifyListeners();
  }

  List<Product> get favItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
