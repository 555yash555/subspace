import 'package:digital_health_stratup_assignment/controller/newsprovider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('news_provider', () {
    news_provider provider;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();
    });

    test('initial state', () {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();
      expect(provider.catalog.length, 12);
      expect(provider.favourites.length, 0);
      expect(provider.total, 0);
    });

    test('add to favourites', () {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();
      final product = provider.catalog.first;
      provider.addtofavourites(product);
      expect(provider.favourites.length, 1);
      expect(provider.favourites.first, product);
      expect(provider.total, product.price);
    });

    test('add to favourites with existing product', () {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();
      final product = provider.catalog.first;
      provider.addtofavourites(product);
      provider.addtofavourites(product);
      expect(provider.favourites.length, 1);
      expect(provider.favourites.first, product);
      expect(provider.favourites.first.quantity, 2);
      expect(provider.total, product.price * 2);
    });

    test('remove from favourites', () {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();
      final product = provider.catalog.first;
      provider.addtofavourites(product);
      provider.removefromFavourites(0);
      expect(provider.favourites.length, 0);
      expect(provider.total, 0);
    });

    test('increase quantity', () {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();
      final pro = product(name: '', image: '', price: 2, description: '');
      provider.addtofavourites(pro);
      provider.increasequantity(0);
      expect(provider.favourites.first.quantity, 2);
      expect(provider.total, pro.price * 2);
    });

    test('decrease quantity', () async {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();
      final product = provider.catalog.first;
      provider.addtofavourites(product);
      provider.increasequantity(0);
      provider.decreasequantity(0);
      expect(provider.favourites.first.quantity, 1);
      provider.decreasequantity(0);
      expect(provider.favourites.length, 0);
      expect(provider.total, 0);
    });

    test('total price', () {
      SharedPreferences.setMockInitialValues({});
      provider = news_provider();
      provider.getstate();

      final product1 = provider.catalog.first;
      final product2 = provider.catalog.last;
      provider.addtofavourites(product1);
      provider.addtofavourites(product2);
      expect(provider.total, product1.price + product2.price);
    });
  });
}
