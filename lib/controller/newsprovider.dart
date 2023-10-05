import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/productmodel.dart';

class news_provider extends ChangeNotifier {
  final List<Product> _catalog = [];
  List<Product> get catalog => _catalog;

  final List<Product> _favourites = [];
  List<Product> get favourites => _favourites;

  bool isLoading = true;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showErrorMessage(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void fetchBlogs(BuildContext context) async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final List<dynamic> blogDataList = jsonData['blogs'];

        final products = blogDataList
            .map((data) => Product(
                  id: data['id'].toString(),
                  imageUrl: data['image_url'].toString(),
                  title: data['title'].toString(),
                ))
            .toList();
        print(products);

        _catalog.clear();
        _catalog.addAll(products);
        isLoading = false;
        notifyListeners();
      } else {
        // Request failed
        final errorMessage =
            'Request failed with status code: ${response.statusCode}';
        showErrorMessage(errorMessage, context);
        print(errorMessage);
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      final errorMessage = 'Error: $e';
      showErrorMessage(errorMessage, context);
      print(errorMessage);
      isLoading = false;
      notifyListeners();
    }
  }

  // Methods for managing the favourites and total
  void addtofavourites(Product product) {
    if (!_favourites.contains(product)) {
      _favourites.add(product);
    }

    savestate();
    notifyListeners();
  }

  void removefromFavourites(int index) {
    _favourites.removeAt(index);

    savestate();
    notifyListeners();
  }

  void savestate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favourites', _favourites.map((e) => e.toJson()).toList());
  }

  Future<void> getstate() async {
    final prefs = await SharedPreferences.getInstance();
    final favourites = prefs.getStringList('favourites') ?? [];
    _favourites.clear();
    _favourites.addAll(favourites.map((e) => Product.fromJson(e)).toList());

    notifyListeners();
  }
}
