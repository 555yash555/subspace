import 'package:digital_health_stratup_assignment/controller/productprovider.dart';

import 'package:flutter/material.dart';
import 'package:digital_health_stratup_assignment/widgets/producttile.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Store'),
      ),
      body: Consumer<Product_provider>(
        builder: (context, productprovider, child) => ListView.builder(
          itemCount: productprovider.catalog.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductInfoTile(
              name: productprovider.catalog[index].name,
              image: productprovider.catalog[index].image,
              price: productprovider.catalog[index].price,
              description: productprovider.catalog[index].description,
              product: productprovider.catalog[index],
            );
          },
        ),
      ),
    ));
  }
}
