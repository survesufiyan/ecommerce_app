import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const Duration timeout = Duration(seconds: 30);

  static Future<List<String>> getCategories() async {
    try {
      print('Fetching categories from $baseUrl/products/categories');
      final response = await http
          .get(
        Uri.parse('$baseUrl/products/categories'),
      )
          .timeout(timeout, onTimeout: () {
        throw TimeoutException('Request timeout after ${timeout.inSeconds}s');
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => e.toString()).toList();
      } else {
        throw Exception('Server error: Status code ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Timeout: $e');
      throw Exception(
          'Connection timeout. Please check your internet and try again.');
    } on SocketException catch (e) {
      print('Socket error: $e');
      throw Exception(
          'Network error: ${e.message}. Check your internet connection.');
    } on HttpException catch (e) {
      print('HTTP error: $e');
      throw Exception('Connection error: ${e.message}');
    } catch (e) {
      print('Error loading categories: $e');
      throw Exception('Failed to load data. Error: ${e.toString()}');
    }
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    try {
      print('Fetching products for category: $category');
      final response = await http
          .get(
        Uri.parse('$baseUrl/products/category/$category'),
      )
          .timeout(timeout, onTimeout: () {
        throw TimeoutException('Request timeout after ${timeout.inSeconds}s');
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Server error: Status code ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Timeout: $e');
      throw Exception(
          'Connection timeout. Please check your internet and try again.');
    } on SocketException catch (e) {
      print('Socket error: $e');
      throw Exception(
          'Network error: ${e.message}. Check your internet connection.');
    } on HttpException catch (e) {
      print('HTTP error: $e');
      throw Exception('Connection error: ${e.message}');
    } catch (e) {
      print('Error loading products: $e');
      throw Exception('Failed to load data. Error: ${e.toString()}');
    }
  }

  static Future<Product> getProductById(int id) async {
    try {
      print('Fetching product with id: $id');
      final response = await http
          .get(
        Uri.parse('$baseUrl/products/$id'),
      )
          .timeout(timeout, onTimeout: () {
        throw TimeoutException('Request timeout after ${timeout.inSeconds}s');
      });

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Server error: Status code ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Timeout: $e');
      throw Exception(
          'Connection timeout. Please check your internet and try again.');
    } on SocketException catch (e) {
      print('Socket error: $e');
      throw Exception(
          'Network error: ${e.message}. Check your internet connection.');
    } on HttpException catch (e) {
      print('HTTP error: $e');
      throw Exception('Connection error: ${e.message}');
    } catch (e) {
      print('Error loading product: $e');
      throw Exception('Failed to load product: $e');
    }
  }

  static Future<List<Product>> getAllProducts() async {
    try {
      print('Fetching all products from $baseUrl/products');
      final response = await http
          .get(
        Uri.parse('$baseUrl/products'),
      )
          .timeout(timeout, onTimeout: () {
        throw TimeoutException('Request timeout after ${timeout.inSeconds}s');
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Server error: Status code ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Timeout: $e');
      throw Exception(
          'Connection timeout. Please check your internet and try again.');
    } on SocketException catch (e) {
      print('Socket error: $e');
      throw Exception(
          'Network error: ${e.message}. Check your internet connection.');
    } on HttpException catch (e) {
      print('HTTP error: $e');
      throw Exception('Connection error: ${e.message}');
    } catch (e) {
      print('Error loading products: $e');
      throw Exception('Failed to load data. Error: ${e.toString()}');
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    try {
      print('Searching for products with query: $query');
      final allProducts = await getAllProducts();

      // Filter products by title, description, or category
      final filteredProducts = allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return filteredProducts;
    } catch (e) {
      print('Error searching products: $e');
      throw Exception('Failed to search products. Error: ${e.toString()}');
    }
  }
}
