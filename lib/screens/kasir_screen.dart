import 'package:flutter/material.dart';
import 'package:pos/models/models.dart';
import 'package:pos/screens/screens.dart';
import 'package:pos/widgets/widgets.dart';

class KasirScreen extends StatefulWidget {
  const KasirScreen({Key? key}) : super(key: key);

  @override
  State<KasirScreen> createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  List<Map<String, dynamic>> addedProducts =
      []; // Menyimpan produk yang ditambahkan

  int get totalPrice => addedProducts.fold(
        0,
        (sum, item) => sum + item['totalPrice'] as int,
      );

  @override
  Widget build(BuildContext context) {
    final List<ProductDetailModel> products = [
      ProductDetailModel(
        name: 'Produk A',
        description: 'Deskripsi Produk A',
        price: 'Rp10.000',
        options: ['Opsi 1', 'Opsi 2', 'Opsi 3'],
        preferences: ['Preferensi 1', 'Preferensi 2'],
        addons: [
          Addon(name: 'Addon A', price: 'Rp2.000'),
          Addon(name: 'Addon B', price: 'Rp3.000'),
        ],
      ),
      ProductDetailModel(
        name: 'Produk B',
        description: 'Deskripsi Produk b',
        price: 'Rp15.000',
        options: ['Opsi 1', 'Opsi 2', 'Opsi 3'],
        preferences: ['Preferensi 1', 'Preferensi 2'],
        addons: [
          Addon(name: 'Addon A', price: 'Rp2.000'),
          Addon(name: 'Addon B', price: 'Rp3.000'),
        ],
      ),
      // Produk lainnya...
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
          const SearchAndFilter(),

          // Daftar Produk
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: product,
                        ),
                      ),
                    );

                    // Tambahkan produk ke daftar jika result ada
                    if (result != null) {
                      setState(() {
                        addedProducts.add(result);
                      });
                    }
                  },
                  child: ProductItem(
                    product: ProductModel(
                      imageUrl: 'https://via.placeholder.com/150',
                      name: product.name,
                      price: product.price,
                    ),
                  ),
                );
              },
            ),
          ),

          // Tombol Total Harga
          // Tombol Total Harga
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (addedProducts.isEmpty) {
                  // Tampilkan pesan jika tidak ada produk yang ditambahkan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tidak ada produk yang ditambahkan.'),
                    ),
                  );
                  return;
                }

                // Pindah ke CheckoutScreen dengan data addedProducts
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(orders: addedProducts),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                minimumSize: const Size(double.infinity, 50), // Lebar penuh
              ),
              child: Text(
                'Total Harga: Rp$totalPrice',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
