import 'package:flutter/material.dart';
import '../../../../../shared_widgets/common/product_grid_view.dart';
import '../../../../product/domain/models/product/product_model.dart';

class ProductSectionGridView extends StatelessWidget {
  const ProductSectionGridView({super.key, required this.section});
  final List section;

  @override
  Widget build(BuildContext context) {
    return ProductGridView(
      products: ProductList.fromJson(section).list,
      primary: false,
    );
  }
}
