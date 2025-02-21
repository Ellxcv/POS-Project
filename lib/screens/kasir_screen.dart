import 'package:flutter/material.dart';
import 'package:pos/widgets/widgets.dart';
import 'package:pos/models/models.dart';

class KasirScreen extends StatelessWidget {
  const KasirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data produk
    final List<ProductModel> products = [
      ProductModel(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Produk A',
        price: 'Rp10.000',
      ),
      ProductModel(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Produk B',
        price: 'Rp15.000',
      ),
      ProductModel(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Produk C',
        price: 'Rp20.000',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const SidebarMenu(),
      body: Column(
        children: [
          // Search and Filter Section
          const SearchAndFilter(),
          // List of Products
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
