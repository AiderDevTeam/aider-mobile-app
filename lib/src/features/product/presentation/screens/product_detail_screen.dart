import 'package:aider_mobile_app/src/features/product/domain/models/product/product_model.dart';
import 'package:flutter/material.dart';
import '../widgets/product_details_body.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return ProductDetailsBody(
      product: product,
    );
  }
}
