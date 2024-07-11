import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/product/product_cubit.dart';
import '../../../../data/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Options"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<ProductCubit>().deleteProduct(product.id);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<ProductCubit>().editProduct(
                          id: product.id,
                          newTitle: "newTitle",
                          newImageUrl:
                              "https://img.recraft.ai/3ysBevlX6efTaHFkTRfYX_MnySbBwhG161FbiaqtEZg/rs:fit:1024:1024:0/q:80/g:no/plain/abs://prod/images/26b9707b-3a08-4a4c-8756-1fef9cd140f9@avif",
                        );
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10)
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(product.imageUrl, height: 200),
                ),
                const Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${product.title}\n${product.id}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                context.read<ProductCubit>().toggleFavorite(product.id);
              },
              icon: product.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
    );
  }
}
