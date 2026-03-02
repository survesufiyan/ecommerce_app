import 'package:flutter/material.dart';

class AddressModel {
  String label;
  String address;
  String phone;

  AddressModel({
    required this.label,
    required this.address,
    required this.phone,
  });
}

class CardModel {
  String type;
  String number;
  String expiry;
  String holder;
  Color color;

  CardModel({
    required this.type,
    required this.number,
    required this.expiry,
    required this.holder,
    required this.color,
  });
}

class UserProvider extends ChangeNotifier {
  String name = 'Guest User';
  String email = 'guestuser@shophub.com';
  String phone = '';

  List<AddressModel> addresses = [
    AddressModel(
      label: 'Home',
      address: '123 Main Street, Apt 4B\nMumbai, Maharashtra 400001',
      phone: '+91 98765 43210',
    ),
    AddressModel(
      label: 'Work',
      address: '456 Business Park, Tower A\nMumbai, Maharashtra 400051',
      phone: '+91 98765 43211',
    ),
  ];

  List<CardModel> cards = [
    CardModel(
      type: 'Visa',
      number: '**** **** **** 4242',
      expiry: '12/26',
      holder: 'Guest User',
      color: const Color(0xFFFF6B35),
    ),
    CardModel(
      type: 'Mastercard',
      number: '**** **** **** 8888',
      expiry: '08/25',
      holder: 'Guest User',
      color: const Color(0xFF4ECDC4),
    ),
  ];

  int selectedCardIndex = 0;

  void updateProfile({
    required String newName,
    required String newEmail,
    required String newPhone,
  }) {
    name = newName;
    email = newEmail;
    phone = newPhone;
    notifyListeners();
  }

  void addAddress(AddressModel address) {
    addresses.add(address);
    notifyListeners();
  }

  void updateAddress(int index, AddressModel address) {
    addresses[index] = address;
    notifyListeners();
  }

  void removeAddress(int index) {
    addresses.removeAt(index);
    notifyListeners();
  }

  void addCard(CardModel card) {
    cards.add(card);
    notifyListeners();
  }

  void removeCard(int index) {
    cards.removeAt(index);
    if (selectedCardIndex >= cards.length) {
      selectedCardIndex = cards.isEmpty ? 0 : cards.length - 1;
    }
    notifyListeners();
  }

  void selectCard(int index) {
    selectedCardIndex = index;
    notifyListeners();
  }
}
