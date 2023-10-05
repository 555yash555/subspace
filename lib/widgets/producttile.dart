import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/newsprovider.dart';

import 'package:cached_network_image/cached_network_image.dart';

class Newstile extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final product;
  final int paginx;
  final int inx;

  const Newstile({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    required this.product,
    this.inx = 0,
    this.paginx = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          // Navigate to the detail page here, passing the necessary data.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                image: image,
                name: name,
                description: description,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: paginx == 0
                      ? () {
                          Provider.of<news_provider>(context, listen: false)
                              .addtofavourites(product);
                          print(product.title);
                          Provider.of<news_provider>(context, listen: false)
                              .savestate();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to favourites: $name'),
                            ),
                          );
                        }
                      : () {
                          Provider.of<news_provider>(context, listen: false)
                              .removefromFavourites(inx);
                          print(product.title);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('removed: $name'),
                            ),
                          );
                        },
                  child: paginx == 0
                      ? const Icon(Icons.star_border_outlined)
                      : const Icon(Icons.star),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 190, // Adjust the height as needed
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;

  const ProductDetailPage({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200, // Adjust the height as needed
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  fit: BoxFit.cover, image: CachedNetworkImageProvider(image)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Description: $description',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
