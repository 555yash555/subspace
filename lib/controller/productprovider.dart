import 'package:flutter/material.dart';
import '../models/productmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product_provider extends ChangeNotifier {
  int _total = 0;

  final List<product> _catalog = [
    product(
        name: 'Apples',
        price: 10,
        image: 'https://picsum.photos/id/100/250/250',
        description: 'A delicious and healthy fruit'),
    product(
        name: 'Bananas',
        price: 20,
        image: 'https://picsum.photos/id/101/250/250',
        description: 'A sweet and nutritious fruit'),
    product(
        name: 'Bread',
        price: 30,
        image: 'https://picsum.photos/id/102/250/250',
        description:
            'A versatile food that can be enjoyed for breakfast, lunch, or dinner'),
    product(
        name: 'Carrots',
        price: 40,
        image: 'https://picsum.photos/id/103/250/250',
        description: 'A crunchy and nutritious vegetable'),
    product(
        name: 'Eggs',
        price: 50,
        image: 'https://picsum.photos/id/104/250/250',
        description: 'A good source of protein and essential nutrients'),
    product(
        name: 'Milk',
        price: 60,
        image: 'https://picsum.photos/id/112/250/250',
        description: 'A nutritious beverage that is a good source of calcium'),
    product(
        name: 'Oranges',
        price: 70,
        image: 'https://picsum.photos/id/106/250/250',
        description: 'A citrus fruit that is a good source of vitamin C'),
    product(
        name: 'Potatoes',
        price: 80,
        image: 'https://picsum.photos/id/107/250/250',
        description:
            'A versatile vegetable that can be enjoyed in many different ways'),
    product(
        name: 'Rice',
        price: 90,
        image: 'https://picsum.photos/id/108/250/250',
        description: 'A staple grain that is a good source of carbohydrates'),
    product(
        name: 'Spinach',
        price: 10,
        image: 'https://picsum.photos/id/109/250/250',
        description:
            'A leafy green vegetable that is a good source of vitamins and minerals'),
    product(
        name: 'Tomatoes',
        price: 20,
        image: 'https://picsum.photos/id/110/250/250',
        description:
            'A versatile fruit that can be enjoyed in many different ways'),
    product(
        name: 'Water',
        price: 30,
        image: 'https://picsum.photos/id/111/250/250',
        description: 'An essential nutrient for life'),
  ];
  List<product> get catalog => _catalog;
  int get total => _total;
  List<product> _cart = [];
  List<product> get cart => _cart;
  void addtocart(product product) {
    if (product.quantity == 0) {
      product.quantity += 1;
      _cart.add(product);
    } else {
      final targetObject = _cart.firstWhere(
        (myObject) => myObject.name == product.name,
      );
      targetObject.quantity += 1;
    }
    totalprice();

    savestate();
    notifyListeners();
  }

  void removefromcart(int index) {
    _cart.elementAt(index).quantity = 0;
    _cart.removeAt(index);
    totalprice();
    savestate();
    notifyListeners();
  }

  void savestate() async {
    SharedPreferences.getInstance().then((prefs) async {
      await prefs.setStringList('cart', _cart.map((e) => e.toJson()).toList());
      print(prefs.get('cart'));
      await prefs.setInt('total', _total);
    });
  }

  void increasequantity(int index) {
    _cart.elementAt(index).quantity += 1;
    totalprice();
    savestate();
    notifyListeners();
  }

  void decreasequantity(int index) {
    _cart.elementAt(index).quantity -= 1;

    if (_cart.elementAt(index).quantity == 0) {
      removefromcart(index);
    }
    totalprice();
    savestate();
    notifyListeners();
  }

  void getstate() async {
    SharedPreferences.getInstance().then((prefs) async {
      List<String> cart = prefs.getStringList('cart') ?? [];
      print('cart hai hum $cart');
      _cart.addAll(cart.map((e) => product.fromJson(e)).toList());
      _total = prefs.getInt('total') ?? 0;
      _cart = _cart;
      notifyListeners();
    });
  }

  int totalprice() {
    _total = 0;
    for (int i = 0; i < _cart.length; i++) {
      _total = _total + _cart[i].quantity * _cart[i].price;
    }

    return _total;
  }
}
