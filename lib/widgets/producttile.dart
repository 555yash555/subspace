import 'package:digital_health_stratup_assignment/controller/productprovider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProductInfoTile extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final String description;
  final product;
  final int inx;
  final paginx;

  const ProductInfoTile(
      {super.key,
      required this.name,
      required this.image,
      required this.price,
      required this.description,
      required this.product,
      this.inx = 0,
      this.paginx = 0});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Price: Rs.${price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Description: $description',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: paginx == 0
                        ? () {
                            Provider.of<Product_provider>(context,
                                    listen: false)
                                .addtocart(product);
                            print(product.name);
                            Provider.of<Product_provider>(context,
                                    listen: false)
                                .savestate();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added to Cart: $name'),
                              ),
                            );
                          }
                        : () {
                            Provider.of<Product_provider>(context,
                                    listen: false)
                                .removefromcart(inx);
                            print(product.name);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('removed: $name'),
                              ),
                            );
                          },
                    child: Text(paginx == 0 ? 'Add to Cart' : 'Remove'),
                  ),
                ),
                paginx == 0
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  Provider.of<Product_provider>(context,
                                          listen: false)
                                      .decreasequantity(inx);
                                },
                              ),
                              Text(
                                '${product.quantity}',
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  Provider.of<Product_provider>(context,
                                          listen: false)
                                      .increasequantity(inx);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
