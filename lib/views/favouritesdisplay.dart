import 'package:digital_health_stratup_assignment/controller/newsprovider.dart';

import 'package:flutter/material.dart';
import 'package:digital_health_stratup_assignment/widgets/producttile.dart';
import 'package:provider/provider.dart';

class favouritesPage extends StatefulWidget {
  const favouritesPage({super.key});

  @override
  State<favouritesPage> createState() => _favouritesPageState();
}

class _favouritesPageState extends State<favouritesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<news_provider>(context, listen: false).getstate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: Consumer<news_provider>(
        builder: (context, productprovider, child) => productprovider
                .favourites.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: productprovider.favourites.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Newstile(
                          name: productprovider.favourites[index].id,
                          image: productprovider.favourites[index].imageUrl,
                          description: productprovider.favourites[index].title,
                          product: productprovider.favourites[index],
                          inx: index,
                          paginx: 1,
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('favourites is Empty'),
              ),
      ),
    ));
  }
}
