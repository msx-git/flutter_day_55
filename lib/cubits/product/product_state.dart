import '../../data/product.dart';

sealed class ProductState {}

final class InitialState extends ProductState {}

final class LoadingState extends ProductState {}

final class LoadedState extends ProductState {
  List<Product> products;

  LoadedState(this.products);
}

final class ErrorState extends ProductState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
