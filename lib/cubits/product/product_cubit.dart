import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/product.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialState());
  List<Product> products = [];

  Future<void> getProducts() async {
    try {
      emit(LoadingState());

      await Future.delayed(const Duration(seconds: 1));

      /// Adding initial products for demonstration
      products.add(
        Product(
          id: UniqueKey().toString(),
          title: "SK400 Speakers",
          imageUrl:
              "https://m.media-amazon.com/images/I/81b1vgAABmL._AC_UF1000,1000_QL80_.jpg",
        ),
      );

      emit(LoadedState(products));
    } catch (e) {
      emit(ErrorState(errorMessage: "Couldn't get products."));
    }
  }

  Future<void> addProduct({
    required String id,
    required String title,
    required String imageUrl,
  }) async {
    try {
      if (state is LoadedState) {
        products = (state as LoadedState).products;
      }

      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 1));
      // await productsHttpService.getProducts();

      products.add(Product(
        id: id,
        title: title,
        imageUrl: imageUrl,
      ));
      emit(LoadedState(products));
    } catch (e) {
      emit(ErrorState(errorMessage: "Couldn't add the product."));
    }
  }

  toggleFavorite(String id) {
    for (var product in (state as LoadedState).products) {
      if (product.id == id) {
        product.isFavorite = !product.isFavorite;
        emit(LoadedState(products));
        break;
      }
    }
  }

  deleteProduct(String id) {
    products.removeWhere((product) => product.id == id);
    emit(LoadedState(products));
  }

  editProduct({
    required String id,
    required String newTitle,
    required String newImageUrl,
  }) {
    for (var product in (state as LoadedState).products) {
      if (product.id == id) {
        product.title = newTitle;
        product.imageUrl = newImageUrl;
        emit(LoadedState(products));
        break;
      }
    }
  }
}
