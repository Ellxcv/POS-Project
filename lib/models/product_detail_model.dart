import 'package:pos/models/models.dart';

class ProductDetailModel {
  final String name;
  final String description;
  final String price;
  final List<String> options; // Opsi produk
  final List<String> preferences; // Preferensi produk
  final List<Addon> addons; // Add-ons

  ProductDetailModel({
    required this.name,
    required this.description,
    required this.price,
    required this.options,
    required this.preferences,
    required this.addons,
  });
}