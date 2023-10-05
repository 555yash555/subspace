import 'package:digital_health_stratup_assignment/controller/newsprovider.dart';

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
  void initState() {
    super.initState();
    Provider.of<news_provider>(context, listen: false).fetchBlogs(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('SUBSPACE'),
      ),
      body: Consumer<news_provider>(
          builder: (context, productprovider, child) =>
              productprovider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : productprovider.catalog.isNotEmpty
                      ? ListView.builder(
                          itemCount: productprovider.catalog.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Newstile(
                              name: productprovider.catalog[index].id,
                              image: productprovider.catalog[index].imageUrl,
                              description: productprovider.catalog[index].title,
                              product: productprovider.catalog[index],
                            );
                          },
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_off,
                              size: 64.0,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'No internet connection available',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Please check your favorites offline',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )),
    ));
  }
}
