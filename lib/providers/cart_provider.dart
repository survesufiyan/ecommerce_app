import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  String? _appliedDiscountCode;
  double _discountPercentage = 0;

  static const Map<String, double> _validDiscountCodes = {
    'SAVE10': 10.0,
    'SAVE20': 20.0,
    'WELCOME': 15.0,
    'SUMMER': 25.0,
  };

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  double get discountAmount => totalAmount * (_discountPercentage / 100);

  double get finalAmount => totalAmount - discountAmount;

  String? get appliedDiscountCode => _appliedDiscountCode;

  double get discountPercentage => _discountPercentage;

  void addToCart(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void incrementQuantity(int productId) {
    final item = _items.firstWhere((item) => item.product.id == productId);
    item.quantity++;
    notifyListeners();
  }

  void decrementQuantity(int productId) {
    final item = _items.firstWhere((item) => item.product.id == productId);
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  bool isInCart(int productId) {
    return _items.any((item) => item.product.id == productId);
  }

  bool applyDiscountCode(String code) {
    final upperCode = code.toUpperCase().trim();
    if (_validDiscountCodes.containsKey(upperCode)) {
      _appliedDiscountCode = upperCode;
      _discountPercentage = _validDiscountCodes[upperCode]!;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeDiscountCode() {
    _appliedDiscountCode = null;
    _discountPercentage = 0;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    removeDiscountCode();
    notifyListeners();
  }
}
