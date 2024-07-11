import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_55/ui/screens/products/widgets/product_item.dart';

import '../../../cubits/product/product_cubit.dart';
import '../../../cubits/product/product_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => context.read<ProductCubit>().getProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(child: Text("Products aren't loaded yet."));
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          final products = (state as LoadedState).products;
          return GridView.builder(
            shrinkWrap: true,
            primary: true,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 5,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(product: product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProductCubit>().addProduct(
              id: UniqueKey().toString(),
              title: "New product",
              imageUrl:
                  "https://img.recraft.ai/7X2vwH8fjNyNYfcMLkFutQoU50UQxwxHJfOQxpNOJgg/rs:fit:1024:1024:0/q:80/g:no/plain/abs://prod/images/0bb94916-de52-4f04-b808-27d30cb9b896@avif");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
