import 'package:flutter/material.dart';
import 'widgets.dart'; // Import FilterButton jika ada di folder ini

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari produk...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        // Filter Buttons
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              FilterButton(label: 'Makanan'),
              FilterButton(label: 'Minuman'),
              FilterButton(label: 'Snack'),
            ],
          ),
        ),
      ],
    );
  }
}
