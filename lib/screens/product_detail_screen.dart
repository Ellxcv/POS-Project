import 'package:flutter/material.dart';
import 'package:pos/models/product_detail_model.dart';
import 'package:pos/widgets/addon_item.dart';
import 'package:pos/widgets/dropdown_field.dart';
import 'package:pos/widgets/quantity_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductDetailModel product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // States for dropdown and quantity
  String? selectedOption;
  String? selectedPreference;
  int addonQuantity = 0;
  int orderQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Info Box
              Container(
                width: double.infinity, // Membuat lebar selebar layar
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.product.description),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown for Options
              DropdownField(
                label: 'Opsi',
                items: widget.product.options,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Dropdown for Preferences
              DropdownField(
                label: 'Preferensi',
                items: widget.product.preferences,
                onChanged: (value) {
                  setState(() {
                    selectedPreference = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Add-On Section
              const Text(
                'Add-On',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari add-on...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Add-On List
              ListView.builder(
                shrinkWrap: true, // Agar tidak memakan seluruh tinggi layar
                physics:
                    const NeverScrollableScrollPhysics(), // Scroll mengikuti parent
                itemCount: widget.product.addons.length,
                itemBuilder: (context, index) {
                  final addon = widget.product.addons[index];
                  return AddonItem(
                    name: addon.name,
                    price: addon.price,
                    quantity: addonQuantity,
                    onIncrement: () {
                      setState(() {
                        addonQuantity++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        if (addonQuantity > 0) addonQuantity--;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Quantity Selector for Main Order
              const Text(
                'Jumlah Pesanan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              QuantitySelector(
                quantity: orderQuantity,
                onIncrement: () {
                  setState(() {
                    orderQuantity++;
                  });
                },
                onDecrement: () {
                  setState(() {
                    if (orderQuantity > 1) orderQuantity--;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Total Price Button
              ElevatedButton(
                onPressed: () {
                  // Hitung total harga
                  final total = int.parse(
                        widget.product.price.replaceAll(RegExp(r'[^\d]'), ''),
                      ) *
                      orderQuantity;

                  // Kirim data kembali ke KasirScreen
                  Navigator.pop(context, {
                    'name': widget.product.name,
                    'quantity': orderQuantity,
                    'totalPrice': total,
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'Total: Rp${(int.parse(widget.product.price.replaceAll(RegExp(r'[^\d]'), '')) * orderQuantity).toString()}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
