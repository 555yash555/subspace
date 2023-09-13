import 'package:digital_health_stratup_assignment/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedDeliveryOption = 'Standard';
  TextEditingController addressController = TextEditingController();

  void placeOrder() {
    // Perform order placement logic here

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Placed'),
          content: const Text('Your order has been successfully placed.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // You can navigate to another screen or perform any other action
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<Product_provider>(
              builder: (context, value, child) => Text(
                'Your order total is Rs ${value.totalprice()}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Enter your shipping address',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Delivery Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'Standard',
                  groupValue: selectedDeliveryOption,
                  onChanged: (value) {
                    setState(() {
                      selectedDeliveryOption = value.toString();
                    });
                  },
                ),
                const Text('Standard'),
                Radio(
                  value: 'Express',
                  groupValue: selectedDeliveryOption,
                  onChanged: (value) {
                    setState(() {
                      selectedDeliveryOption = value.toString();
                    });
                  },
                ),
                const Text('Express'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: placeOrder,
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
