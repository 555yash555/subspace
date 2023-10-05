import 'package:digital_health_stratup_assignment/controller/newsprovider.dart';
import 'package:digital_health_stratup_assignment/views/favouritesdisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockProductProvider extends news_provider {}

void main() {
  group('favouritesPage widget', () {
    testWidgets('displays favourites contents', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'favourites': [
          product(
            name: 'Test Product',
            image: 'test_image.png',
            price: 10,
            description: 'This is a test product',
            quantity: 1,
          ).toJson(),
        ],
      });
      final mockProvider = MockProductProvider();
      await mockProvider.getstate();
      await mockNetworkImagesFor(() async => await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<news_provider>.value(
                  value: mockProvider,
                ),
              ],
              child: const MaterialApp(
                home: favouritesPage(),
              ),
            ),
          ));

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Proceed to checkout'), findsOneWidget);

      // expect(find.text('This is a test product'), findsOneWidget);
      // expect(find.text('\$100'), findsOneWidget);
      // expect(find.text('Total: \$100'), findsOneWidget);
    });

    testWidgets('navigates to checkout page', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'favourites': [
          product(
            name: 'Test Product',
            image: 'test_image.png',
            price: 10,
            description: 'This is a test product',
            quantity: 1,
          ).toJson(),
        ],
      });
      final mockProvider = MockProductProvider();
      await mockProvider.getstate();
      await mockNetworkImagesFor(() async => await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<news_provider>.value(
                  value: mockProvider,
                ),
              ],
              child: const MaterialApp(
                home: favouritesPage(),
              ),
            ),
          ));
      await tester
          .tap(find.widgetWithText(ElevatedButton, 'Proceed to checkout'));
      await tester.pumpAndSettle();
      expect(find.text('Checkout Page'), findsOneWidget);
    });
  });
}
