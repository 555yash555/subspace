import 'package:digital_health_stratup_assignment/controller/productprovider.dart';
import 'package:digital_health_stratup_assignment/views/checkout.dart';

import 'package:flutter/material.dart';
import 'package:digital_health_stratup_assignment/widgets/producttile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Product_provider>(context, listen: false).getstate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Store'),
      ),
      body: Consumer<Product_provider>(
        builder: (context, productprovider, child) => productprovider
                .cart.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: productprovider.cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductInfoTile(
                          name: productprovider.cart[index].name,
                          image: productprovider.cart[index].image,
                          price: productprovider.cart[index].price,
                          description: productprovider.cart[index].description,
                          product: productprovider.cart[index],
                          inx: index,
                          paginx: 1,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const CheckoutPage());
                        productprovider.totalprice();
                      },
                      child: const Text('Proceed to checkout'),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('Cart is Empty'),
              ),
      ),
    ));
  }
}
