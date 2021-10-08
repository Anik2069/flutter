import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/http_exception.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];

  // List<Product> _items = [
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Red Diamond',
  //     description: 'A nice .',
  //     price: 107.99,
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1595777457583-95e059d581b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=417&q=80',
  //   ),
  //   Product(
  //       id: 'p3',
  //       title: 'Dress',
  //       description: 'A nice .',
  //       price: 2036.99,
  //       imageUrl:
  //           'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
  //   Product(
  //       id: 'p4',
  //       title: 'Wedding Saree',
  //       description: 'A nice',
  //       price: 3506.99,
  //       imageUrl:
  //           'https://images.shaadisaga.com/shaadisaga_production/photos/pictures/001/004/609/new_large/final_cover_%283%29.jpg?1564407575'),
  // ];
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

  // Future<void> addProduct(Product product) {
  //   const url =
  //       "https://shop-app-1c56b-default-rtdb.firebaseio.com/products.json";
  //   return http
  //       .post(
  //     url,
  //     body: json.encode({
  //       "title": product.title,
  //       "price": product.price,
  //       'description': product.description,
  //       "imageUrl": product.imageUrl,
  //       "isFavorite": product.isFavorite,
  //     }),
  //   )
  //       .then((response) {
  //     print(json.decode(response.body));
  //     final newProduct = Product(
  //       title: product.title,
  //       price: product.price,
  //       description: product.description,
  //       imageUrl: product.imageUrl,
  //       id: json.decode(response.body)['name'],
  //     );
  //     // _items.add(value);
  //     _items.add(newProduct);
  //     // _items.insert(0, newProduct);
  //     notifyListeners();
  //   }).catchError((error) {
  //     print(error);
  //     throw error;
  //   });
  //
  //   return Future.value();
  // }

  Future<void> fetchAndSetProducts() async {
    const url =
        "https://shop-app-1c56b-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.get(url);
      //print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          isFavorite: value['isFavorite'],
          imageUrl: value['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        "https://shop-app-1c56b-default-rtdb.firebaseio.com/products.json";
    final response = null;
    try {
      final response = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "price": product.price,
          'description': product.description,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        }),
      );
    } catch (error) {
      print(error);
      throw error;
    }

    //print(json.decode(response.body));
    final newProduct = Product(
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
      id: json.decode(response.body)['name'],
    );
    // _items.add(value);
    _items.add(newProduct);
    // _items.insert(0, newProduct);
    notifyListeners();

    //return Future.value();
  }

  List<Product> get favItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          "https://shop-app-1c56b-default-rtdb.firebaseio.com/products/$id.json";
      await http.patch(url,
          body: json.encode({
            "title": newProduct.title,
            "price": newProduct.price,
            'description': newProduct.description,
            "imageUrl": newProduct.imageUrl
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://shop-app-1c56b-default-rtdb.firebaseio.com/products/$id.json";
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var exitingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {

      _items.insert(existingProductIndex, exitingProduct);
      notifyListeners();
      throw HttpException("Could Not Delete product");
    }
    exitingProduct = null;

    // notifyListeners();
  }
}
