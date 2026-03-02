import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  int get itemCount => _items.length;

  void addToWishlist(Product product) {
    if (!_items.any((item) => item.id == product.id)) {
      _items.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(int productId) {
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  bool isInWishlist(int productId) {
    return _items.any((item) => item.id == productId);
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product.id)) {
      removeFromWishlist(product.id);
    } else {
      addToWishlist(product);
    }
  }
}
