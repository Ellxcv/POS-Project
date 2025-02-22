import 'package:flutter/material.dart';
import 'package:pos/models/models.dart';
import 'package:pos/screens/screens.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orders; // Data pesanan yang diterima
  const CheckoutScreen({Key? key, required this.orders}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late List<Map<String, dynamic>> orders;

  @override
  void initState() {
    super.initState();
    orders = widget.orders; // Inisialisasi data pesanan
  }

  // Fungsi untuk menghitung total harga
  int get totalPrice =>
      orders.fold(0, (sum, order) => sum + order['totalPrice'] as int);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Nama Customer
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nama Customer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama customer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Detail Pesanan
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Produk, Jumlah, dan Harga
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${order['name']} x${order['quantity']}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rp${order['totalPrice']}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Opsi, Preferensi, dan Add-on
                          if (order['option'] != null)
                            Text('Opsi: ${order['option']}'),
                          if (order['preference'] != null)
                            Text('Preferensi: ${order['preference']}'),
                          if (order['addons'] != null &&
                              order['addons'].isNotEmpty)
                            Text('Add-ons: ${order['addons'].join(", ")}'),
                          const SizedBox(height: 8),

                          // Quantity Selector
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (order['quantity'] > 1) {
                                          order['quantity']--;
                                          order['totalPrice'] -=
                                              order['unitPrice'];
                                        }
                                      });
                                    },
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                  ),
                                  Text(
                                    '${order['quantity']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        order['quantity']++;
                                        order['totalPrice'] +=
                                            order['unitPrice'];
                                      });
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                  ),
                                ],
                              ),

                              // Tombol Edit
                              ElevatedButton(
                                onPressed: () {
                                  // Pastikan 'order['product']' adalah instance dari ProductDetailModel
                                  final product = ProductDetailModel(
                                    name: order['name'],
                                    description:
                                        'Deskripsi produk', // Tambahkan deskripsi sesuai data Anda
                                    price: 'Rp${order['unitPrice']}',
                                    options: order['options'] ?? [],
                                    preferences: order['preferences'] ?? [],
                                    addons: order['addons'] ?? [],
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreen(product: product),
                                    ),
                                  );
                                },
                                child: const Text('Edit'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Tombol Voucher dan Checkout
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logika untuk voucher
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Voucher',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logika untuk checkout
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checkout berhasil!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
